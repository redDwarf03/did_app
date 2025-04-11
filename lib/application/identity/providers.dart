import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:did_app/infrastructure/identity/mock_identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the identity repository
final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  // TODO: Replace mock implementation with real blockchain implementation
  // This should connect to the Archethic blockchain to store and retrieve identity data
  return MockIdentityRepository(ref);
});

/// State for the identity notifier
class IdentityState {
  const IdentityState({
    this.identity,
    this.isLoading = false,
    this.errorMessage,
  });

  // The current user's digital identity
  final DigitalIdentity? identity;

  // Loading state
  final bool isLoading;

  // Error message if any
  final String? errorMessage;

  // Implement copyWith method manually since we're not using freezed here
  IdentityState copyWith({
    DigitalIdentity? identity,
    bool? isLoading,
    String? errorMessage,
  }) {
    return IdentityState(
      identity: identity ?? this.identity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Provider for managing digital identity
final identityNotifierProvider =
    StateNotifierProvider<IdentityNotifier, IdentityState>((ref) {
  return IdentityNotifier(ref);
});

class IdentityNotifier extends StateNotifier<IdentityState> {
  IdentityNotifier(this.ref) : super(const IdentityState()) {
    // Check if user has an identity on initialization
    _checkForExistingIdentity();
  }

  final Ref ref;

  /// Check if the current wallet has an associated identity
  Future<void> _checkForExistingIdentity() async {
    state = state.copyWith(isLoading: true);

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

  /// Create a new digital identity
  Future<void> createIdentity({
    required String displayName,
    required String fullName,
    required String email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? nationality,
  }) async {
    state = state.copyWith(isLoading: true);

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

      // Create personal info
      final personalInfo = PersonalInfo(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
      );

      // Create the identity
      final identity = await repository.createIdentity(
        displayName: displayName,
        personalInfo: personalInfo,
      );

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

  /// Update the existing identity
  Future<void> updateIdentity({
    String? displayName,
    String? fullName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? nationality,
    PhysicalAddress? address,
  }) async {
    state = state.copyWith(isLoading: true);

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
      // The current implementation does not actually update any fields
      // Need to properly handle updates to each field and store them on the blockchain

      // For now, we'll just use the mock repository which handles that for us
      final updatedIdentity = await repository.updateIdentity(
        identity: currentIdentity,
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

  /// Refresh the identity from the repository
  Future<void> refreshIdentity() async {
    await _checkForExistingIdentity();
  }
}
