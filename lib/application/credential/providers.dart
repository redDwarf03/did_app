import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:did_app/infrastructure/credential/mock_credential_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le repository d'attestations
final credentialRepositoryProvider = Provider<CredentialRepository>((ref) {
  // TODO: Remplacer cette implémentation simulée par une réelle utilisant Archethic
  return MockCredentialRepository();
});

/// Provider pour récupérer une attestation par son ID
final credentialByIdProvider = FutureProvider.family<Credential?, String>(
  (ref, credentialId) async {
    final repository = ref.watch(credentialRepositoryProvider);

    try {
      return await repository.getCredentialById(credentialId);
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'attestation: $e");
    }
  },
);

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

  /// Récupérer les attestations
  Future<List<Credential>> getCredentials() async {
    if (state.credentials.isEmpty) {
      await loadCredentials();
    }
    return state.credentials;
  }

  /// Récupérer toutes les attestations pour la synchronisation
  Future<List<Credential>> getAllCredentials() async {
    await loadCredentials(); // Forcer un rechargement complet
    return state.credentials;
  }

  /// Charger les attestations de l'utilisateur
  Future<void> loadCredentials() async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final credentials = await repository.getCredentials();

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
  Future<Credential?> loadCredentialById(String credentialId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final credential = await repository.getCredentialById(credentialId);

      state = state.copyWith(
        selectedCredential: credential,
        isLoading: false,
      );

      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Erreur lors du chargement de l'attestation: $e",
      );
      return null;
    }
  }

  /// Supprimer une attestation
  Future<bool> deleteCredential(String credentialId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      await repository.deleteCredential(credentialId);

      // Supprimer l'attestation de la liste
      final updatedCredentials =
          state.credentials.where((cred) => cred.id != credentialId).toList();

      state = state.copyWith(
        credentials: updatedCredentials,
        isLoading: false,
      );

      return true;
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
      final credential = state.credentials.firstWhere(
        (c) => c.id == credentialId,
        orElse: () => throw Exception('Attestation non trouvée'),
      );

      final isValid = await repository.verifyCredential(credential);

      // Nous ne modifions plus le credential directement puisque le modèle
      // Credential n'a pas de propriété verificationStatus
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

  /// Ajouter ou mettre à jour une attestation
  Future<bool> addCredential(Credential credential) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      await repository.saveCredential(credential);

      // Vérifier si l'attestation existe déjà
      final existingIndex = state.credentials.indexWhere(
        (c) => c.id == credential.id,
      );

      final List<Credential> updatedCredentials;
      if (existingIndex >= 0) {
        // Mise à jour d'une attestation existante
        updatedCredentials = [...state.credentials];
        updatedCredentials[existingIndex] = credential;
      } else {
        // Ajout d'une nouvelle attestation
        updatedCredentials = [...state.credentials, credential];
      }

      state = state.copyWith(
        credentials: updatedCredentials,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Erreur lors de l'ajout de l'attestation: $e",
      );
      return false;
    }
  }

  /// Créer une présentation sélective
  Future<CredentialPresentation?> createPresentation({
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
    String? challenge,
    String? domain,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);

      // Récupérer les objets Credential à partir de leurs IDs
      final credentials = <Credential>[];
      for (final id in credentialIds) {
        final credential = state.credentials.firstWhere(
          (c) => c.id == id,
          orElse: () => throw Exception('Attestation non trouvée: $id'),
        );
        credentials.add(credential);
      }

      // Convertir les attributs révélés en selectiveDisclosure format
      final selectiveDisclosure = <String, List<String>>{};
      for (final entry in revealedAttributes.entries) {
        selectiveDisclosure[entry.key] = entry.value;
      }

      final presentation = await repository.createPresentation(
        credentials: credentials,
        selectiveDisclosure: selectiveDisclosure,
        challenge: challenge,
        domain: domain,
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

  /// Partager une présentation
  Future<String?> sharePresentation(String presentationId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final presentation = state.presentations.firstWhere(
        (p) => p.id == presentationId,
        orElse: () => throw Exception('Présentation non trouvée'),
      );

      final link = await repository.sharePresentation(presentation);

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

  /// Recevoir une attestation depuis un URI
  Future<Credential?> receiveCredential(String uri) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(credentialRepositoryProvider);
      final credential = await repository.receiveCredential(uri);

      // Ajouter l'attestation à la liste
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
        errorMessage: "Erreur lors de la réception de l'attestation: $e",
      );
      return null;
    }
  }
}

/// Provider pour récupérer la liste des attestations
final credentialsProvider = FutureProvider<List<Credential>>((ref) async {
  final repository = ref.watch(credentialRepositoryProvider);

  try {
    return await repository.getCredentials();
  } catch (e) {
    throw Exception('Erreur lors de la récupération des attestations: $e');
  }
});
