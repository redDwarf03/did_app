import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/secure_storage.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:did_app/infrastructure/identity/secure_storage_identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'providers.freezed.dart';

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
final identityNotifierProvider =
    StateNotifierProvider<IdentityNotifier, IdentityState>((ref) {
  // Creates the IdentityNotifier, passing the Riverpod Ref for dependency injection.
  return IdentityNotifier(ref);
});

/// Manages the state ([IdentityState]) and orchestrates operations related to
/// the user's core digital identity profile ([DigitalIdentity]).
///
/// This StateNotifier acts as the primary interface for the UI layer to interact
/// with identity management features. It uses the [IdentityRepository] provided
/// by [identityRepositoryProvider] to perform actions like checking for an existing
/// identity, creating a new one, updating it, and refreshing the data.
class IdentityNotifier extends StateNotifier<IdentityState> {
  /// Creates an instance of [IdentityNotifier].
  ///
  /// Requires a [Ref] to access the [identityRepositoryProvider].
  /// Upon initialization, it automatically calls [_checkForExistingIdentity]
  /// to load any pre-existing identity associated with the user/wallet.
  IdentityNotifier(this.ref) : super(const IdentityState()) {
    // Immediately check if an identity exists when the notifier is created.
    _checkForExistingIdentity();
  }

  /// Riverpod ref for accessing other providers, primarily [identityRepositoryProvider].
  final Ref ref;
  final _uuid = const Uuid();

  /// Checks if a digital identity already exists for the current user/wallet.
  ///
  /// Fetches the identity from the [IdentityRepository] if it exists and updates
  /// the state accordingly. Sets loading state during the operation and handles potential errors.
  Future<void> _checkForExistingIdentity() async {
    // Set loading state and clear previous errors.
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(identityRepositoryProvider);
      final hasIdentity = await repository.hasIdentity();

      if (hasIdentity) {
        // If identity exists, fetch and update the state.
        final identity = await repository.getIdentity();
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
  /// Returns the created identity on success, or null on failure.
  Future<DigitalIdentity?> createIdentity({
    /// The public display name chosen by the user for this identity.
    required String displayName,

    /// The user's full legal name (part of [PersonalInfo]).
    required String fullName,

    /// The user's primary email address (part of [PersonalInfo]).
    required String email,

    /// The user's phone number (optional, part of [PersonalInfo]).
    String? phoneNumber,

    /// The user's date of birth (optional, part of [PersonalInfo]).
    DateTime? dateOfBirth,

    /// The user's nationality (optional, part of [PersonalInfo]).
    String? nationality,

    /// The user's physical address (optional, part of [PersonalInfo]).
    PhysicalAddress? address,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final identityRepository = ref.read(identityRepositoryProvider);

      final hasIdentity = await identityRepository.hasIdentity();
      if (hasIdentity) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'An identity already exists for this user.',
        );
        return null;
      }

      final personalInfo = PersonalInfo(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
        address: address,
      );

      // 1. Create the core identity (mocked for now)
      final identity = await identityRepository.createIdentity(
        displayName: displayName,
        personalInfo: personalInfo,
      );

      // --- 2. Create and Save Verifiable Credentials for each piece of info ---
      final credentialRepository = ref.read(credentialRepositoryProvider);
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
          await credentialRepository.saveCredential(fullNameVC);
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
          await credentialRepository.saveCredential(emailVC);
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
          await credentialRepository.saveCredential(phoneVC);
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
          await credentialRepository.saveCredential(dobVC);
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
          await credentialRepository.saveCredential(nationalityVC);
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
              'address': address.toJson(),
            },
            proof: placeholderProof,
            name: 'Address',
            description: 'Verified address',
          );
          await credentialRepository.saveCredential(addressVC);
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
        errorMessage: null,
      );
      return identity;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }

  /// Updates the user's existing digital identity profile.
  ///
  /// Allows modification of various fields like [displayName] and components of
  /// [PersonalInfo] (name, email, phone, dob, nationality, address).
  /// It first checks if an identity exists. Uses the [IdentityRepository] to
  /// persist the changes.
  /// Updates the state with the modified [DigitalIdentity] or an error message.
  Future<void> updateIdentity({
    /// The new display name for the identity (optional).
    String? displayName,

    /// The new full legal name (optional, part of [PersonalInfo]).
    String? fullName,

    /// The new primary email address (optional, part of [PersonalInfo]).
    String? email,

    /// The new phone number (optional, part of [PersonalInfo]).
    String? phoneNumber,

    /// The new date of birth (optional, part of [PersonalInfo]).
    DateTime? dateOfBirth,

    /// The new nationality (optional, part of [PersonalInfo]).
    String? nationality,

    /// The new physical address (optional, part of [PersonalInfo]).
    PhysicalAddress? address,
  }) async {
    // Set loading state and clear previous errors.
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(identityRepositoryProvider);
      final currentIdentity = state.identity;

      // Ensure an identity exists before attempting to update.
      if (currentIdentity == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No identity found to update.',
        );
        return;
      }

      // Create the updated identity object by copying the current one
      // and applying the provided changes.
      final identityToUpdate = currentIdentity.copyWith(
        displayName: displayName ?? currentIdentity.displayName,
        personalInfo: currentIdentity.personalInfo.copyWith(
          fullName: fullName ?? currentIdentity.personalInfo.fullName,
          email: email ?? currentIdentity.personalInfo.email,
          phoneNumber: phoneNumber ?? currentIdentity.personalInfo.phoneNumber,
          dateOfBirth: dateOfBirth ?? currentIdentity.personalInfo.dateOfBirth,
          nationality: nationality ?? currentIdentity.personalInfo.nationality,
          address: address ?? currentIdentity.personalInfo.address,
        ),
      );

      // Call the repository to update the identity.
      final updatedIdentity = await repository.updateIdentity(
        identity: identityToUpdate,
      );

      // Update the state with the modified identity.
      state = state.copyWith(
        identity: updatedIdentity,
        isLoading: false,
      );
    } catch (e) {
      // Handle errors during identity update.
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update identity: $e',
      );
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
