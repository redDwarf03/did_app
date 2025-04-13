import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/domain/verification/verification_result.dart';
import 'package:did_app/infrastructure/credential/eidas_credential_service.dart'
    as infra_eidas_service;
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/infrastructure/credential/eu_trust_registry_service.dart';
import 'package:did_app/infrastructure/credential/revocation_status.dart'
    as revocation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eidas_provider.freezed.dart';
// part 'eidas_provider.g.dart'; // Removed as fromJson is not used yet

/// Provides an instance of the [infra_eidas_service.EidasCredentialService].
///
/// This service handles eIDAS-specific operations like importing/exporting
/// credentials in eIDAS format, verifying signatures, and checking revocation status.
final eidasCredentialServiceProvider =
    Provider<infra_eidas_service.EidasCredentialService>((ref) {
  // Uses the concrete implementation from the infrastructure layer.
  return infra_eidas_service.EidasCredentialService();
});

/// Represents the state for eIDAS-related features within the application.
@freezed
class EidasState with _$EidasState {
  const factory EidasState({
    /// Indicates if an eIDAS-related operation is currently in progress.
    @Default(false) bool isLoading,

    /// Holds a potential error message from the last eIDAS operation.
    String? errorMessage,

    /// Indicates if the EUDI Wallet application is detected as available on the device.
    /// (Currently simulated).
    @Default(false) bool isEudiWalletAvailable,

    /// Stores the result of the last eIDAS credential verification attempt.
    /// Uses the domain VerificationResult model.
    VerificationResult? verificationResult,

    /// Stores the revocation status checked during the last verification.
    /// Uses the local RevocationStatus from the infrastructure service, accessed via prefix.
    revocation.RevocationStatus? revocationStatus,

    /// Timestamp of the last successful synchronization with the EU Trust Registry.
    DateTime? lastSyncDate,

    /// A report summarizing the current state of the local Trust List cache.
    Map<String, dynamic>? trustListReport,

    /// A report summarizing interoperability status based on the Trust List.
    Map<String, dynamic>? interoperabilityReport,

    /// The current list of trusted issuers, potentially filtered by country or trust level.
    @Default([]) List<TrustedIssuer> trustedIssuers,

    /// The trust level currently selected for filtering issuers (e.g., Qualified).
    TrustLevel? selectedTrustLevel,

    /// The country code currently selected for filtering issuers (e.g., 'FR', 'DE').
    String? selectedCountry,
  }) = _EidasState;

  // Private constructor needed for Freezed
  // const EidasState._();

  /// Creates an [EidasState] instance from a JSON map.
  /// Add .g.dart part file and run build_runner if needed.
  // factory EidasState.fromJson(Map<String, dynamic> json) => _$EidasStateFromJson(json);
}

/// Provider for the StateNotifier managing eIDAS-related state and logic.
final eidasNotifierProvider =
    StateNotifierProvider<EidasNotifier, EidasState>((ref) {
  // Read dependencies
  final eidasService = ref.watch(eidasCredentialServiceProvider);
  // Directly use the singleton for the real app, or read from a provider:
  // final trustList = ref.watch(eidasTrustListProvider);
  final trustList = EidasTrustList.instance; // Keep using singleton for now

  // Inject dependencies into the notifier
  return EidasNotifier(eidasService, trustList);
});

/// Manages state and orchestrates operations related to eIDAS compliance
/// and interoperability features.
///
/// Interacts with [eidasCredentialServiceProvider], [EidasTrustList],
/// and [EuTrustRegistryService] to perform tasks like verification,
/// synchronization, filtering, and simulated EUDI Wallet interactions.
class EidasNotifier extends StateNotifier<EidasState> {
  /// Creates an instance of [EidasNotifier].
  ///
  /// Requires a [Ref] to access other providers.
  /// Immediately triggers checks for EUDI Wallet availability (simulated)
  /// and loads initial Trust List data.
  EidasNotifier(
    this._eidasService, // Inject EidasCredentialService
    this._trustList, // Inject EidasTrustList
  ) : super(const EidasState()) {
    // On initialization, check EUDI Wallet availability
    _checkEudiWalletAvailability();
    // Load initial Trust List data using injected instance
    _loadTrustListData();
  }

  final infra_eidas_service.EidasCredentialService
      _eidasService; // Store injected service
  final EidasTrustList _trustList; // Store injected trust list

  /// Simulates checking if the EUDI Wallet application is installed/available.
  /// In a real implementation, this would use platform-specific APIs.
  Future<void> _checkEudiWalletAvailability() async {
    // Simulate check - assumes available for demo purposes.
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isEudiWalletAvailable: true);
  }

  /// Loads initial data from the local Trust List cache.
  /// Fetches the last sync date, all issuers, and generates a report.
  Future<void> _loadTrustListData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the injected _trustList instance
      final lastSyncDate = await _trustList.getLastSyncDate();
      final trustedIssuers = await _trustList.getAllTrustedIssuers();
      final trustListReport = await _trustList.generateTrustListReport();

      state = state.copyWith(
        isLoading: false,
        lastSyncDate: lastSyncDate,
        trustedIssuers: trustedIssuers,
        trustListReport: trustListReport,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading Trust List data: $e',
      );
    }
  }

  /// Reloads data from the local Trust List cache.
  /// Same as the initial load, useful for manual refresh.
  Future<void> loadTrustList() async {
    return _loadTrustListData();
  }

  /// Imports a credential from an eIDAS-formatted JSON string.
  /// Uses the [eidasCredentialServiceProvider].
  Future<Credential?> importFromJson(String jsonString) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the injected _eidasService instance
      final credential = await _eidasService.importFromJson(jsonString);
      state = state.copyWith(isLoading: false, errorMessage: null);
      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error importing from JSON: $e',
      );
      return null;
    }
  }

  /// Exports a given W3C [Credential] to an eIDAS-formatted JSON string.
  /// Uses the [eidasCredentialServiceProvider].
  Future<String?> exportToJson(Credential credential) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the injected _eidasService instance
      final jsonString = await _eidasService.exportToJson(credential);
      state = state.copyWith(isLoading: false, errorMessage: null);
      return jsonString;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error exporting to JSON: $e',
      );
      return null;
    }
  }

  /// Checks if a given W3C [Credential] is already considered eIDAS compatible.
  /// Delegates the check to the [eidasCredentialServiceProvider].
  bool isEidasCompatible(Credential credential) {
    // Use the injected _eidasService instance
    return _eidasService.isEidasCompatible(credential);
  }

  /// Attempts to convert a standard W3C [Credential] into an eIDAS compatible format.
  /// Uses the [eidasCredentialServiceProvider].
  Future<Credential?> makeEidasCompatible(Credential credential) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the injected _eidasService instance
      final result = await _eidasService.makeEidasCompatible(credential);
      state = state.copyWith(isLoading: false, errorMessage: null);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error making credential eIDAS compatible: $e',
      );
      return null;
    }
  }

  /// Simulates importing a credential from an external EUDI Wallet application.
  /// In a real scenario, this would involve inter-app communication.
  Future<Credential?> importFromEudiWallet() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // --- Real Implementation Steps (commented out) ---
      // 1. Open EUDI Wallet app via Intent/URL Scheme.
      // 2. Receive selected credential data back.
      // 3. Convert data to internal Credential format.

      await Future.delayed(const Duration(seconds: 1)); // Simulate delay

      // Use the injected _eidasService instance
      final credential = await _eidasService.importFromEudiWallet();

      state = state.copyWith(isLoading: false, errorMessage: null);
      // Again, does not add to the main credential list automatically.
      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error importing from EUDI Wallet (simulation): $e',
      );
      return null;
    }
  }

  /// Simulates sharing a credential with an external EUDI Wallet application.
  Future<void> shareWithEudiWallet(Credential credential) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the injected _eidasService instance
      final success = await _eidasService.shareWithEudiWallet(credential);

      if (!success) {
        throw Exception('Failed to share credential with EUDI Wallet');
      }

      state = state.copyWith(isLoading: false, errorMessage: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error sharing with EUDI Wallet: $e',
      );
    }
  }

  /// Verifies an eIDAS credential.
  ///
  /// Uses the [eidasCredentialServiceProvider] to perform signature and
  /// revocation status checks (simulated).
  /// Updates the state with the verification and revocation results.
  Future<void> verifyEidasCredential(EidasCredential credential) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the injected _eidasService instance
      final verificationResult =
          await _eidasService.verifyEidasCredential(credential);

      revocation.RevocationStatus? revocationStatus;
      if (verificationResult.isValid) {
        // Use the injected _eidasService instance
        revocationStatus =
            await _eidasService.checkRevocationStatus(credential);
        // If revoked, update the overall verification result
        if (revocationStatus.isRevoked) {
          final updatedResult = VerificationResult(
            isValid: false,
            message: (verificationResult.message ?? "Verification OK") +
                "; " +
                revocationStatus.message, // Access properties directly
          );
          state = state.copyWith(
            isLoading: false,
            verificationResult: updatedResult,
            revocationStatus: revocationStatus, // Assign prefixed type
            errorMessage: null,
          );
          return; // Stop processing if revoked
        }
      }

      state = state.copyWith(
        isLoading: false,
        verificationResult: verificationResult,
        revocationStatus: revocationStatus, // Assign prefixed type
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error verifying eIDAS credential: $e',
        verificationResult: VerificationResult(
            isValid: false, message: 'Verification failed: $e'),
        revocationStatus: null, // Reset revocation status on error
      );
    }
  }

  /// Filters the list of trusted issuers based on the selected country and/or trust level.
  Future<void> filterTrustedIssuers(
      {String? country, TrustLevel? level}) async {
    state = state.copyWith(
        isLoading: true, selectedCountry: country, selectedTrustLevel: level);
    try {
      // Use the injected _trustList instance
      final allIssuers = await _trustList.getAllTrustedIssuers();

      List<TrustedIssuer> filteredIssuers = allIssuers;

      // Apply country filter
      if (country != null && country.isNotEmpty) {
        filteredIssuers = filteredIssuers
            .where((issuer) =>
                issuer.country.toLowerCase() == country.toLowerCase())
            .toList();
      }

      // Apply trust level filter
      if (level != null) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.trustLevel == level)
            .toList();
      }

      state = state.copyWith(
        isLoading: false,
        trustedIssuers: filteredIssuers,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error filtering trusted issuers: $e',
      );
    }
  }

  /// Synchronizes the local Trust List cache with the official EU Trust Registry.
  /// Uses the [EuTrustRegistryService].
  Future<void> syncTrustRegistry() async {
    state = state.copyWith(isLoading: true);
    try {
      final registryService = EuTrustRegistryService.instance;
      final syncSuccess = await registryService.synchronizeTrustList();

      if (syncSuccess) {
        // Reload local data after successful sync
        await _loadTrustListData();
        // No need to call state.copyWith here as _loadTrustListData handles it
      } else {
        throw Exception('Synchronization with EU Trust Registry failed');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error syncing Trust Registry: $e',
      );
    }
  }

  /// Generates an interoperability report based on the Trust List.
  /// (Simulated - needs real implementation)
  Future<void> generateInteroperabilityReport() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Implement logic to analyze the trust list and generate
      //       a meaningful interoperability report (e.g., count by country,
      //       service type, levels of assurance).
      await Future.delayed(const Duration(seconds: 1)); // Simulate analysis

      final report = {
        'reportGenerated': DateTime.now().toIso8601String(),
        'status': 'Simulated - Requires Implementation',
        'summary': 'Analyzes trust list for interoperability metrics.'
      };

      state = state.copyWith(
        isLoading: false,
        interoperabilityReport: report,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error generating interoperability report: $e',
      );
    }
  }

  /// Clears the current error message from the state.
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Resets the eIDAS state to its initial values.
  void resetState() {
    state = const EidasState();
    _checkEudiWalletAvailability(); // Re-check availability
    _loadTrustListData(); // Reload initial data
  }
}
