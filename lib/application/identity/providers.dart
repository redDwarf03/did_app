import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:did_app/infrastructure/identity/mock_identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'providers.freezed.dart';

/// Provides an instance of [IdentityRepository].
///
/// This repository is responsible for managing the creation, retrieval,
/// and update of the user's [DigitalIdentity] data, typically interacting
/// with a secure storage mechanism like a blockchain.
final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  // TODO: Replace mock implementation with real blockchain implementation
  // This should connect to the Archethic blockchain to store and retrieve identity data
  return MockIdentityRepository(ref);
});

/// Represents the state for identity management features.
@freezed
class IdentityState with _$IdentityState {
  /// Factory constructor for [IdentityState].
  const factory IdentityState({
    /// The user's digital identity profile. Null if no identity exists yet.
    DigitalIdentity? identity,

    /// Indicates if an identity-related operation is in progress.
    @Default(false) bool isLoading,

    /// Holds a potential error message from the last operation.
    String? errorMessage,
  }) = _IdentityState;
}

/// Provider for the [IdentityNotifier] which manages the [IdentityState].
final identityNotifierProvider =
    StateNotifierProvider<IdentityNotifier, IdentityState>((ref) {
  return IdentityNotifier(ref);
});

/// Manages the state and orchestrates operations related to the user's digital identity.
///
/// Interacts with the [IdentityRepository] to check for, create, update,
/// and refresh the user's [DigitalIdentity].
class IdentityNotifier extends StateNotifier<IdentityState> {
  /// Creates an instance of [IdentityNotifier].
  /// Requires a [Ref] to access the [identityRepositoryProvider].
  /// It immediately checks if an identity already exists upon initialization.
  IdentityNotifier(this.ref) : super(const IdentityState()) {
    // Check if user has an identity on initialization
    _checkForExistingIdentity();
  }

  /// Riverpod ref for accessing other providers.
  final Ref ref;

  /// Checks if the current user (associated with the wallet/session)
  /// already has a digital identity stored in the repository.
  /// Updates the state with the found identity or sets isLoading to false if none exists.
  Future<void> _checkForExistingIdentity() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(identityRepositoryProvider);
      final hasIdentity = await repository.hasIdentity();

      if (hasIdentity) {
        final identity = await repository.getIdentity();
        state = state.copyWith(
          identity: identity,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to retrieve identity: $e',
      );
    }
  }

  /// Creates a new digital identity for the user.
  ///
  /// Requires basic personal information to initialize the identity profile.
  /// Checks if an identity already exists before attempting creation.
  /// Updates the state with the newly created identity or an error message.
  Future<void> createIdentity({
    /// The public display name for the identity.
    required String displayName,

    /// The user's full legal name.
    required String fullName,

    /// The user's primary email address.
    required String email,

    /// The user's phone number (optional).
    String? phoneNumber,

    /// The user's date of birth (optional).
    DateTime? dateOfBirth,

    /// The user's nationality (optional).
    String? nationality,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(identityRepositoryProvider);

      // Check if user already has an identity
      final hasIdentity = await repository.hasIdentity();
      if (hasIdentity) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'You already have an identity',
        );
        return;
      }

      // Create personal info object
      final personalInfo = PersonalInfo(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
        // Address is initially null or can be added later
      );

      // Create the identity via the repository
      final identity = await repository.createIdentity(
        displayName: displayName,
        personalInfo: personalInfo,
      );

      // Update state with the new identity
      state = state.copyWith(
        identity: identity,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to create identity: $e',
      );
    }
  }

  /// Updates the user's existing digital identity profile.
  ///
  /// Allows updating various fields like display name, personal info, and address.
  /// Ensures an identity exists before attempting an update.
  /// Updates the state with the modified identity or an error message.
  /// **Note:** The current implementation relies on the mock repository's update logic.
  /// A real implementation needs to handle field-specific updates properly.
  Future<void> updateIdentity({
    /// New display name (optional).
    String? displayName,

    /// New full name (optional).
    String? fullName,

    /// New email address (optional).
    String? email,

    /// New phone number (optional).
    String? phoneNumber,

    /// New date of birth (optional).
    DateTime? dateOfBirth,

    /// New nationality (optional).
    String? nationality,

    /// New physical address (optional).
    PhysicalAddress? address,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(identityRepositoryProvider);

      final currentIdentity = state.identity;
      if (currentIdentity == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No identity exists to update',
        );
        return;
      }

      // TODO: Implement proper identity update with field changes
      // The current implementation does not actually update any fields directly here.
      // It relies on the repository to handle the update based on the passed identity.
      // A more robust implementation would construct an updated identity object
      // based on the provided parameters before passing it to the repository.
      // Example:
      // final updatedPersonalInfo = currentIdentity.personalInfo.copyWith(...);
      // final identityToUpdate = currentIdentity.copyWith(
      //   displayName: displayName ?? currentIdentity.displayName,
      //   personalInfo: updatedPersonalInfo.copyWith(address: address ?? currentIdentity.personalInfo.address),
      // );
      // final updatedIdentity = await repository.updateIdentity(identity: identityToUpdate);

      // For now, we'll just pass the current identity and let the mock handle it.
      // Assume the repository's update method handles the logic based on its internal state or received object.
      final updatedIdentity = await repository.updateIdentity(
        // Pass the potentially modified fields if the repository method expects them,
        // or just the base identity if it handles merging changes internally.
        // Adjust this based on the actual repository implementation.
        identity: currentIdentity.copyWith(
          // This is a placeholder; adapt based on how update is truly handled.
          displayName: displayName ?? currentIdentity.displayName,
          personalInfo: currentIdentity.personalInfo.copyWith(
            fullName: fullName ?? currentIdentity.personalInfo.fullName,
            email: email ?? currentIdentity.personalInfo.email,
            phoneNumber:
                phoneNumber ?? currentIdentity.personalInfo.phoneNumber,
            dateOfBirth:
                dateOfBirth ?? currentIdentity.personalInfo.dateOfBirth,
            nationality:
                nationality ?? currentIdentity.personalInfo.nationality,
            address: address ?? currentIdentity.personalInfo.address,
          ),
        ),
      );

      state = state.copyWith(
        identity: updatedIdentity,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update identity: $e',
      );
    }
  }

  /// Refreshes the identity data from the repository.
  ///
  /// Calls [_checkForExistingIdentity] to fetch the latest identity state.
  Future<void> refreshIdentity() async {
    await _checkForExistingIdentity();
  }
}
