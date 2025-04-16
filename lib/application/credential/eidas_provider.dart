import 'dart:async';
import 'dart:developer' as dev;

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/domain/verification/verification_result.dart';
import 'package:did_app/infrastructure/credential/eidas_credential_service.dart'
    as infra_eidas_service;
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/infrastructure/credential/eu_trust_registry_service.dart';
import 'package:did_app/infrastructure/credential/revocation_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart' as dev;

part 'eidas_provider.freezed.dart';
part 'eidas_provider.g.dart';

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
    RevocationStatus? revocationStatus,

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

  const EidasState._();

  factory EidasState.fromJson(Map<String, dynamic> json) =>
      _$EidasStateFromJson(json);
}

/// Provider for the StateNotifier managing eIDAS-related state and logic.
@riverpod
class EidasNotifier extends _$EidasNotifier {
  /// Creates an instance of [EidasNotifier].
  ///
  /// Requires a [Ref] to access other providers.
  /// Immediately triggers checks for EUDI Wallet availability (simulated)
  /// and loads initial Trust List data.
  @override
  EidasState build() {
    // Read dependencies inside build
    // Note: Using watch here might cause rebuilds if dependencies change,
    // consider using read if dependencies are stable or accessed only in methods.
    final eidasService = ref.watch(eidasCredentialServiceProvider);
    final trustList = EidasTrustList.instance; // Keep singleton for now

    // Perform initial async setup
    Future.microtask(() {
      _checkEudiWalletAvailability();
      _loadTrustListData(trustList); // Pass trustList
    });

    // Initial state
    return const EidasState();
  }

  // Accessors for dependencies
  infra_eidas_service.EidasCredentialService get _eidasService =>
      ref.read(eidasCredentialServiceProvider);
  // Use singleton instance for now, or introduce a provider if needed
  EidasTrustList get _trustList => EidasTrustList.instance;

  /// Simulates checking if the EUDI Wallet application is installed/available.
  /// In a real implementation, this would use platform-specific APIs.
  Future<void> _checkEudiWalletAvailability() async {
    // Simulate check - assumes available for demo purposes.
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isEudiWalletAvailable: true);
  }

  /// Loads initial data from the local Trust List cache.
  /// Fetches the last sync date, all issuers, and generates a report.
  Future<void> _loadTrustListData(EidasTrustList trustList) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Use the passed trustList instance
      final lastSyncDate = await trustList.getLastSyncDate();
      final trustedIssuers = await trustList.getAllTrustedIssuers();
      final trustListReport = await trustList.generateTrustListReport();

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
    // Access trustList via getter
    return _loadTrustListData(_trustList);
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
      final verificationResult = await _eidasService
          .verifyEidasCredential(credential); // Corrected call

      RevocationStatus? revocationStatus;
      // Fetch revocation status only if verification succeeded initially
      if (verificationResult.isValid) {
        // Use the injected _eidasService instance
        revocationStatus =
            await _eidasService.checkRevocationStatus(credential);
      }

      state = state.copyWith(
        isLoading: false,
        verificationResult: verificationResult,
        revocationStatus: revocationStatus,
        errorMessage: null,
      );
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging
      dev.log(
        'Error verifying eIDAS credential',
        error: e,
        stackTrace: stackTrace,
        name: 'EidasNotifier.verifyEidasCredential',
      );
      state = state.copyWith(
        isLoading: false,
        verificationResult: null,
        revocationStatus: null,
        errorMessage: 'Verification failed: $e',
      );
    }
  }

  /// Filters the displayed trusted issuers based on country and trust level.
  /// Updates the [trustedIssuers] list in the state.
  Future<void> filterTrustedIssuers(
      {String? country, TrustLevel? level}) async {
    state = state.copyWith(
      isLoading: true, // Show loading while filtering
      selectedCountry: country,
      selectedTrustLevel: level,
    );
    try {
      // Access trustList via getter and fetch all issuers
      // Corrected: Fetch all and filter locally
      final allIssuers = await _trustList.getAllTrustedIssuers();
      var filteredIssuers = allIssuers;

      // Apply country filter if provided
      if (country != null) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.country == country)
            .toList();
      }

      // Apply trust level filter if provided
      if (level != null) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.trustLevel == level)
            .toList();
      }

      state = state.copyWith(
        isLoading: false,
        trustedIssuers: filteredIssuers,
        errorMessage: null, // Clear any previous error
      );
    } catch (e, stackTrace) {
      // Also catch stackTrace for logging
      // Corrected: Add logging
      dev.log(
        'Error filtering trusted issuers',
        error: e,
        stackTrace: stackTrace,
        name: 'EidasNotifier.filterTrustedIssuers',
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error filtering trusted issuers: $e',
      );
    }
  }

  /// Synchronizes the local Trust List cache with the official EU Trust Registry.
  /// Uses the [EuTrustRegistryService].
  Future<void> synchronizeTrustRegistry() async {
    state = state.copyWith(isLoading: true);
    try {
      // Corrected: Use EuTrustRegistryService as originally intended
      final registryService = EuTrustRegistryService.instance;
      final syncSuccess = await registryService.synchronizeTrustList();

      if (syncSuccess) {
        // Reload local data after successful sync
        await _loadTrustListData(_trustList);
      } else {
        throw Exception('Synchronization with EU Trust Registry failed');
      }
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging
      dev.log(
        'Error synchronizing trust registry',
        error: e,
        stackTrace: stackTrace,
        name: 'EidasNotifier.synchronizeTrustRegistry',
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Synchronization failed: $e',
      );
    }
  }

  /// Generates an interoperability report based on the Trust List.
  /// (Simulated - needs real implementation)
  Future<void> generateInteroperabilityReport() async {
    state = state.copyWith(isLoading: true);
    try {
      // Corrected: Restore simulation logic
      // --- Real Implementation Placeholder ---
      // This would involve analyzing the Trust List (_trustList)
      // and comparing it against known standards/schemas.
      // Example: Check for support of specific credential types, signature algorithms etc.

      await Future.delayed(const Duration(seconds: 1)); // Simulate analysis

      // Simulated report data
      final report = {
        'analysisDate': DateTime.now().toIso8601String(),
        'schemaCompliance': 'Partial',
        'supportedSignatureAlgorithms': ['ES256K', 'EdDSA'],
        'missingCriticalEntries': 5,
        'summary': 'The local trust list shows partial compliance. '
            'Further analysis needed for full interoperability assessment.',
      };

      state = state.copyWith(
        isLoading: false,
        interoperabilityReport: report,
        errorMessage: null,
      );
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging
      dev.log(
        'Error generating interoperability report',
        error: e,
        stackTrace: stackTrace,
        name: 'EidasNotifier.generateInteroperabilityReport',
      );
      state = state.copyWith(
        isLoading: false,
        interoperabilityReport: null,
        errorMessage: 'Failed to generate interoperability report: $e',
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
    _loadTrustListData(_trustList); // Reload initial data
  }
}
