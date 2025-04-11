import 'package:did_app/domain/credentials/credential.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for credential state management
final credentialsNotifierProvider =
    StateNotifierProvider<CredentialsNotifier, CredentialsState>((ref) {
  return CredentialsNotifier();
});

/// State class for credentials
class CredentialsState {

  CredentialsState({
    this.credentials = const [],
    this.isLoading = false,
    this.error,
  });
  final List<Credential> credentials;
  final bool isLoading;
  final String? error;

  CredentialsState copyWith({
    List<Credential>? credentials,
    bool? isLoading,
    String? error,
  }) {
    return CredentialsState(
      credentials: credentials ?? this.credentials,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Notifier class for credential operations
class CredentialsNotifier extends StateNotifier<CredentialsState> {
  CredentialsNotifier() : super(CredentialsState());

  /// Request a new credential from an issuer
  Future<void> requestCredential(String issuerUrl) async {
    state = state.copyWith(isLoading: true);

    try {
      // Mock implementation - in a real app, this would call an API
      await Future.delayed(const Duration(seconds: 2));

      // Create a mock credential
      final newCredential = Credential(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: CredentialType.identity,
        issuer: 'Example Issuer',
        issuanceDate: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 365)),
        attributes: {
          'name': 'Example Name',
          'email': 'example@email.com',
        },
      );

      // Add the credential to state
      state = state.copyWith(
        credentials: [...state.credentials, newCredential],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
}
