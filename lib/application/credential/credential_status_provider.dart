import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/infrastructure/credential/credential_status_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_status_provider.freezed.dart';

/// Provides an instance of [CredentialStatusService].
///
/// This service handles the interaction with status mechanisms like StatusList2021,
/// fetching status list credentials, and checking the status index.
final credentialStatusServiceProvider =
    Provider<CredentialStatusService>((ref) {
  // Uses the concrete implementation from the infrastructure layer.
  return CredentialStatusService();
});

/// Represents the state related to checking the revocation status of credentials.
@freezed
class CredentialStatusState with _$CredentialStatusState {
  const factory CredentialStatusState({
    /// Map storing the results of status checks, keyed by credential ID.
    /// Contains [StatusCheckResult] which includes the status type (valid, revoked, invalid) and details.
    required Map<String, StatusCheckResult> checkResults,

    /// Indicates if a status check operation is currently in progress.
    @Default(false) bool isLoading,

    /// Holds a potential error message from the last status check operation.
    String? error,

    /// Timestamp of the last time any status check was performed.
    DateTime? lastCheck,

    /// Timestamp indicating when the next scheduled automatic check should occur.
    DateTime? nextCheck,
  }) = _CredentialStatusState;
}

/// StateNotifier responsible for managing the credential status checking process.
///
/// It orchestrates status checks for single or multiple credentials,
/// handles refreshing status lists, manages the state ([CredentialStatusState]),
/// and provides helper methods related to credential validity and renewal.
class CredentialStatusNotifier extends StateNotifier<CredentialStatusState> {
  /// Creates an instance of [CredentialStatusNotifier].
  ///
  /// Requires a [Ref] to access other providers, primarily [credentialStatusServiceProvider].
  /// Initializes with an empty map of check results.
  CredentialStatusNotifier(this._service)
      : super(const CredentialStatusState(checkResults: {}));

  final CredentialStatusService _service;

  /// Checks the revocation status of a single [Credential].
  ///
  /// Updates the state with the [StatusCheckResult] for the given credential ID,
  /// the loading status, and timestamps.
  Future<void> checkStatus(Credential credential) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _service.checkStatus(credential);
      // Create a mutable copy of the results map
      final results = Map<String, StatusCheckResult>.from(state.checkResults)
        // Add or update the result for the specific credential ID
        ..[credential.id] = result;

      state = state.copyWith(
        checkResults: results,
        isLoading: false,
        lastCheck: DateTime.now(),
        // Schedule next check (e.g., in 1 hour, could be configurable)
        nextCheck: DateTime.now().add(const Duration(hours: 1)),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error checking status for ${credential.id}: $e',
      );
    }
  }

  /// Checks the revocation status for a list of [Credential]s.
  ///
  /// Updates the state with the [StatusCheckResult] for each credential,
  /// the loading status, and timestamps.
  Future<void> checkStatuses(List<Credential> credentials) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final results = await _service.checkStatuses(credentials);
      // Create a mutable copy of the current results
      final newResults =
          Map<String, StatusCheckResult>.from(state.checkResults);

      // Merge the new results into the state map
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
        error: 'Error checking statuses: $e',
      );
    }
  }

  /// Forces a refresh of all underlying status lists (e.g., StatusList2021 credentials).
  /// This might involve fetching updated lists from their sources.
  Future<void> refreshAllStatusLists() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Delegates the refresh operation to the service layer.
      await _service.refreshAllStatusLists();
      state = state.copyWith(
        isLoading: false,
        lastCheck:
            DateTime.now(), // Update last check time after successful refresh
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error refreshing status lists: $e',
      );
    }
  }

  /// Clears all stored status check results and resets timestamps.
  void clearResults() {
    state = state.copyWith(
      checkResults: {},
      lastCheck: null,
      nextCheck: null,
      error: null,
      isLoading: false,
    );
  }

  /// Schedules the next automatic status check.
  ///
  /// - [interval]: The duration after which the next check should ideally occur.
  void scheduleAutoCheck(Duration interval) {
    state = state.copyWith(
      nextCheck: DateTime.now().add(interval),
    );
  }

  /// Checks a list of credentials to identify those that need renewal.
  ///
  /// A credential needs renewal if it's expired, revoked (based on cached status),
  /// or within the [renewThreshold] of its expiration date.
  ///
  /// - [credentials]: The list of credentials to check.
  /// - [renewThreshold]: The duration before expiration to consider for renewal.
  ///
  /// Returns a list of credentials that require renewal.
  Future<List<Credential>> checkForRenewalNeeded(
    List<Credential> credentials,
    Duration renewThreshold,
  ) async {
    final now = DateTime.now();
    final needsRenewal = <Credential>{}; // Use a Set to avoid duplicates

    for (final credential in credentials) {
      bool needsRenewalFlag = false;
      // 1. Check expiration date
      if (credential.expirationDate != null) {
        final timeToExpiry = credential.expirationDate!.difference(now);
        if (timeToExpiry.isNegative || // Already expired
            timeToExpiry <= renewThreshold) {
          // Within renewal threshold
          needsRenewalFlag = true;
        }
      }

      // 2. Check cached revocation status
      final statusResult = state.checkResults[credential.id];
      if (statusResult != null &&
          statusResult.status == CredentialStatusType.revoked) {
        needsRenewalFlag = true;
      }

      if (needsRenewalFlag) {
        needsRenewal.add(credential);
      }
    }

    return needsRenewal.toList();
  }

  /// Simulates initiating the renewal process for a specific credential.
  ///
  /// In a real application, this would involve contacting the original issuer
  /// with a renewal request.
  ///
  /// Returns `true` if the simulated initiation is successful, `false` otherwise.
  Future<bool> initiateRenewal(Credential credential) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // --- Real Implementation Steps (commented out) ---
      // 1. Contact original issuer (requires issuer metadata/endpoint).
      // 2. Send a renewal request (protocol specific).
      // 3. Process the response (e.g., receive a new credential).
      // 4. Add the new credential via credentialNotifierProvider.addCredential(...).
      // 5. Potentially revoke/archive the old credential.

      // Simulate delay for the renewal process.
      await Future.delayed(const Duration(seconds: 2));

      // Assume success for the simulation.
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error initiating renewal for ${credential.id}: $e',
      );
      return false;
    }
  }
}

/// Provider for the [CredentialStatusNotifier].
final credentialStatusNotifierProvider =
    StateNotifierProvider<CredentialStatusNotifier, CredentialStatusState>(
        (ref) {
  return CredentialStatusNotifier(ref.read(credentialStatusServiceProvider));
});
