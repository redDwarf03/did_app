import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart' as local_auth;
import 'dart:developer' as dev;

/// Service for handling biometric authentication
class BiometricAuthService {
  final local_auth.LocalAuthentication _localAuth =
      local_auth.LocalAuthentication();

  /// Checks if biometric authentication is available on the device
  Future<bool> isBiometricAvailable() async {
    try {
      // Check if the hardware supports biometrics
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      return canAuthenticate;
    } catch (e) {
      dev.log(
        'Error retrieving biometrics',
        name: 'BiometricAuthService.isBiometricAvailable',
        error: e,
        level: 1000,
      );
      return false;
    }
  }

  /// Retrieves the available biometric types on the device
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final availableBiometrics = await _localAuth.getAvailableBiometrics();

      return availableBiometrics.map((type) {
        if (type == local_auth.BiometricType.fingerprint) {
          return BiometricType.fingerprint;
        } else if (type == local_auth.BiometricType.face) {
          return BiometricType.faceId;
        } else if (type == local_auth.BiometricType.iris) {
          return BiometricType.iris;
        } else {
          return BiometricType.none;
        }
      }).toList();
    } catch (e) {
      dev.log(
        'Error retrieving biometrics',
        name: 'BiometricAuthService.getAvailableBiometrics',
        error: e,
        level: 1000,
      );
      return [];
    }
  }

  /// Authenticates the user with biometrics
  Future<AuthResult> authenticate({
    String localizedReason = "Please authenticate to access the application",
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: local_auth.AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
        ),
      );

      if (didAuthenticate) {
        return AuthResult(
          success: true,
          status: AuthStatus.authenticated,
        );
      } else {
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message: 'Authentication cancelled or failed',
        );
      }
    } on PlatformException catch (e) {
      return _handlePlatformException(e);
    } catch (e) {
      return AuthResult(
        success: false,
        status: AuthStatus.failed,
        message: 'Unexpected error: $e',
      );
    }
  }

  /// Handles platform-specific exceptions
  AuthResult _handlePlatformException(PlatformException exception) {
    dev.log(
      "Authentication error: ${exception.code} - ${exception.message}",
      name: 'BiometricAuthService._handlePlatformException',
      error: exception,
      level: 900, // Error level for platform exceptions
    );

    switch (exception.code) {
      case auth_error.notAvailable:
        return AuthResult(
          success: false,
          status: AuthStatus.unavailable,
          message: "Biometrics are not available on this device",
        );
      case auth_error.notEnrolled:
        return AuthResult(
          success: false,
          status: AuthStatus.notSetUp,
          message: "No biometrics enrolled on this device",
        );
      case auth_error.lockedOut:
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message: 'Too many failed attempts, please try again later',
        );
      case auth_error.permanentlyLockedOut:
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message:
              "The device is permanently locked. Please unlock it using your PIN/Pattern/Password",
        );
      default:
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message: 'Error: ${exception.message}',
        );
    }
  }
}

/// Result of a biometric authentication
class AuthResult {
  AuthResult({
    required this.success,
    required this.status,
    this.message,
  });
  final bool success;
  final AuthStatus status;
  final String? message;
}
