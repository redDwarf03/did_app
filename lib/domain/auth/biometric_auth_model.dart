import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_auth_model.freezed.dart';
part 'biometric_auth_model.g.dart';

/// Types d'authentification biométrique disponibles
enum BiometricType {
  /// Empreinte digitale
  fingerprint,

  /// Reconnaissance faciale
  faceId,

  /// Scan de l'iris
  iris,

  /// Non disponible
  none
}

/// Statut du processus d'authentification
enum AuthStatus {
  /// Authentification non initiée
  notAuthenticated,

  /// Authentification en cours
  authenticating,

  /// Authentification réussie
  authenticated,

  /// Authentification échouée
  failed,

  /// Authentification non disponible sur l'appareil
  unavailable,

  /// Authentification non configurée
  notSetUp
}

/// Modèle pour l'authentification biométrique
@freezed
class BiometricAuthState with _$BiometricAuthState {
  const factory BiometricAuthState({
    /// Types de biométrie disponibles sur l'appareil
    @Default([]) List<BiometricType> availableBiometrics,

    /// Type de biométrie actuellement utilisé
    @Default(BiometricType.none) BiometricType currentBiometricType,

    /// Statut de l'authentification
    @Default(AuthStatus.notAuthenticated) AuthStatus status,

    /// Message d'erreur éventuel
    String? errorMessage,

    /// Si l'authentification biométrique est activée
    @Default(false) bool isBiometricEnabled,

    /// Si l'authentification à deux facteurs est activée
    @Default(false) bool isTwoFactorEnabled,

    /// Si l'authentification sans mot de passe est activée
    @Default(false) bool isPasswordlessEnabled,
  }) = _BiometricAuthState;

  /// Création depuis un JSON
  factory BiometricAuthState.fromJson(Map<String, dynamic> json) =>
      _$BiometricAuthStateFromJson(json);
}
