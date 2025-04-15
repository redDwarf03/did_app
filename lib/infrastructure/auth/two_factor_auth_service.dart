import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service pour gérer l'authentification à deux facteurs
class TwoFactorAuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _otpStorageKey = 'otp_code';
  final String _otpExpiryKey = 'otp_expiry';
  final String _emailKey = 'otp_email';

  /// Génère et envoie un code OTP à l'adresse email spécifiée
  Future<bool> sendOtp(String email) async {
    try {
      // Générer un code OTP aléatoire à 6 chiffres
      final code = _generateOtpCode();

      // Définir une expiration (10 minutes à partir de maintenant)
      final expiry = DateTime.now().add(const Duration(minutes: 10));

      // Stocker le code et son expiration de manière sécurisée
      await _secureStorage.write(key: _otpStorageKey, value: code);
      await _secureStorage.write(
        key: _otpExpiryKey,
        value: expiry.millisecondsSinceEpoch.toString(),
      );
      await _secureStorage.write(key: _emailKey, value: email);

      // Dans une implémentation réelle, cette fonction enverrait le code par email
      // en utilisant un service d'envoi d'emails (SendGrid, Mailgun, etc.)
      if (kDebugMode) {
        dev.log(
          'Code OTP envoyé à $email: $code',
          name: 'TwoFactorAuthService.sendOtp',
        );
      }

      return true;
    } catch (e) {
      dev.log(
        'Erreur l\'envoi du code OTP',
        name: 'TwoFactorAuthService.sendOtp',
        error: e,
        level: 1000,
      );
      return false;
    }
  }

  /// Vérifie si un code OTP est valide
  Future<OtpVerificationResult> verifyOtp(String code) async {
    try {
      // Récupérer le code stocké et son expiration
      final storedCode = await _secureStorage.read(key: _otpStorageKey);
      final expiryString = await _secureStorage.read(key: _otpExpiryKey);

      // Si aucun code n'est stocké
      if (storedCode == null || expiryString == null) {
        return OtpVerificationResult(
          isValid: false,
          message: 'Aucun code OTP en attente de validation',
        );
      }

      // Vérifier l'expiration
      final expiry =
          DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
      if (DateTime.now().isAfter(expiry)) {
        return OtpVerificationResult(
          isValid: false,
          message: 'Le code OTP a expiré',
          isExpired: true,
        );
      }

      // Vérifier le code
      if (code == storedCode) {
        return OtpVerificationResult(
          isValid: true,
          message: 'Code OTP validé avec succès',
        );
      } else {
        return OtpVerificationResult(
          isValid: false,
          message: 'Code OTP invalide',
        );
      }
    } catch (e) {
      dev.log(
        'Erreur lors de la vérification du code OTP',
        name: 'TwoFactorAuthService.verifyOtp',
        error: e,
        level: 1000,
      );
      return OtpVerificationResult(
        isValid: false,
        message: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Efface le code OTP après une validation réussie
  Future<void> clearOtp() async {
    await _secureStorage.delete(key: _otpStorageKey);
    await _secureStorage.delete(key: _otpExpiryKey);
  }

  /// Récupère l'email associé au dernier code OTP envoyé
  Future<String?> getOtpEmail() async {
    return _secureStorage.read(key: _emailKey);
  }

  /// Génère un code OTP aléatoire à 6 chiffres
  String _generateOtpCode() {
    final random = Random.secure();
    return (100000 + random.nextInt(900000)).toString();
  }
}

/// Résultat de la vérification d'un code OTP
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
