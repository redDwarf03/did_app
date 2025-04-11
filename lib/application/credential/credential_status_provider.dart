import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/infrastructure/credential/credential_status_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_status_provider.freezed.dart';

/// Provider pour le service de vérification des statuts
final credentialStatusServiceProvider =
    Provider<CredentialStatusService>((ref) {
  return CredentialStatusService();
});

/// État de la vérification des statuts
@freezed
class CredentialStatusState with _$CredentialStatusState {
  const factory CredentialStatusState({
    /// Liste des résultats de vérification
    required Map<String, StatusCheckResult> checkResults,

    /// Indique si une vérification est en cours
    @Default(false) bool isLoading,

    /// Erreur éventuelle
    String? error,

    /// Date de la dernière vérification
    DateTime? lastCheck,

    /// Prochaine vérification programmée
    DateTime? nextCheck,
  }) = _CredentialStatusState;
}

/// Notifier pour gérer l'état des vérifications de statut
class CredentialStatusNotifier extends StateNotifier<CredentialStatusState> {

  CredentialStatusNotifier(this._ref)
      : _service = _ref.read(credentialStatusServiceProvider),
        super(const CredentialStatusState(checkResults: {}));
  final Ref _ref;
  final CredentialStatusService _service;

  /// Vérifie le statut d'une attestation
  Future<void> checkStatus(Credential credential) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _service.checkStatus(credential);
      final results = Map<String, StatusCheckResult>.from(state.checkResults)
        ..[credential.id] = result;

      state = state.copyWith(
        checkResults: results,
        isLoading: false,
        lastCheck: DateTime.now(),
        nextCheck: DateTime.now().add(const Duration(hours: 1)),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Vérifie le statut de plusieurs attestations
  Future<void> checkStatuses(List<Credential> credentials) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final results = await _service.checkStatuses(credentials);
      final newResults =
          Map<String, StatusCheckResult>.from(state.checkResults);

      for (final result in results) {
        newResults[result.credentialId] = result;
      }

      state = state.copyWith(
        checkResults: newResults,
        isLoading: false,
        lastCheck: DateTime.now(),
        nextCheck: DateTime.now().add(const Duration(hours: 1)),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Force la mise à jour de toutes les listes de statut
  Future<void> refreshAllStatusLists() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _service.refreshAllStatusLists();
      state = state.copyWith(
        isLoading: false,
        lastCheck: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur lors de la mise à jour: $e',
      );
    }
  }

  /// Efface les résultats de vérification
  void clearResults() {
    state = state.copyWith(
      checkResults: {},
      lastCheck: null,
      nextCheck: null,
    );
  }

  /// Programme une vérification automatique
  void scheduleAutoCheck(Duration interval) {
    state = state.copyWith(
      nextCheck: DateTime.now().add(interval),
    );
  }

  /// Vérifie si des attestations nécessitent un renouvellement
  Future<List<Credential>> checkForRenewalNeeded(
    List<Credential> credentials,
    Duration renewThreshold,
  ) async {
    final now = DateTime.now();
    final needsRenewal = <Credential>[];

    for (final credential in credentials) {
      // Vérifier si l'attestation est expirée ou proche de l'expiration
      if (credential.expirationDate != null) {
        final timeToExpiry = credential.expirationDate!.difference(now);
        if (timeToExpiry <= renewThreshold &&
            timeToExpiry.isNegative == false) {
          needsRenewal.add(credential);
        }
      }

      // Vérifier si l'attestation est révoquée
      final status = state.checkResults[credential.id];
      if (status != null && status.status == CredentialStatusType.revoked) {
        needsRenewal.add(credential);
      }
    }

    return needsRenewal;
  }

  /// Initie le processus de renouvellement pour une attestation
  Future<bool> initiateRenewal(Credential credential) async {
    try {
      // En situation réelle, cette méthode :
      // 1. Contacterait l'émetteur d'origine
      // 2. Enverrait une demande de renouvellement
      // 3. Traiterait la réponse

      // Pour l'instant, nous simulons juste le processus
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      // Simuler un délai pour le renouvellement
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        isLoading: false,
      );

      // Retourner le succès simulé
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur lors du renouvellement: $e',
      );
      return false;
    }
  }
}

/// Provider pour le notifier de statut
final credentialStatusNotifierProvider =
    StateNotifierProvider<CredentialStatusNotifier, CredentialStatusState>(
        (ref) {
  return CredentialStatusNotifier(ref);
});
