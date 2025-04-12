import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/infrastructure/credential/eidas_credential_service.dart'
    as eidas_service;
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/infrastructure/credential/eu_trust_registry_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eidas_provider.freezed.dart';
// part 'eidas_provider.g.dart'; // Removed as fromJson is not used yet

/// Provides an instance of the [eidas_service.EidasCredentialService].
///
/// This service handles eIDAS-specific operations like importing/exporting
/// credentials in eIDAS format, verifying signatures, and checking revocation status.
final eidasCredentialServiceProvider =
    Provider<eidas_service.EidasCredentialService>((ref) {
  // Uses the concrete implementation from the infrastructure layer.
  return eidas_service.EidasCredentialService();
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
    eidas_service.VerificationResult? verificationResult,

    /// Stores the revocation status checked during the last verification.
    eidas_service.RevocationStatus? revocationStatus,

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
  return EidasNotifier(ref);
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
  EidasNotifier(this._ref) : super(const EidasState()) {
    // On initialization, check EUDI Wallet availability
    _checkEudiWalletAvailability();
    // Load initial Trust List data
    _loadTrustListData();
  }

  final Ref _ref;

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
    state = state.copyWith(isLoading: true);
    try {
      final trustList = EidasTrustList.instance;
      // Get last sync date from local cache.
      final lastSyncDate = await trustList.getLastSyncDate();
      // Get all trusted issuers from local cache.
      final trustedIssuers = await trustList.getAllTrustedIssuers();
      // Generate a report based on local cache data.
      final trustListReport = await trustList.generateTrustListReport();

      state = state.copyWith(
        isLoading: false,
        lastSyncDate: lastSyncDate,
        trustedIssuers: trustedIssuers,
        trustListReport: trustListReport,
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
    state = state.copyWith(isLoading: true);
    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final credential = await service.importFromJson(jsonString);
      state = state.copyWith(isLoading: false);
      // Note: Does not automatically add the imported credential to the main
      // credential list. This should likely be done via credentialNotifierProvider.
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
    state = state.copyWith(isLoading: true);
    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final jsonString = await service.exportToJson(credential);
      state = state.copyWith(isLoading: false);
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
    final service = _ref.read(eidasCredentialServiceProvider);
    return service.isEidasCompatible(credential);
  }

  /// Attempts to convert a standard W3C [Credential] into an eIDAS compatible format.
  /// Uses the [eidasCredentialServiceProvider].
  Future<Credential?> makeEidasCompatible(Credential credential) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final result = await service.makeEidasCompatible(credential);
      state = state.copyWith(isLoading: false);
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
    state = state.copyWith(isLoading: true);
    try {
      // --- Real Implementation Steps (commented out) ---
      // 1. Open EUDI Wallet app via Intent/URL Scheme.
      // 2. Receive selected credential data back.
      // 3. Convert data to internal Credential format.

      await Future.delayed(const Duration(seconds: 1)); // Simulate delay

      final service = _ref.read(eidasCredentialServiceProvider);

      // Simulate loading a sample eIDAS credential JSON and importing it.
      // TODO: Replace mock data with actual inter-app communication logic.
      const mockEidasJson = '''
{
        "@context": [
          "https://www.w3.org/2018/credentials/v1",
          "https://ec.europa.eu/2023/credentials/eidas/v1"
        ],
        "id": "urn:uuid:mock-eidas-credential",
        "type": ["VerifiableCredential", "MockEidasPid"],
        "issuer": "did:example:mock-issuer",
        "issuanceDate": "2024-01-01T00:00:00Z",
        "credentialSubject": {
          "id": "did:example:mock-subject",
          "given_name": "Mock",
          "family_name": "User",
          "birthdate": "1980-01-01"
        },
        "proof": {
          "type": "EidasSignature2023",
          "created": "2024-01-01T00:00:00Z",
          "verificationMethod": "did:example:mock-issuer#key-1",
          "proofPurpose": "assertionMethod",
          "proofValue": "mockProofValue..."
        }
      }''';

      final credential = await service.importFromJson(mockEidasJson);
      state = state.copyWith(isLoading: false);
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

  /// Verifies an eIDAS credential, checking signature, revocation status, and issuer trust.
  ///
  /// - Converts the credential to eIDAS format if needed.
  /// - Calls the [eidasCredentialServiceProvider] to verify the signature.
  /// - Calls the service to check revocation status.
  /// - Calls [EidasTrustList] to check if the issuer is trusted.
  /// - Updates the state with the detailed [verificationResult] and [revocationStatus].
  ///
  /// Returns a [eidas_service.VerificationResult] summarizing the outcome.
  Future<eidas_service.VerificationResult> verifyCredential(
    Credential credential,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = _ref.read(eidasCredentialServiceProvider);

      // Ensure credential is in eIDAS format for verification.
      final eidasCompatible = await service.makeEidasCompatible(credential);
      // Manually construct EidasCredential from the compatible Credential
      // This assumes makeEidasCompatible added necessary context/types
      // and the structure aligns. Might need refinement based on actual data.
      final eidasCredential = EidasCredential(
        id: eidasCompatible.id,
        type: eidasCompatible.type,
        // Assuming issuer can be parsed or is stored appropriately
        issuer: EidasIssuer.fromJson(eidasCompatible.issuer),
        issuanceDate: eidasCompatible.issuanceDate,
        credentialSubject: eidasCompatible.credentialSubject,
        expirationDate: eidasCompatible.expirationDate,
        credentialStatus: eidasCompatible.status != null
            ? EidasCredentialStatus.fromJson(eidasCompatible.status!)
            : null,
        credentialSchema: eidasCompatible.credentialSchema != null
            ? EidasCredentialSchema.fromJson(eidasCompatible.credentialSchema!)
            : null,
        proof: eidasCompatible.proof.isNotEmpty
            ? EidasProof.fromJson(eidasCompatible.proof)
            : null,
        // Evidence might not be directly available on the base Credential model
      );

      // 1. Verify cryptographic signature.
      final signatureVerification =
          await service.verifyEidasCredential(eidasCredential);

      // 2. Check revocation status only if signature is valid.
      eidas_service.RevocationStatus? revocationStatus;
      if (signatureVerification.isValid) {
        revocationStatus = await service.checkRevocationStatus(eidasCredential);
      }

      // 3. Check if issuer is in the EU Trust List.
      var issuerTrusted = false;
      if (eidasCredential.issuer.id.isNotEmpty) {
        issuerTrusted = await EidasTrustList.instance
            .isIssuerTrusted(eidasCredential.issuer.id);
      }

      // Combine results into a final verification status.
      final overallIsValid = signatureVerification.isValid &&
          (revocationStatus?.isRevoked != true) &&
          issuerTrusted;

      final finalResult = eidas_service.VerificationResult(
        isValid: overallIsValid,
        message: _buildVerificationMessage(
          signatureVerification,
          revocationStatus,
          issuerTrusted,
        ),
        details: {
          // Spread operator with null check
          ...(signatureVerification.details ?? {}),
          'issuerTrusted': issuerTrusted,
          // Store relevant revocation info if available
          if (revocationStatus != null)
            'revocationStatus': {
              'isRevoked': revocationStatus.isRevoked,
              'message': revocationStatus.message,
              'lastChecked': revocationStatus.lastChecked.toIso8601String(),
            } // No comma needed here as it's the last element
        },
      );

      state = state.copyWith(
        isLoading: false,
        verificationResult: finalResult,
        revocationStatus: revocationStatus, // Store the detailed status
      );
      return finalResult;
    } catch (e) {
      final errorResult = eidas_service.VerificationResult(
        isValid: false,
        message: 'Error during eIDAS verification: $e',
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error during eIDAS verification: $e',
        verificationResult: errorResult,
      );
      return errorResult;
    }
  }

  /// Helper method to build a consolidated verification message string.
  String _buildVerificationMessage(
    eidas_service.VerificationResult sigResult,
    eidas_service.RevocationStatus? revStatus,
    bool issuerTrusted,
  ) {
    final messages = <String>[
      sigResult.message, // Start with signature verification message.
    ];
    if (revStatus != null) {
      messages.add(revStatus.message); // Add revocation message if available.
    }
    messages.add(
      issuerTrusted
          ? 'Issuer recognized by EU Trust Registry.'
          : 'Issuer NOT recognized by EU Trust Registry.',
    );
    return messages.join(' ');
  }

  /// Generates data suitable for a QR code representing the credential.
  /// Currently exports to eIDAS JSON format.
  /// TODO: Implement actual QR code generation (e.g., using a library).
  Future<String?> generateQrCodeForCredential(Credential credential) async {
    state = state.copyWith(isLoading: true);
    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      // Ensure eIDAS format before exporting.
      final eidasCompatible = await service.makeEidasCompatible(credential);
      final json = await service.exportToJson(eidasCompatible);

      // In a real app, use a QR code library here:
      // e.g., final qrImageData = await QrPainter(data: json, ...).toImageData(200);

      state = state.copyWith(isLoading: false);
      return json; // Return JSON for now, UI layer would generate QR.
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error generating QR code data: $e',
      );
      return null;
    }
  }

  /// Triggers synchronization with the EU Trust Registry infrastructure.
  /// Uses [EuTrustRegistryService] to fetch updates and then updates
  /// the local [EidasTrustList] cache and the state.
  Future<bool> synchronizeWithEidasInfrastructure() async {
    state = state.copyWith(isLoading: true);
    try {
      // 1. Fetch updates from the central EU Trust Registry.
      final syncSuccess =
          await EuTrustRegistryService.instance.synchronizeTrustList();

      if (!syncSuccess) {
        throw Exception('Synchronization with EU Trust Registry failed.');
      }

      // 2. If sync succeeded, update local cache representation and state.
      final trustList = EidasTrustList.instance;
      final lastSyncDate = await trustList.getLastSyncDate();
      final trustedIssuers = await trustList.getAllTrustedIssuers();
      final trustListReport = await trustList.generateTrustListReport();

      // Also generate an interoperability report based on the updated list.
      final interoperabilityReport = await EuTrustRegistryService.instance
          .generateInteroperabilityReport();

      state = state.copyWith(
        isLoading: false,
        lastSyncDate: lastSyncDate,
        trustedIssuers: trustedIssuers, // Update the full list in state
        trustListReport: trustListReport,
        interoperabilityReport: interoperabilityReport,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error during eIDAS infrastructure synchronization: $e',
      );
      return false;
    }
  }

  /// Filters the displayed list of trusted issuers based on a country code.
  /// If [countryCode] is null or empty, resets the country filter.
  /// Re-applies the existing trust level filter if any.
  Future<void> filterIssuersByCountry(String? countryCode) async {
    state = state.copyWith(
      isLoading: true,
      selectedCountry: countryCode, // Update selected country filter
    );
    try {
      final trustList = EidasTrustList.instance;
      List<TrustedIssuer> filteredIssuers;

      if (countryCode == null || countryCode.isEmpty) {
        // No country filter: get all issuers.
        filteredIssuers = await trustList.getAllTrustedIssuers();
      } else {
        // Apply country filter.
        filteredIssuers =
            await trustList.getTrustedIssuersByCountry(countryCode);
      }

      // Re-apply the trust level filter if one is selected.
      if (state.selectedTrustLevel != null) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.trustLevel == state.selectedTrustLevel)
            .toList();
      }

      state = state.copyWith(
        isLoading: false,
        trustedIssuers: filteredIssuers, // Update displayed list
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error filtering issuers by country: $e',
      );
    }
  }

  /// Filters the displayed list of trusted issuers based on a trust level.
  /// If [level] is null, resets the trust level filter.
  /// Re-applies the existing country filter if any.
  Future<void> filterIssuersByTrustLevel(TrustLevel? level) async {
    state = state.copyWith(
      isLoading: true,
      selectedTrustLevel: level, // Update selected trust level filter
    );
    try {
      final trustList = EidasTrustList.instance;
      List<TrustedIssuer> filteredIssuers;

      if (level == null) {
        // No level filter: get all issuers.
        filteredIssuers = await trustList.getAllTrustedIssuers();
      } else {
        // Apply level filter.
        filteredIssuers = await trustList.getTrustedIssuersByLevel(level);
      }

      // Re-apply the country filter if one is selected.
      if (state.selectedCountry != null && state.selectedCountry!.isNotEmpty) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.country == state.selectedCountry)
            .toList();
      }

      state = state.copyWith(
        isLoading: false,
        trustedIssuers: filteredIssuers, // Update displayed list
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error filtering issuers by trust level: $e',
      );
    }
  }

  /// Verifies if a specific issuer ID exists in the EU Trust Registry.
  /// Uses the [EuTrustRegistryService].
  /// Returns a map containing verification status and details or an error.
  Future<Map<String, dynamic>> verifyTrustedIssuer(String issuerId) async {
    state = state.copyWith(isLoading: true);
    try {
      final result =
          await EuTrustRegistryService.instance.verifyTrustedIssuer(issuerId);
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error verifying issuer: $e',
      );
      return {'isValid': false, 'error': e.toString()};
    }
  }

  /// Fetches available trust schemes from the EU Trust Registry.
  /// Uses the [EuTrustRegistryService].
  /// Returns a map containing the list of schemes or an error.
  Future<Map<String, dynamic>> fetchTrustSchemes() async {
    state = state.copyWith(isLoading: true);
    try {
      final schemes = await EuTrustRegistryService.instance.fetchTrustSchemes();
      state = state.copyWith(isLoading: false);
      return schemes;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error fetching trust schemes: $e',
      );
      return {'schemes': [], 'error': e.toString()};
    }
  }

  /// Simulates sharing a credential with an external EUDI Wallet application.
  /// In a real scenario, this would involve inter-app communication.
  Future<bool> shareWithEudiWallet(Credential credential) async {
    if (!state.isEudiWalletAvailable) {
      state = state.copyWith(
        errorMessage: 'EUDI Wallet is not available on this device.',
      );
      return false;
    }

    state = state.copyWith(isLoading: true);
    try {
      // --- Real Implementation Steps (commented out) ---
      // 1. Convert credential to eIDAS format if needed.
      // 2. Prepare data payload for sharing.
      // 3. Open EUDI Wallet app via Intent/URL Scheme with payload.

      final service = _ref.read(eidasCredentialServiceProvider);
      // Ensure credential is in eIDAS format.
      final eidasCompatible = await service.makeEidasCompatible(credential);
      // Export to JSON (or other required format for sharing).
      /* final jsonData = */ await service.exportToJson(eidasCompatible);

      // Simulate sharing operation delay
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(isLoading: false);
      return true; // Assume success in simulation
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error sharing with EUDI Wallet (simulation): $e',
      );
      return false;
    }
  }
}
