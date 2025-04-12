import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:did_app/infrastructure/identity/mock_identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'providers.freezed.dart';

/// Provides an instance of [IdentityRepository].
///
/// This Riverpod provider is responsible for supplying the concrete implementation
/// of the [IdentityRepository] interface used throughout the application.
/// It abstracts the data source layer (e.g., mock, blockchain, secure storage)
/// for identity management.
///
/// Currently, it uses [MockIdentityRepository] for development and testing purposes.
/// **TODO:** Replace with the actual blockchain-based implementation when available.
final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  // Provides the MockIdentityRepository implementation for now.
  // The Ref allows the mock repository to potentially interact with other providers if needed.
  return MockIdentityRepository(ref);
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
      // TODO: Log error for debugging.
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to retrieve identity: $e',
      );
    }
  }

  /// Creates a new digital identity profile for the user.
  ///
  /// Takes required personal information ([fullName], [email], [displayName]) and optional
  /// details to initialize the profile. It first checks if an identity already exists
  /// to prevent duplicates. Uses the [IdentityRepository] to persist the new identity.
  /// Updates the state with the newly created [DigitalIdentity] or an error message.
  Future<void> createIdentity({
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
    PhysicalAddress? address, // Added address parameter
  }) async {
    // Set loading state and clear previous errors.
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(identityRepositoryProvider);

      // Prevent creating an identity if one already exists.
      final hasIdentity = await repository.hasIdentity();
      if (hasIdentity) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'An identity already exists for this user.',
        );
        return;
      }

      // Construct the PersonalInfo object from provided details.
      final personalInfo = PersonalInfo(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
        address: address, // Include address
      );

      // Call the repository to create the identity.
      final identity = await repository.createIdentity(
        displayName: displayName,
        personalInfo: personalInfo,
      );

      // Update the state with the newly created identity.
      state = state.copyWith(
        identity: identity,
        isLoading: false,
      );
    } catch (e) {
      // Handle errors during identity creation.
      // TODO: Log error for debugging.
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to create identity: $e',
      );
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
      // TODO: Log error for debugging.
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
