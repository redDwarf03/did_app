import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/secure_storage.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:did_app/infrastructure/identity/secure_storage_identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'providers.freezed.dart';
part 'providers.g.dart';

/// Provides an instance of [IdentityRepository].
///
/// This Riverpod provider is responsible for supplying the concrete implementation
/// of the [IdentityRepository] interface used throughout the application.
/// It abstracts the data source layer (e.g., mock, blockchain, secure storage)
/// for identity management.
///
/// Currently, it uses [SecureStorageIdentityRepository].
/// **TODO:** Replace with the actual blockchain-based implementation when available.
final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  // Provides the SecureStorageIdentityRepository implementation.
  final secureStorage = ref.read(flutterSecureStorageProvider);
  return SecureStorageIdentityRepository(secureStorage);
});

/// Represents the state for identity management within the application.
///
/// This Freezed class holds the current digital identity profile ([DigitalIdentity]),
/// loading status, and any error messages related to identity operations.
@freezed
class IdentityState with _$IdentityState {
  /// Factory constructor for creating instances of [IdentityState].
  const factory IdentityState({
    /// The user's detailed digital identity profile ([DigitalIdentity]).
    /// This holds personal information, verification status, etc.
    /// It is `null` if no identity has been created or loaded yet.
    DigitalIdentity? identity,

    /// Indicates whether an identity-related operation (e.g., fetching, creating,
    /// updating) is currently in progress.
    @Default(false) bool isLoading,

    /// Stores an error message if the last identity operation failed.
    /// `null` if the last operation was successful or no operation has been performed.
    String? errorMessage,
  }) = _IdentityState;
}

/// Provides the [IdentityNotifier] instance to the application.
///
/// This StateNotifierProvider allows widgets to listen to changes in the [IdentityState]
/// and access the [IdentityNotifier] to trigger identity-related actions.

/// Manages the state ([IdentityState]) and orchestrates operations related to
/// the user's core digital identity profile ([DigitalIdentity]).
///
/// This StateNotifier acts as the primary interface for the UI layer to interact
/// with identity management features. It uses the [IdentityRepository] provided
/// by [identityRepositoryProvider] to perform actions like checking for an existing
/// identity, creating a new one, updating it, and refreshing the data.
@Riverpod(keepAlive: true)
class IdentityNotifier extends _$IdentityNotifier {
  /// Creates an instance of [IdentityNotifier].
  ///
  /// Requires a [Ref] to access the [identityRepositoryProvider].
  /// Upon initialization, it automatically calls [_checkForExistingIdentity]
  /// to load any pre-existing identity associated with the user/wallet.

  @override
  IdentityState build() {
    // Perform initial check asynchronously
    Future.microtask(_checkForExistingIdentity);
    // Initial state
    return const IdentityState();
  }

  final _uuid = const Uuid();

  // Helper getters for dependencies
  IdentityRepository get _identityRepository =>
      ref.read(identityRepositoryProvider);
  CredentialRepository get _credentialRepository =>
      ref.read(credentialRepositoryProvider);

  /// Checks if a digital identity already exists for the current user/wallet.
  ///
  /// Fetches the identity from the [IdentityRepository] if it exists and updates
  /// the state accordingly. Sets loading state during the operation and handles potential errors.
  Future<void> _checkForExistingIdentity() async {
    // Set loading state and clear previous errors.
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final hasIdentity = await _identityRepository.hasIdentity();

      if (hasIdentity) {
        // If identity exists, fetch and update the state.
        final identity = await _identityRepository.getIdentity();
        state = state.copyWith(
          identity: identity,
          isLoading: false,
        );
      } else {
        // No identity found, just stop loading.
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      // Handle errors during the identity check.
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to retrieve identity: $e',
      );
    }
  }

  /// Creates a new digital identity, saves it, and generates initial VCs.
  ///
  /// This method implements the Self-Sovereign Identity (SSI) principles by:
  /// 1. Creating a minimal identity record with only a displayName and identityAddress
  /// 2. Storing all PII as separate Verifiable Credentials linked to this identity
  ///
  /// Returns the created identity on success, or null on failure.
  Future<DigitalIdentity?> createIdentity({
    /// The public display name chosen by the user for this identity.
    required String displayName,

    /// The user's full legal name (will be stored as a VC, not in identity).
    required String fullName,

    /// The user's primary email address (will be stored as a VC, not in identity).
    required String email,

    /// The user's phone number (optional, will be stored as a VC).
    String? phoneNumber,

    /// The user's date of birth (optional, will be stored as a VC).
    DateTime? dateOfBirth,

    /// The user's nationality (optional, will be stored as a VC).
    String? nationality,

    /// The user's physical address (optional, will be stored as a VC).
    Map<String, dynamic>? address,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final hasIdentity = await _identityRepository.hasIdentity();
      if (hasIdentity) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'An identity already exists for this user.',
        );
        return null;
      }

      // 1. Create the core identity (only with display name, no PII)
      final identity = await _identityRepository.createIdentity(
        displayName: displayName,
      );

      // --- 2. Create and Save Verifiable Credentials for each piece of info ---
      final createdVCs = <Credential>[];
      final subjectId = identity.identityAddress;
      const issuerId = 'did:app:self';
      final placeholderProof = <String, dynamic>{
        'type': 'PlaceholderProof2024',
        'proofPurpose': 'assertionMethod',
        'verificationMethod': '$issuerId#key-1',
        'created': DateTime.now().toIso8601String(),
        'proofValue': 'zPlaceholderProofValue...',
      };

      try {
        // --- Full Name VC ---
        if (fullName.isNotEmpty) {
          final fullNameVC = Credential(
            id: 'urn:uuid:${_uuid.v4()}',
            type: ['VerifiableCredential', 'FullNameCredential'],
            issuer: issuerId,
            issuanceDate: DateTime.now(),
            credentialSubject: {
              'id': subjectId,
              'fullName': fullName,
            },
            proof: placeholderProof,
            name: 'Full Name',
            description: 'Verified full name',
          );
          await _credentialRepository.saveCredential(fullNameVC);
          createdVCs.add(fullNameVC);
        }

        // --- Email VC ---
        if (email.isNotEmpty) {
          final emailVC = Credential(
            id: 'urn:uuid:${_uuid.v4()}',
            type: ['VerifiableCredential', 'EmailCredential'],
            issuer: issuerId,
            issuanceDate: DateTime.now(),
            credentialSubject: {
              'id': subjectId,
              'email': email,
            },
            proof: placeholderProof,
            name: 'Email Address',
            description: 'Verified email address',
          );
          await _credentialRepository.saveCredential(emailVC);
          createdVCs.add(emailVC);
        }

        // --- Phone Number VC (if provided) ---
        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          final phoneVC = Credential(
            id: 'urn:uuid:${_uuid.v4()}',
            type: ['VerifiableCredential', 'PhoneNumberCredential'],
            issuer: issuerId,
            issuanceDate: DateTime.now(),
            credentialSubject: {
              'id': subjectId,
              'phoneNumber': phoneNumber,
            },
            proof: placeholderProof,
            name: 'Phone Number',
            description: 'Verified phone number',
          );
          await _credentialRepository.saveCredential(phoneVC);
          createdVCs.add(phoneVC);
        }

        // --- Date of Birth VC (if provided) ---
        if (dateOfBirth != null) {
          final dobVC = Credential(
            id: 'urn:uuid:${_uuid.v4()}',
            type: ['VerifiableCredential', 'DateOfBirthCredential'],
            issuer: issuerId,
            issuanceDate: DateTime.now(),
            credentialSubject: {
              'id': subjectId,
              'dateOfBirth': dateOfBirth.toIso8601String().substring(0, 10),
            },
            proof: placeholderProof,
            name: 'Date of Birth',
            description: 'Verified date of birth',
          );
          await _credentialRepository.saveCredential(dobVC);
          createdVCs.add(dobVC);
        }

        // --- Nationality VC (if provided) ---
        if (nationality != null && nationality.isNotEmpty) {
          final nationalityVC = Credential(
            id: 'urn:uuid:${_uuid.v4()}',
            type: ['VerifiableCredential', 'NationalityCredential'],
            issuer: issuerId,
            issuanceDate: DateTime.now(),
            credentialSubject: {
              'id': subjectId,
              'nationality': nationality,
            },
            proof: placeholderProof,
            name: 'Nationality',
            description: 'Declared nationality',
          );
          await _credentialRepository.saveCredential(nationalityVC);
          createdVCs.add(nationalityVC);
        }

        // --- Address VC (if provided) ---
        if (address != null) {
          final addressVC = Credential(
            id: 'urn:uuid:${_uuid.v4()}',
            type: ['VerifiableCredential', 'AddressCredential'],
            issuer: issuerId,
            issuanceDate: DateTime.now(),
            credentialSubject: {
              'id': subjectId,
              'address': address,
            },
            proof: placeholderProof,
            name: 'Address',
            description: 'Verified address',
          );
          await _credentialRepository.saveCredential(addressVC);
          createdVCs.add(addressVC);
        }

        // --- Refresh the credential list immediately after saving all VCs ---
        await ref.read(credentialNotifierProvider.notifier).loadCredentials();
      } catch (vcError) {
        // Log VC creation error but potentially continue with identity creation
        // Or decide to roll back / indicate partial success
        // For now, just set the main identity state to error

        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Identity created, but failed to save credentials: $vcError',
        );
        return null; // Indicate failure to create identity fully
      }

      // Update identity state after successful creation and VC saving
      state = state.copyWith(
        identity: identity,
        isLoading: false,
      );

      return identity;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to create identity: $e',
      );
      return null; // Indicate failure to create identity
    }
  }

  /// Updates an existing digital identity with new information.
  ///
  /// Used for profile information modifications, potentially triggering
  /// re-verification if critical data changes. Both the identity's core properties
  /// and the information stored in VCs need to be updated to maintain consistency.
  ///
  /// Returns the updated [DigitalIdentity] on success, or `null` on failure.
  Future<DigitalIdentity?> updateIdentity({
    /// The new public display name (optional).
    String? displayName,

    /// The new full legal name (optional, will update the corresponding VC).
    String? fullName,

    /// The new primary email address (optional, will update the corresponding VC).
    String? email,

    /// The new phone number (optional, will update the corresponding VC).
    String? phoneNumber,

    /// The new date of birth (optional, will update the corresponding VC).
    DateTime? dateOfBirth,

    /// The new nationality (optional, will update the corresponding VC).
    String? nationality,

    /// The new physical address (optional, will update the corresponding VC).
    Map<String, dynamic>? address,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Ensure we have an existing identity
    if (state.identity == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No identity exists to update.',
      );
      return null;
    }

    try {
      final currentIdentity = state.identity!;

      // 1. Create updated identity with new display name if provided
      final updatedIdentity = displayName != null
          ? currentIdentity.copyWith(displayName: displayName)
          : currentIdentity;

      // 2. Save the updated core identity
      final savedIdentity =
          await _identityRepository.updateIdentity(identity: updatedIdentity);

      // 3. Update the user's state with the saved identity
      state = state.copyWith(
        identity: savedIdentity,
        isLoading: false,
      );

      // 4. For PII updates, we need to update the corresponding VCs
      // This would require finding the specific VCs using credentialRepository
      // and updating them. This is a TODO for now.
      // TODO: Implement VC updates when PII fields are changed.

      return savedIdentity;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update identity: $e',
      );
      return null;
    }
  }

  /// Refreshes the identity data from the repository.
  ///
  /// Simply calls [_checkForExistingIdentity] again to fetch the latest state
  /// from the underlying data source.
  Future<void> refreshIdentity() async {
    await _checkForExistingIdentity();
  }
}
