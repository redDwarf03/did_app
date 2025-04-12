import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:did_app/infrastructure/auth/biometric_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides an instance of [BiometricAuthService].
///
/// This service handles the low-level interactions with the device's
/// biometric authentication capabilities (e.g., checking availability,
/// triggering authentication prompts).
final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService();
});

/// Provides the [BiometricAuthNotifier] and its state [BiometricAuthState].
///
/// This is the main provider to interact with for biometric authentication features
/// in the UI layer. It manages the overall state, including availability,
/// enabled status, and authentication results.
final biometricAuthStateProvider =
    StateNotifierProvider<BiometricAuthNotifier, BiometricAuthState>((ref) {
  return BiometricAuthNotifier(ref);
});

/// Manages the state and logic for biometric authentication within the application.
///
/// It interacts with the [BiometricAuthService] to check availability and perform
/// authentication, and updates the [BiometricAuthState] accordingly.
class BiometricAuthNotifier extends StateNotifier<BiometricAuthState> {
  /// Creates an instance of [BiometricAuthNotifier].
  ///
  /// Requires a [Ref] to read other providers, primarily [biometricAuthServiceProvider].
  /// It immediately calls [checkBiometricAvailability] upon initialization to
  /// determine the initial state.
  BiometricAuthNotifier(this._ref) : super(const BiometricAuthState()) {
    // Check biometric availability upon initialization
    checkBiometricAvailability();
  }

  final Ref _ref;

  /// Checks the availability and configuration of biometric authentication on the device.
  ///
  /// Updates the [BiometricAuthState] with the availability status ([AuthStatus]),
  /// the list of available biometric types ([BiometricType]), and sets the
  /// [currentBiometricType]. Sets an error message if checks fail or biometrics
  /// are unavailable/not set up.
  Future<void> checkBiometricAvailability() async {
    try {
      final service = _ref.read(biometricAuthServiceProvider);

      // Check if biometrics are available on the device hardware/OS level.
      final isAvailable = await service.isBiometricAvailable();

      if (!isAvailable) {
        state = state.copyWith(
          status: AuthStatus.unavailable,
          errorMessage:
              'Biometric authentication is not available on this device.',
        );
        return;
      }

      // Get the specific biometric types enrolled by the user (e.g., face, fingerprint).
      final availableBiometrics = await service.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        state = state.copyWith(
          status: AuthStatus.notSetUp,
          errorMessage: 'No biometrics are configured on this device.',
        );
        return;
      }

      // Set the current biometric type (defaults to the first available one).
      // UI could potentially allow selection if multiple are available.
      final currentBiometricType = availableBiometrics.first;

      state = state.copyWith(
        availableBiometrics: availableBiometrics,
        currentBiometricType: currentBiometricType,
        // If available and configured, status is ready but not yet authenticated.
        status: AuthStatus.notAuthenticated,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.failed,
        errorMessage: 'Error checking biometric availability: $e',
      );
    }
  }

  /// Enables or disables the use of biometric authentication within the application settings.
  ///
  /// - [enable]: Set to `true` to enable, `false` to disable.
  ///
  /// If enabling, it re-checks availability via [checkBiometricAvailability].
  /// Does nothing if trying to enable when status is [AuthStatus.unavailable].
  Future<void> toggleBiometricAuth(bool enable) async {
    if (enable && state.status == AuthStatus.unavailable) {
      // Don't allow enabling if hardware/OS support is missing.
      return;
    }

    state = state.copyWith(
      isBiometricEnabled: enable,
    );

    // If enabling, ensure the availability status is up-to-date.
    if (enable) {
      await checkBiometricAvailability();
    }
  }

  // TODO: Review if these belong here or in a separate auth settings provider.
  /// Toggles the flag indicating whether two-factor authentication is enabled.
  void toggleTwoFactorAuth(bool enable) {
    state = state.copyWith(
      isTwoFactorEnabled: enable,
    );
  }

  /// Toggles the flag indicating whether passwordless authentication is enabled.
  void togglePasswordlessAuth(bool enable) {
    state = state.copyWith(
      isPasswordlessEnabled: enable,
    );
  }

  /// Attempts to authenticate the user using the device's biometric prompt.
  ///
  /// - [reason]: The message displayed to the user in the biometric prompt.
  ///
  /// Updates the [BiometricAuthState.status] to [AuthStatus.authenticating]
  /// during the attempt, and then to [AuthStatus.authenticated] or
  /// [AuthStatus.failed] based on the result from [BiometricAuthService].
  /// If biometric authentication is not enabled in the app settings
  /// ([BiometricAuthState.isBiometricEnabled] is false), this method returns `true`
  /// immediately (effectively bypassing the check).
  ///
  /// Returns `true` if authentication is successful or bypassed, `false` otherwise.
  Future<bool> authenticateWithBiometrics({
    String reason = 'Please authenticate to continue',
  }) async {
    try {
      // If the feature is turned off in app settings, consider it successful (bypass).
      if (!state.isBiometricEnabled) {
        return true;
      }
      // Cannot authenticate if unavailable or not set up.
      if (state.status == AuthStatus.unavailable ||
          state.status == AuthStatus.notSetUp) {
        state = state.copyWith(
          status: AuthStatus.failed,
          errorMessage: 'Biometrics not available or not set up.',
        );
        return false;
      }

      state = state.copyWith(
        status: AuthStatus.authenticating,
        errorMessage: null,
      );

      final service = _ref.read(biometricAuthServiceProvider);
      // Calls the infrastructure service to display the OS biometric prompt.
      final result = await service.authenticate(
        localizedReason: reason,
      );

      state = state.copyWith(
        // Update status based on the service result (success/failure/error).
        status: result.status,
        // Set error message only on failure.
        errorMessage: result.success ? null : result.message,
      );

      return result.success;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.failed,
        errorMessage: 'Error during biometric authentication: $e',
      );
      return false;
    }
  }
}
