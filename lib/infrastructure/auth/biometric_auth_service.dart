import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart' as local_auth;
import 'dart:developer' as dev;

/// Service pour gérer l'authentification biométrique
class BiometricAuthService {
  final local_auth.LocalAuthentication _localAuth =
      local_auth.LocalAuthentication();

  /// Vérifie si l'authentification biométrique est disponible sur l'appareil
  Future<bool> isBiometricAvailable() async {
    try {
      // Vérifie si le matériel prend en charge la biométrie
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      return canAuthenticate;
    } catch (e) {
      dev.log(
        'Erreur lors de la vérification de la biométrie',
        name: 'BiometricAuthService.isBiometricAvailable',
        error: e,
        level: 1000,
      );
      return false;
    }
  }

  /// Récupère les types de biométrie disponibles sur l'appareil
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
        'Erreur lors de la récupération des biométries',
        name: 'BiometricAuthService.getAvailableBiometrics',
        error: e,
        level: 1000,
      );
      return [];
    }
  }

  /// Authentifie l'utilisateur avec la biométrie
  Future<AuthResult> authenticate({
    String localizedReason =
        "Veuillez vous authentifier pour accéder à l'application",
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
          message: 'Authentification annulée ou échouée',
        );
      }
    } on PlatformException catch (e) {
      return _handlePlatformException(e);
    } catch (e) {
      return AuthResult(
        success: false,
        status: AuthStatus.failed,
        message: 'Erreur inattendue: $e',
      );
    }
  }

  /// Traite les exceptions spécifiques à la plateforme
  AuthResult _handlePlatformException(PlatformException exception) {
    dev.log(
      "Erreur d'authentification: ${exception.code} - ${exception.message}",
      name: 'BiometricAuthService._handlePlatformException',
      error: exception,
      level: 900, // Error level for platform exceptions
    );

    switch (exception.code) {
      case auth_error.notAvailable:
        return AuthResult(
          success: false,
          status: AuthStatus.unavailable,
          message: "La biométrie n'est pas disponible sur cet appareil",
        );
      case auth_error.notEnrolled:
        return AuthResult(
          success: false,
          status: AuthStatus.notSetUp,
          message: "Aucune biométrie n'est enregistrée sur cet appareil",
        );
      case auth_error.lockedOut:
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message: 'Trop de tentatives échouées, veuillez réessayer plus tard',
        );
      case auth_error.permanentlyLockedOut:
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message:
              "L'appareil est verrouillé de façon permanente. Veuillez le déverrouiller avec votre code PIN/Pattern/Mot de passe",
        );
      default:
        return AuthResult(
          success: false,
          status: AuthStatus.failed,
          message: 'Erreur: ${exception.message}',
        );
    }
  }
}

/// Résultat d'une authentification biométrique
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
