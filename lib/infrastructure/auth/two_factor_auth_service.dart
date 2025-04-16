import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service to manage two-factor authentication
class TwoFactorAuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _otpStorageKey = 'otp_code';
  final String _otpExpiryKey = 'otp_expiry';
  final String _emailKey = 'otp_email';

  /// Generates and sends an OTP code to the specified email address
  Future<bool> sendOtp(String email) async {
    try {
      // Generate a random 6-digit OTP code
      final code = _generateOtpCode();

      // Set an expiration (10 minutes from now)
      final expiry = DateTime.now().add(const Duration(minutes: 10));

      // Store the code and its expiration securely
      await _secureStorage.write(key: _otpStorageKey, value: code);
      await _secureStorage.write(
        key: _otpExpiryKey,
        value: expiry.millisecondsSinceEpoch.toString(),
      );
      await _secureStorage.write(key: _emailKey, value: email);

      // In a real implementation, this function would send the code via email
      // using an email sending service (SendGrid, Mailgun, etc.)
      if (kDebugMode) {
        dev.log(
          'OTP code sent to $email: $code',
          name: 'TwoFactorAuthService.sendOtp',
        );
      }

      return true;
    } catch (e) {
      dev.log(
        'Error sending OTP code',
        name: 'TwoFactorAuthService.sendOtp',
        error: e,
        level: 1000,
      );
      return false;
    }
  }

  /// Verifies if an OTP code is valid
  Future<OtpVerificationResult> verifyOtp(String code) async {
    try {
      // Retrieve the stored code and its expiration
      final storedCode = await _secureStorage.read(key: _otpStorageKey);
      final expiryString = await _secureStorage.read(key: _otpExpiryKey);

      // If no code is stored
      if (storedCode == null || expiryString == null) {
        return OtpVerificationResult(
          isValid: false,
          message: 'No pending OTP code for validation',
        );
      }

      // Check expiration
      final expiry =
          DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
      if (DateTime.now().isAfter(expiry)) {
        return OtpVerificationResult(
          isValid: false,
          message: 'OTP code has expired',
          isExpired: true,
        );
      }

      // Verify the code
      if (code == storedCode) {
        return OtpVerificationResult(
          isValid: true,
          message: 'OTP code validated successfully',
        );
      } else {
        return OtpVerificationResult(
          isValid: false,
          message: 'Invalid OTP code',
        );
      }
    } catch (e) {
      dev.log(
        'Error during OTP code verification',
        name: 'TwoFactorAuthService.verifyOtp',
        error: e,
        level: 1000,
      );
      return OtpVerificationResult(
        isValid: false,
        message: 'Verification error: $e',
      );
    }
  }

  /// Clears the OTP code after successful validation
  Future<void> clearOtp() async {
    await _secureStorage.delete(key: _otpStorageKey);
    await _secureStorage.delete(key: _otpExpiryKey);
  }

  /// Retrieves the email associated with the last sent OTP code
  Future<String?> getOtpEmail() async {
    return _secureStorage.read(key: _emailKey);
  }

  /// Generates a random 6-digit OTP code
  String _generateOtpCode() {
    final random = Random.secure();
    return (100000 + random.nextInt(900000)).toString();
  }
}

/// Result of the OTP code verification
class OtpVerificationResult {
  OtpVerificationResult({
    required this.isValid,
    required this.message,
    this.isExpired = false,
  });
  final bool isValid;
  final String message;
  final bool isExpired;
}
