import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:did_app/domain/credential/simplified_credential.dart';
import 'package:did_app/infrastructure/credential/mock_credential_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the implementation of [CredentialRepository].
/// Handles operations for W3C Verifiable Credentials.
final credentialRepositoryProvider = Provider<CredentialRepository>((ref) {
  // TODO: Replace this mock implementation with a real one using Archethic or other storage.
  return MockCredentialRepository();
});

/// Provider to fetch a specific W3C Credential by its ID.
/// Uses the [credentialRepositoryProvider].
final credentialByIdProvider = FutureProvider.family<Credential?, String>(
  (ref, credentialId) async {
    final repository = ref.watch(credentialRepositoryProvider);
    try {
      return await repository.getCredentialById(credentialId);
    } catch (e) {
      // TODO: Improve error handling/logging
      throw Exception('Error fetching credential by ID: $e');
    }
  },
);

/// State class for managing W3C Verifiable Credentials and Presentations.
class CredentialState {
  const CredentialState({
    this.credentials = const [],
    this.selectedCredential,
    this.isLoading = false,
    this.errorMessage,
    this.presentations = const [],
    this.lastPresentation,
  });

  /// List of W3C Verifiable Credentials held by the user.
  final List<Credential> credentials;

  /// The currently selected W3C Credential (e.g., for viewing details).
  final Credential? selectedCredential;

  /// Loading indicator for W3C credential operations.
  final bool isLoading;

  /// Potential error message related to W3C credential operations.
  final String? errorMessage;

  /// List of created W3C Verifiable Presentations.
  final List<CredentialPresentation> presentations;

  /// The most recently created W3C Verifiable Presentation.
  final CredentialPresentation? lastPresentation;

  /// Utility method to create a copy of the state with modified values.
  CredentialState copyWith({
    List<Credential>? credentials,
    Credential? selectedCredential,
    bool? isLoading,
    // Allow explicitly setting errorMessage to null
    String? errorMessage,
    bool? clearErrorMessage,
    List<CredentialPresentation>? presentations,
    CredentialPresentation? lastPresentation,
  }) {
    return CredentialState(
      credentials: credentials ?? this.credentials,
      selectedCredential: selectedCredential ?? this.selectedCredential,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage == true ? null : errorMessage ?? this.errorMessage,
      presentations: presentations ?? this.presentations,
      lastPresentation: lastPresentation ?? this.lastPresentation,
    );
  }
}

/// Provider for the StateNotifier that manages W3C Credentials.
final credentialNotifierProvider =
    StateNotifierProvider<CredentialNotifier, CredentialState>((ref) {
  return CredentialNotifier(ref);
});

/// StateNotifier for managing W3C Verifiable Credentials and Presentations.
/// Interacts with the [CredentialRepository] to perform CRUD operations
/// and presentation creation.
class CredentialNotifier extends StateNotifier<CredentialState> {
  CredentialNotifier(this.ref) : super(const CredentialState()) {
    // Optionally load credentials on initialization
    // loadCredentials();
  }

  final Ref ref;

  /// Retrieves the list of W3C credentials, loading them if necessary.
  Future<List<Credential>> getCredentials() async {
    // Only load if the list is currently empty to avoid redundant calls.
    if (state.credentials.isEmpty) {
      await loadCredentials();
    }
    return state.credentials;
  }

  /// Forces a reload of all W3C credentials from the repository.
  /// Useful for ensuring synchronization.
  Future<List<Credential>> getAllCredentials() async {
    await loadCredentials(); // Force a full reload
    return state.credentials;
  }

  /// Loads the user's W3C credentials from the repository.
  /// Updates the state with the loaded credentials or an error message.
  Future<void> loadCredentials() async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
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
        errorMessage: 'Error loading credentials: $e',
      );
    }
  }

  /// Loads a specific W3C credential by its ID from the repository.
  /// Updates the [selectedCredential] in the state.
  Future<Credential?> loadCredentialById(String credentialId) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
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
        errorMessage: 'Error loading credential by ID: $e',
      );
      return null;
    }
  }

  /// Deletes a W3C credential by its ID from the repository and updates the state.
  Future<bool> deleteCredential(String credentialId) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final repository = ref.read(credentialRepositoryProvider);
      await repository.deleteCredential(credentialId);

      // Remove the credential from the local list in the state.
      final updatedCredentials =
          state.credentials.where((cred) => cred.id != credentialId).toList();

      state = state.copyWith(
        credentials: updatedCredentials,
        // Clear selected credential if it was the one deleted.
        selectedCredential: state.selectedCredential?.id == credentialId
            ? null
            : state.selectedCredential,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error deleting credential: $e',
      );
      return false;
    }
  }

  /// Verifies the integrity and status of a W3C credential.
  /// Note: This currently calls the repository but doesn't update the Credential object
  /// itself in the state, as verification status might be complex (e.g., requires status list check).
  Future<bool> verifyCredential(String credentialId) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final repository = ref.read(credentialRepositoryProvider);
      // Find the credential in the current state first.
      final credential = state.credentials.firstWhere(
        (c) => c.id == credentialId,
        // If not found in state (shouldn't happen often), try loading it.
        // TODO: Decide on a better strategy if not found in state.
        orElse: () => throw Exception('Credential not found in state'),
      );

      final isValid = await repository.verifyCredential(credential);

      // The Credential model itself doesn't store a simple isValid flag.
      // Verification result might be displayed temporarily in the UI.
      state = state.copyWith(isLoading: false);
      return isValid;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error verifying credential: $e',
      );
      return false;
    }
  }

  /// Adds a new W3C credential or updates an existing one in the repository and state.
  Future<bool> addCredential(Credential credential) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final repository = ref.read(credentialRepositoryProvider);
      await repository.saveCredential(credential);

      // Check if the credential already exists in the state list.
      final existingIndex = state.credentials.indexWhere(
        (c) => c.id == credential.id,
      );

      final List<Credential> updatedCredentials;
      if (existingIndex >= 0) {
        // Update existing credential in the list.
        updatedCredentials = [...state.credentials];
        updatedCredentials[existingIndex] = credential;
      } else {
        // Add new credential to the list.
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
        errorMessage: 'Error adding/updating credential: $e',
      );
      return false;
    }
  }

  /// Creates a W3C Verifiable Presentation based on selected credentials and criteria.
  ///
  /// - [credentialIds]: List of IDs of the W3C credentials to include.
  /// - [revealedAttributes]: Map specifying which attributes to reveal for each credential ID.
  /// - [predicates]: Optional list of predicates for zero-knowledge proofs (if applicable).
  /// - [challenge]: Optional challenge string provided by the verifier.
  /// - [domain]: Optional domain string provided by the verifier.
  ///
  /// Updates the state with the newly created [lastPresentation].
  Future<CredentialPresentation?> createPresentation({
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
    String? challenge,
    String? domain,
  }) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final repository = ref.read(credentialRepositoryProvider);

      // Retrieve the full Credential objects from the state based on IDs.
      final credentialsToPresent = <Credential>[];
      for (final id in credentialIds) {
        final credential = state.credentials.firstWhere(
          (c) => c.id == id,
          orElse: () => throw Exception('Credential with ID $id not found'),
        );
        credentialsToPresent.add(credential);
      }

      if (credentialsToPresent.isEmpty) {
        throw Exception('No valid credentials selected for presentation');
      }

      final presentation = await repository.createPresentation(
        credentials: credentialsToPresent,
        selectiveDisclosure: revealedAttributes,
        challenge: challenge,
        domain: domain,
      );

      state = state.copyWith(
        // Add to the list of presentations (optional, depends on requirements)
        presentations: [...state.presentations, presentation],
        lastPresentation: presentation,
        isLoading: false,
      );
      return presentation;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error creating presentation: $e',
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

// --- Simplified (Internal) Credential Providers ---

/// Provider for simplified credential state management.
/// Handles basic, non-W3C credential structures used internally.
final simplifiedCredentialsNotifierProvider = StateNotifierProvider<
    SimplifiedCredentialsNotifier, SimplifiedCredentialsState>((ref) {
  return SimplifiedCredentialsNotifier();
});

/// State class for simplified credentials.
class SimplifiedCredentialsState {
  SimplifiedCredentialsState({
    this.credentials = const [],
    this.isLoading = false,
    this.error,
  });

  /// List of simplified credentials.
  final List<SimplifiedCredential> credentials;

  /// Loading indicator for simplified credential operations.
  final bool isLoading;

  /// Potential error message for simplified credential operations.
  final String? error;

  SimplifiedCredentialsState copyWith({
    List<SimplifiedCredential>? credentials,
    bool? isLoading,
    String? error,
    bool? clearError,
  }) {
    return SimplifiedCredentialsState(
      credentials: credentials ?? this.credentials,
      isLoading: isLoading ?? this.isLoading,
      error: clearError == true ? null : error ?? this.error,
    );
  }
}

/// Notifier class for simplified credential operations.
/// Manages the state of internal, simplified credentials.
class SimplifiedCredentialsNotifier
    extends StateNotifier<SimplifiedCredentialsState> {
  SimplifiedCredentialsNotifier() : super(SimplifiedCredentialsState());

  // TODO: Implement actual logic if these simplified credentials need loading/saving.
  // Currently only has a mock request function.

  /// Mock function to request a new simplified credential from an issuer.
  /// In a real app, this would call an API specific to these simplified credentials.
  Future<void> requestCredential(String issuerUrl) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Mock implementation - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));

      // Create a mock simplified credential
      // Ensure SimplifiedCredentialType enum exists in simplified_credential.dart
      final newCredential = SimplifiedCredential(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: SimplifiedCredentialType.identity, // Assuming enum exists
        issuer: 'Example Simplified Issuer',
        issuanceDate: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 365)),
        attributes: {
          'simplified_name': 'Example Simplified Name',
          'simplified_email': 'example@simplified.email.com',
        },
      );

      // Add the simplified credential to state
      state = state.copyWith(
        credentials: [...state.credentials, newCredential],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error requesting simplified credential: $e',
      );
      // Consider logging the error instead of rethrowing in notifier
      // rethrow;
    }
  }

  /// Clears the list of simplified credentials.
  void clearSimplifiedCredentials() {
    state = state.copyWith(credentials: [], isLoading: false, clearError: true);
  }

  // Add other methods if needed (e.g., load, save, delete simplified credentials)
}
