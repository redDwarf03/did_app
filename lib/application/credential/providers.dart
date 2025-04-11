import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:did_app/infrastructure/credential/mock_credential_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le repository d'attestations
final credentialRepositoryProvider = Provider<CredentialRepository>((ref) {
  // TODO: Remplacer cette implémentation simulée par une réelle utilisant Archethic
  return MockCredentialRepository();
});

/// État pour la gestion des attestations
class CredentialState {
  const CredentialState({
    this.credentials = const [],
    this.selectedCredential,
    this.isLoading = false,
    this.errorMessage,
    this.presentations = const [],
    this.lastPresentation,
  });

  /// Liste des attestations de l'utilisateur
  final List<Credential> credentials;

  /// Attestation actuellement sélectionnée
  final Credential? selectedCredential;

  /// Indicateur de chargement
  final bool isLoading;

  /// Message d'erreur éventuel
  final String? errorMessage;

  /// Liste des présentations créées
  final List<CredentialPresentation> presentations;

  /// Dernière présentation créée
  final CredentialPresentation? lastPresentation;

  /// Méthode utilitaire pour copier l'instance avec des modifications
  CredentialState copyWith({
    List<Credential>? credentials,
    Credential? selectedCredential,
    bool? isLoading,
    String? errorMessage,
    List<CredentialPresentation>? presentations,
    CredentialPresentation? lastPresentation,
  }) {
    return CredentialState(
      credentials: credentials ?? this.credentials,
      selectedCredential: selectedCredential ?? this.selectedCredential,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      presentations: presentations ?? this.presentations,
      lastPresentation: lastPresentation ?? this.lastPresentation,
    );
  }
}

/// Provider pour la gestion des attestations
final credentialNotifierProvider =
    StateNotifierProvider<CredentialNotifier, CredentialState>((ref) {
  return CredentialNotifier(ref);
});

/// Notifier pour la gestion des attestations
class CredentialNotifier extends StateNotifier<CredentialState> {
  CredentialNotifier(this.ref) : super(const CredentialState());

  final Ref ref;

  /// Charger les attestations de l'utilisateur
  Future<void> loadCredentials(String identityAddress) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final credentials = await repository.getCredentials(identityAddress);

      state = state.copyWith(
        credentials: credentials,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du chargement des attestations: $e',
      );
    }
  }

  /// Charger une attestation spécifique
  Future<void> loadCredential(String credentialId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final credential = await repository.getCredential(credentialId);

      state = state.copyWith(
        selectedCredential: credential,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du chargement de l\'attestation: $e',
      );
    }
  }

  /// Supprimer une attestation
  Future<bool> deleteCredential(String credentialId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final success = await repository.deleteCredential(credentialId);

      if (success) {
        // Supprimer l'attestation de la liste
        final updatedCredentials =
            state.credentials.where((cred) => cred.id != credentialId).toList();

        state = state.copyWith(
          credentials: updatedCredentials,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Échec de la suppression de l\'attestation',
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la suppression: $e',
      );
      return false;
    }
  }

  /// Vérifier une attestation
  Future<bool> verifyCredential(String credentialId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final isValid = await repository.verifyCredential(credentialId);

      // Mettre à jour le statut de vérification si nécessaire
      if (isValid) {
        final index = state.credentials.indexWhere((c) => c.id == credentialId);
        if (index >= 0) {
          final credential = state.credentials[index];
          if (credential.verificationStatus != VerificationStatus.verified) {
            final updatedCredential = credential.copyWith(
              verificationStatus: VerificationStatus.verified,
            );

            final updatedCredentials = [...state.credentials];
            updatedCredentials[index] = updatedCredential;

            state = state.copyWith(
              credentials: updatedCredentials,
            );
          }
        }
      }

      state = state.copyWith(isLoading: false);
      return isValid;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la vérification: $e',
      );
      return false;
    }
  }

  /// Créer une présentation sélective
  Future<CredentialPresentation?> createPresentation({
    required String identityAddress,
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final presentation = await repository.createPresentation(
        identityAddress: identityAddress,
        credentialIds: credentialIds,
        revealedAttributes: revealedAttributes,
        predicates: predicates,
      );

      // Mettre à jour la liste des présentations
      final updatedPresentations = [...state.presentations, presentation];

      state = state.copyWith(
        presentations: updatedPresentations,
        lastPresentation: presentation,
        isLoading: false,
      );

      return presentation;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la création de la présentation: $e',
      );
      return null;
    }
  }

  /// Générer un lien de partage pour une présentation
  Future<String?> generatePresentationLink(String presentationId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final link = await repository.generatePresentationLink(presentationId);

      state = state.copyWith(isLoading: false);
      return link;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la génération du lien: $e',
      );
      return null;
    }
  }

  /// Accepter une offre d'attestation
  Future<Credential?> acceptCredentialOffer({
    required String identityAddress,
    required String offerId,
    required Map<String, dynamic> consents,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final credential = await repository.acceptCredentialOffer(
        identityAddress: identityAddress,
        offerId: offerId,
        consents: consents,
      );

      // Ajouter la nouvelle attestation à la liste
      final updatedCredentials = [...state.credentials, credential];

      state = state.copyWith(
        credentials: updatedCredentials,
        selectedCredential: credential,
        isLoading: false,
      );

      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de l\'acceptation de l\'attestation: $e',
      );
      return null;
    }
  }

  /// Créer une demande d'attestation
  Future<String?> createCredentialRequest({
    required String identityAddress,
    required String issuerId,
    required String credentialType,
    Map<String, dynamic>? additionalInfo,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final requestId = await repository.createCredentialRequest(
        identityAddress: identityAddress,
        issuerId: issuerId,
        credentialType: credentialType,
        additionalInfo: additionalInfo,
      );

      state = state.copyWith(isLoading: false);
      return requestId;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la création de la demande: $e',
      );
      return null;
    }
  }
}
