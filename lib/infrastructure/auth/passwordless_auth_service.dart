import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Service for managing passwordless authentication.
class PasswordlessAuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token';
  final String _tokenExpiryKey = 'auth_token_expiry';
  final String _emailKey = 'auth_email';

  // Base URL for magic links (replace with your actual URL)
  final String _baseUrl = 'https://yourapp.com/auth';

  /// Generates a magic link for passwordless authentication.
  Future<String> generateMagicLink(String email) async {
    try {
      // Generate a unique token
      final token = _generateToken();

      // Set an expiration time (15 minutes)
      final expiry = DateTime.now().add(const Duration(minutes: 15));

      // Store the token and its expiration
      await _secureStorage.write(key: _tokenKey, value: token);
      await _secureStorage.write(
        key: _tokenExpiryKey,
        value: expiry.millisecondsSinceEpoch.toString(),
      );
      await _secureStorage.write(key: _emailKey, value: email);

      // Create the magic link
      final magicLink =
          '$_baseUrl?token=$token&email=${Uri.encodeComponent(email)}';

      // In a real implementation, this link would be sent via email
      if (kDebugMode) {
        dev.log(
          'Magic link generated for $email: $magicLink',
          name: 'PasswordlessAuthService.generateMagicLink',
        );
      }

      return magicLink;
    } catch (e) {
      dev.log(
        'Error generating magic link',
        name: 'PasswordlessAuthService.generateMagicLink',
        error: e,
        level: 1000, // Severe level
      );
      rethrow;
    }
  }

  /// Verifies an authentication token.
  Future<AuthVerificationResult> verifyToken(String token, String email) async {
    try {
      // Retrieve the stored token and its expiration
      final storedToken = await _secureStorage.read(key: _tokenKey);
      final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
      final storedEmail = await _secureStorage.read(key: _emailKey);

      // If no token is stored
      if (storedToken == null || expiryString == null || storedEmail == null) {
        return AuthVerificationResult(
          isValid: false,
          message: "No pending authentication token",
        );
      }

      // Check if the email matches
      if (email != storedEmail) {
        return AuthVerificationResult(
          isValid: false,
          message: "Email does not match",
        );
      }

      // Check expiration
      final expiry =
          DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
      if (DateTime.now().isAfter(expiry)) {
        return AuthVerificationResult(
          isValid: false,
          message: 'Link has expired',
          isExpired: true,
        );
      }

      // Verify the token
      if (token == storedToken) {
        // Generate a JWT for session authentication
        final sessionToken = _generateJwt(email);

        return AuthVerificationResult(
          isValid: true,
          message: 'Authentication successful',
          token: sessionToken,
        );
      } else {
        return AuthVerificationResult(
          isValid: false,
          message: "Invalid authentication token",
        );
      }
    } catch (e) {
      dev.log(
        'Error verifying token',
        name: 'PasswordlessAuthService.verifyToken',
        error: e,
        level: 1000, // Severe level
      );
      return AuthVerificationResult(
        isValid: false,
        message: 'Verification error: $e',
      );
    }
  }

  /// Clears the token after successful authentication.
  Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _tokenExpiryKey);
  }

  /// Generates a secure random token.
  String _generateToken() {
    const uuid = Uuid();
    final random = Random.secure();
    final randomInt = random.nextInt(1000000);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final rawToken = '$timestamp-$randomInt-${uuid.v4()}';
    final bytes = utf8.encode(rawToken);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  /// Generates a simplified JWT for session authentication.
  /// Note: In a real implementation, use a complete JWT library.
  String _generateJwt(String email) {
    // Create the header
    final header = {'alg': 'HS256', 'typ': 'JWT'};

    // Create the payload
    final payload = {
      'sub': email,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp':
          DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch ~/
              1000,
    };

    // Base64 encode the header and payload
    final encodedHeader = base64Url.encode(utf8.encode(jsonEncode(header)));
    final encodedPayload = base64Url.encode(utf8.encode(jsonEncode(payload)));

    // In a real implementation, we would actually sign the JWT with a secret key
    // For this demo, use a fixed secret
    const secret = 'your_very_long_and_complex_secret';
    final data = '$encodedHeader.$encodedPayload';
    final bytes = utf8.encode(data + secret);
    final signature = base64Url.encode(sha256.convert(bytes).bytes);

    // Assemble the JWT
    return '$encodedHeader.$encodedPayload.$signature';
  }

  /// Checks if the user is already authenticated.
  Future<bool> isAuthenticated() async {
    try {
      final token = await _secureStorage.read(key: 'session_token');
      if (token == null) return false;

      // In a real implementation, we would verify if the JWT is valid
      // For this demo, assume it is valid
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Saves the session token.
  Future<void> saveSessionToken(String token) async {
    await _secureStorage.write(key: 'session_token', value: token);
  }
}

/// Result of an authentication verification.
class AuthVerificationResult {
  AuthVerificationResult({
    required this.isValid,
    required this.message,
    this.isExpired = false,
    this.token,
  });
  final bool isValid;
  final String message;
  final bool isExpired;
  final String? token;
}
