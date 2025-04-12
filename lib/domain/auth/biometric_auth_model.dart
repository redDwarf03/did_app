import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_auth_model.freezed.dart';
part 'biometric_auth_model.g.dart';

/// Enumerates the types of biometric authentication methods available on a device.
///
/// Biometric authentication can contribute to achieving higher Levels of Assurance (LOA)
/// as defined in frameworks like NIST 800-63-3, eIDAS, and ISO/IEC 29115,
/// and can be a factor in Strong Customer Authentication (SCA) under PSD2.
/// See: W3C DID Spec §9.17 Level of Assurance.
enum BiometricType {
  /// Authentication using fingerprint recognition.
  fingerprint,

  /// Authentication using facial recognition (e.g., Apple's Face ID).
  faceId,

  /// Authentication using iris scanning.
  iris,

  /// No biometric authentication method is available or selected.
  none
}

/// Represents the status of a biometric authentication attempt or configuration.
enum AuthStatus {
  /// Authentication has not been initiated or attempted yet.
  notAuthenticated,

  /// Authentication process is currently in progress.
  authenticating,

  /// Authentication was successful.
  authenticated,

  /// Authentication attempt failed (e.g., biometric mismatch, timeout, user cancellation).
  failed,

  /// Biometric authentication is not available on this device.
  unavailable,

  /// Biometric authentication is available but has not been set up by the user.
  notSetUp
}

/// Represents the state related to biometric authentication settings and status.
///
/// This model holds information about available biometric methods on the device,
/// the current authentication status, configuration settings (like whether biometrics
/// are enabled), and potential multi-factor or passwordless configurations.
@freezed
class BiometricAuthState with _$BiometricAuthState {
  const factory BiometricAuthState({
    /// A list of biometric types supported by the current device.
    @Default([]) List<BiometricType> availableBiometrics,

    /// The specific biometric type currently configured or used for authentication.
    @Default(BiometricType.none) BiometricType currentBiometricType,

    /// The current status of the authentication process. See [AuthStatus].
    @Default(AuthStatus.notAuthenticated) AuthStatus status,

    /// An optional message providing details about an authentication failure or error.
    String? errorMessage,

    /// Indicates whether the user has enabled biometric authentication for the application.
    @Default(false) bool isBiometricEnabled,

    /// Indicates whether Two-Factor Authentication (2FA), potentially involving biometrics
    /// as one factor, is enabled.
    @Default(false) bool isTwoFactorEnabled,

    /// Indicates whether a passwordless authentication flow (potentially relying solely
    /// on biometrics after initial setup) is enabled.
    @Default(false) bool isPasswordlessEnabled,
  }) = _BiometricAuthState;

  /// Creates a [BiometricAuthState] instance from a JSON map.
  factory BiometricAuthState.fromJson(Map<String, dynamic> json) =>
      _$BiometricAuthStateFromJson(json);
}
