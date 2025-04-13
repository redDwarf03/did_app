import 'dart:convert';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/domain/credential/qualified_credential.dart'; // Import for AssuranceLevel
// Import the domain VerificationResult with a prefix
import 'package:did_app/domain/verification/verification_result.dart' as domain;
import 'revocation_status.dart' as revocation;

/// Service for managing eIDAS credentials and EUDI Wallet integration.
class EidasCredentialService {
  /// Imports a credential from an eIDAS 2.0 compatible JSON string.
  Future<Credential?> importFromJson(String jsonString) async {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Check if it's an eIDAS document by context
      final context = jsonData['@context'] as List<dynamic>?;
      if (context == null ||
          !context.any((e) => e.toString().contains('eidas'))) {
        throw const FormatException("Document is not in eIDAS format");
      }

      // Attempt to parse as EidasCredential first (more specific)
      try {
        final eidasCredential = EidasCredential.fromJson(jsonData);
        return eidasCredential.toCredential();
      } catch (_) {
        // If parsing as EidasCredential fails, try parsing as base Credential
        // This might handle cases where it's a standard VC with eIDAS context/type
        return Credential.fromJson(jsonData);
      }
    } catch (e) {
      // TODO: Log error
      print("Error during import: $e");
      return null;
    }
  }

  /// Exports a credential to eIDAS 2.0 compatible JSON format.
  Future<String> exportToJson(Credential credential) async {
    // Need a way to convert Credential back to EidasCredential or handle directly
    // Assuming EidasCredential might have a factory constructor for this
    // For now, creating a basic EidasCredential structure from Credential
    final eidasCredential = EidasCredential(
      id: credential.id,
      type: credential.type,
      issuer: EidasIssuer(id: credential.issuer), // Basic issuer mapping
      issuanceDate: credential.issuanceDate,
      credentialSubject: credential.credentialSubject,
      expirationDate: credential.expirationDate,
      proof:
          EidasProof.fromJson(credential.proof), // Assume proof maps directly
      credentialSchema: credential.credentialSchema != null
          ? EidasCredentialSchema.fromJson(credential.credentialSchema!)
          : null,
      credentialStatus: credential.status != null
          ? EidasCredentialStatus.fromJson(credential.status!)
          : null,
      // Evidence is not directly available in the base Credential model
    );
    return jsonEncode(eidasCredential.toJson());
  }

  /// Checks if a credential is compatible with the eIDAS 2.0 standard.
  bool isEidasCompatible(Credential credential) {
    // Check context first
    if (credential.context.any((e) => e.contains('eidas'))) {
      return true;
    }

    // Common eIDAS credential types (non-exhaustive list)
    const eidasTypes = [
      'IdentityCredential',
      'VerifiableId',
      'VerifiableAttestation',
      'VerifiableDiploma',
      'VerifiableAuthorisation',
      'EuropeanIdentityCredential', // From potential eIDAS specific profiles
    ];

    return credential.type
        .any((type) => eidasTypes.any((eidasType) => type.contains(eidasType)));
  }

  /// Converts a credential to make it eIDAS compatible (adds context/type).
  Future<Credential> makeEidasCompatible(Credential credential) async {
    if (isEidasCompatible(credential)) {
      return credential;
    }

    // Add eIDAS context
    final newContext = List<String>.from(credential.context);
    const eidasContextV1 =
        'https://ec.europa.eu/2023/credentials/eidas/v1'; // Example context
    if (!newContext.contains(eidasContextV1)) {
      newContext.add(eidasContextV1);
    }

    // Adapt type if necessary (example logic)
    final newType = List<String>.from(credential.type);
    if (credential.type.contains('IdentityCredential') &&
        !newType.contains('VerifiableId')) {
      newType.add('VerifiableId');
    } else if (credential.type.contains('UniversityDegreeCredential') &&
        !newType.contains('VerifiableDiploma')) {
      newType.add('VerifiableDiploma');
    } else if (!newType.contains('VerifiableAttestation')) {
      // Add a generic attestation type if no specific mapping found
      newType.add('VerifiableAttestation');
    }

    return credential.copyWith(
      context: newContext,
      type: newType,
    );
  }

  /// Shares a credential with the EUDI Wallet (simulated).
  Future<bool> shareWithEudiWallet(Credential credential) async {
    try {
      // Ensure credential is eIDAS compatible
      final eidasCredential = await makeEidasCompatible(credential);

      // Export to JSON
      final jsonString = await exportToJson(eidasCredential);

      // In a real implementation, use system APIs (e.g., platform channels)
      // to invoke the EUDI Wallet application via its sharing interface.
      print('Simulating sharing with EUDI Wallet: $jsonString');
      return true;
    } catch (e) {
      // TODO: Log error
      print('Error sharing with EUDI Wallet: $e');
      return false;
    }
  }

  /// Imports a credential from the EUDI Wallet (simulated).
  /// This function is simulated as the real interface depends on native APIs.
  Future<Credential?> importFromEudiWallet() async {
    try {
      // In a real implementation, launch an intent/activity
      // to request the EUDI Wallet to share a credential.
      // The result would likely be received via a callback or result handler.

      // Simulation: load a sample eIDAS credential
      final jsonString = await _loadSampleEidasCredential();
      print('Simulating receiving from EUDI Wallet: $jsonString');

      return importFromJson(jsonString);
    } catch (e) {
      // TODO: Log error
      print("Error importing from EUDI Wallet: $e");
      return null;
    }
  }

  /// Loads a sample eIDAS credential JSON string (for demo purposes).
  Future<String> _loadSampleEidasCredential() async {
    // In a real application, this data would come from the EUDI Wallet interaction.
    // This is a sample Verifiable ID based on eIDAS PID structure.
    return '''
    {
      "@context": [
        "https://www.w3.org/2018/credentials/v1",
        "https://ec.europa.eu/2023/credentials/eidas/v1"
      ],
      "id": "urn:uuid:f817388a-a21b-4abc-84d9-7e854a2dbf8b",
      "type": ["VerifiableCredential", "VerifiableId"],
      "issuer": {
        "id": "did:example:gov-issuer-123",
        "name": "National Identity Service"
      },
      "issuanceDate": "2024-01-15T10:00:00Z",
      "expirationDate": "2029-01-14T23:59:59Z",
      "credentialSubject": {
        "id": "did:example:holder-456",
        "given_name": "Maria",
        "family_name": "Garcia",
        "birthdate": "1995-03-20",
        // ... other potential PID attributes
        "nationality": "ES"
      },
      "credentialSchema": {
        "id": "https://example.eu/schemas/pid/v1",
        "type": "JsonSchema"
      },
      "proof": {
        "type": "Ed25519Signature2020",
        "created": "2024-01-15T10:01:00Z",
        "verificationMethod": "did:example:gov-issuer-123#key-1",
        "proofPurpose": "assertionMethod",
        "proofValue": "zExampleSignatureValue..."
      }
    }
    ''';
  }

  /// Verifies the cryptographic signature of an eIDAS credential (simulated).
  Future<domain.VerificationResult> verifyEidasCredential(
    EidasCredential credential,
  ) async {
    try {
      // Check if the credential has a proof
      if (credential.proof == null) {
        return domain.VerificationResult(
          isValid: false,
          message: "Credential does not contain a cryptographic proof",
        );
      }

      // Check expiration date
      final now = DateTime.now();
      if (credential.expirationDate != null &&
          credential.expirationDate!.isBefore(now)) {
        return domain.VerificationResult(
          isValid: false,
          message:
              "Credential expired on ${_formatDate(credential.expirationDate)}",
        );
      }

      // In a real implementation, this function would:
      // 1. Resolve the issuer's DID (from proof.verificationMethod or credential.issuer.id)
      // 2. Obtain the issuer's public key.
      // 3. Perform cryptographic signature verification using the key and proof details.
      // 4. Potentially check credential status (revocation).

      // For this demo, simulate a successful verification.
      await Future.delayed(
          const Duration(milliseconds: 700)); // Simulate verification time

      // TODO: Add more details to the success result if needed
      return domain.VerificationResult(
        isValid: true,
        message: 'eIDAS Credential verified successfully',
        // details: {
        //   'issuer': credential.issuer.id,
        //   'issuanceDate': _formatDate(credential.issuanceDate),
        //   'verificationMethod': credential.proof?.verificationMethod,
        //   'proofType': credential.proof?.type,
        // },
      );
    } catch (e) {
      // TODO: Log error
      return domain.VerificationResult(
        isValid: false,
        message: 'Error during eIDAS credential verification: $e',
      );
    }
  }

  /// Checks the revocation status of an eIDAS credential (simulated).
  Future<revocation.RevocationStatus> checkRevocationStatus(
    EidasCredential credential,
  ) async {
    try {
      // Check if the credential has status information
      if (credential.credentialStatus == null) {
        return revocation.RevocationStatus(
          isRevoked: false, // Assume not revoked if no status info
          message: 'No revocation status information available',
          lastChecked: DateTime.now(),
        );
      }

      // In a real implementation, this function would:
      // 1. Parse the credentialStatus object (e.g., StatusList2021Entry).
      // 2. Fetch the status list or query the status service indicated.
      // 3. Check the specific credential's status according to the mechanism.

      // For this demo, simulate a successful check (not revoked).
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate status check time

      // TODO: Implement actual status check logic based on credential.credentialStatus
      final statusId = credential.credentialStatus!.id;
      final statusType = credential.credentialStatus!.type;

      return revocation.RevocationStatus(
        isRevoked: false, // Assume not revoked in mock
        message: 'Status checked via $statusType ($statusId) - Assumed valid',
        lastChecked: DateTime.now(),
      );
    } catch (e) {
      // TODO: Log error
      return revocation.RevocationStatus(
        isRevoked: false, // Assume not revoked on error for safety? Or true?
        message: 'Error checking revocation status: $e',
        lastChecked: DateTime.now(),
        error: e.toString(),
      );
    }
  }

  /// Formats a DateTime object for display.
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    // Simple date formatting, adjust as needed
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// --- Helper Models --- //
// RevocationStatus class moved to its own file: revocation_status.dart
// /// Represents the result of a revocation status check.
// /// TODO: Consider moving to domain layer if generally applicable.
// class RevocationStatus {
//   RevocationStatus({
//     required this.isRevoked,
//     required this.message,
//     required this.lastChecked,
//     this.error,
//   });
// 
//   /// Indicates whether the credential is confirmed revoked.
//   final bool isRevoked;
// 
//   /// A message providing details about the status check outcome.
//   final String message;
// 
//   /// Timestamp indicating when the status was last checked.
//   final DateTime lastChecked;
// 
//   /// An optional error message if the status check failed.
//   final String? error;
// }
