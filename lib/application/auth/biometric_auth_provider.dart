import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:did_app/infrastructure/auth/biometric_auth_service.dart';

/// Provider pour le service d'authentification biométrique
final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService();
});

/// Provider pour l'état de l'authentification biométrique
final biometricAuthStateProvider =
    StateNotifierProvider<BiometricAuthNotifier, BiometricAuthState>((ref) {
  return BiometricAuthNotifier(ref);
});

/// Notifier pour gérer l'état de l'authentification biométrique
class BiometricAuthNotifier extends StateNotifier<BiometricAuthState> {
  BiometricAuthNotifier(this._ref) : super(const BiometricAuthState()) {
    // Vérifier la disponibilité de la biométrie à l'initialisation
    checkBiometricAvailability();
  }

  final Ref _ref;

  /// Vérifie si l'authentification biométrique est disponible
  Future<void> checkBiometricAvailability() async {
    try {
      final service = _ref.read(biometricAuthServiceProvider);

      // Vérifier si la biométrie est disponible
      final isAvailable = await service.isBiometricAvailable();

      if (!isAvailable) {
        state = state.copyWith(
          status: AuthStatus.unavailable,
          errorMessage:
              'L\'authentification biométrique n\'est pas disponible sur cet appareil',
        );
        return;
      }

      // Récupérer les types de biométrie disponibles
      final availableBiometrics = await service.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        state = state.copyWith(
          status: AuthStatus.notSetUp,
          errorMessage: 'Aucune biométrie n\'est configurée sur cet appareil',
        );
        return;
      }

      // Définir le type de biométrie actuel (prendre le premier disponible)
      final currentBiometricType = availableBiometrics.first;

      state = state.copyWith(
        availableBiometrics: availableBiometrics,
        currentBiometricType: currentBiometricType,
        status: AuthStatus.notAuthenticated,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.failed,
        errorMessage: 'Erreur lors de la vérification de la biométrie: $e',
      );
    }
  }

  /// Active ou désactive l'authentification biométrique
  Future<void> toggleBiometricAuth(bool enable) async {
    if (enable && state.status == AuthStatus.unavailable) {
      return; // Ne pas activer si non disponible
    }

    state = state.copyWith(
      isBiometricEnabled: enable,
    );

    // Si activé, vérifier la disponibilité à nouveau
    if (enable) {
      await checkBiometricAvailability();
    }
  }

  /// Active ou désactive l'authentification à deux facteurs
  void toggleTwoFactorAuth(bool enable) {
    state = state.copyWith(
      isTwoFactorEnabled: enable,
    );
  }

  /// Active ou désactive l'authentification sans mot de passe
  void togglePasswordlessAuth(bool enable) {
    state = state.copyWith(
      isPasswordlessEnabled: enable,
    );
  }

  /// Authentifie l'utilisateur avec la biométrie
  Future<bool> authenticateWithBiometrics({
    String reason = 'Veuillez vous authentifier pour accéder à l\'application',
  }) async {
    try {
      // Si la biométrie n'est pas activée, retourner true (bypass)
      if (!state.isBiometricEnabled) {
        return true;
      }

      state = state.copyWith(
        status: AuthStatus.authenticating,
        errorMessage: null,
      );

      final service = _ref.read(biometricAuthServiceProvider);
      final result = await service.authenticate(
        localizedReason: reason,
      );

      state = state.copyWith(
        status: result.status,
        errorMessage: result.success ? null : result.message,
      );

      return result.success;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.failed,
        errorMessage: 'Erreur lors de l\'authentification: $e',
      );
      return false;
    }
  }
}
