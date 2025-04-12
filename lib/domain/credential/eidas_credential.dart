import 'package:did_app/domain/credential/credential.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eidas_credential.freezed.dart';
part 'eidas_credential.g.dart';

/// Represents a Verifiable Credential structured according to the eIDAS 2.0 framework
@freezed
class EidasCredential with _$EidasCredential {
  const factory EidasCredential({
    required String id,
    required List<String> type,
    required EidasIssuer issuer,
    required DateTime issuanceDate,
    required Map<String, dynamic> credentialSubject,
    DateTime? expirationDate,
    EidasCredentialSchema? credentialSchema,
    EidasCredentialStatus? credentialStatus,
    EidasProof? proof,
    List<EidasEvidence>? evidence,
  }) = _EidasCredential;

  factory EidasCredential.fromJson(Map<String, dynamic> json) =>
      _$EidasCredentialFromJson(json);

  const EidasCredential._();

  Credential toCredential() {
    return Credential(
      id: id,
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://ec.europa.eu/2023/credentials/eidas/v1',
      ],
      type: type,
      issuanceDate: issuanceDate,
      issuer: issuer.id,
      subject: credentialSubject['id'] as String? ?? '',
      credentialSubject: credentialSubject,
      expirationDate: expirationDate,
      proof: proof?.toJson() ?? {},
      status: credentialStatus?.toJson(),
      credentialSchema: credentialSchema?.toJson(),
      name: _getReadableName(),
      supportsZkp: true,
    );
  }

  String _getReadableName() {
    if (type.contains('VerifiableId')) {
      return 'eIDAS Digital Identity';
    } else if (type.contains('VerifiableAttestation')) {
      return 'eIDAS Verifiable Attestation';
    } else if (type.contains('VerifiableDiploma')) {
      return 'Verifiable Diploma';
    } else if (type.contains('VerifiableAuthorisation')) {
      return 'eIDAS Authorisation';
    }
    return type.join(', ');
  }
}

/// Represents the issuer of an eIDAS credential.
@freezed
class EidasIssuer with _$EidasIssuer {
  const factory EidasIssuer({
    /// The unique identifier (e.g., DID or URI) of the issuer. REQUIRED (either direct string or in object).
    required String id,

    /// Optional human-readable name of the issuer.
    String? name,

    /// Optional URL to an image representing the issuer.
    String? image,

    /// Optional URL for more information about the issuer.
    String? url,

    /// Optional type of the issuing organization (e.g., government, private).
    String? organizationType,

    /// Optional registration number of the issuer organization.
    String? registrationNumber,

    /// Optional structured address of the issuer.
    Map<String, dynamic>? address,
  }) = _EidasIssuer;
  // Standard fromJson that delegates to the helper
  factory EidasIssuer.fromJson(dynamic json) => fromJsonHelper(json);

  // Helper method for JSON deserialization
  static EidasIssuer fromJsonHelper(dynamic json) {
    if (json is String) {
      // If issuer is just a string (URI/DID), create EidasIssuer with only the id.
      return EidasIssuer(id: json);
    } else if (json is Map<String, dynamic>) {
      // If issuer is an object, use the generated fromJson factory.
      return _$EidasIssuerFromJson(json);
    }
    throw FormatException('Invalid issuer format: ${json.runtimeType}');
  }
}

/// Represents the schema referenced by an eIDAS credential.
@freezed
class EidasCredentialSchema with _$EidasCredentialSchema {
  const factory EidasCredentialSchema({
    /// The unique identifier (URI) of the schema. REQUIRED.
    required String id,

    /// The type of the schema (e.g., "JsonSchemaValidator2018", "ShapeExpressionSchema"). REQUIRED.
    required String type,
  }) = _EidasCredentialSchema;

  factory EidasCredentialSchema.fromJson(Map<String, dynamic> json) =>
      _$EidasCredentialSchemaFromJson(json);
}

/// Represents the status information for an eIDAS credential.
@freezed
class EidasCredentialStatus with _$EidasCredentialStatus {
  const factory EidasCredentialStatus({
    /// The unique identifier of the status entry (URI). REQUIRED.
    required String id,

    /// The type of the credential status mechanism used (e.g., "StatusList2021"). REQUIRED.
    required String type,

    /// Optional purpose of the status (e.g., "revocation", "suspension").
    String? statusPurpose,

    /// Optional index within the status list (used with StatusList2021).
    int? statusListIndex,

    /// Optional URL of the status list credential (used with StatusList2021).
    String? statusListCredential,
  }) = _EidasCredentialStatus;

  factory EidasCredentialStatus.fromJson(Map<String, dynamic> json) =>
      _$EidasCredentialStatusFromJson(json);
}

/// Represents the cryptographic proof associated with an eIDAS credential.
@freezed
class EidasProof with _$EidasProof {
  const factory EidasProof({
    /// The type of the cryptographic proof suite used. REQUIRED.
    required String type,

    /// The date and time when the proof was created. REQUIRED.
    required DateTime created,

    /// The identifier (e.g., DID URL) of the verification method used. REQUIRED.
    required String verificationMethod,

    /// The purpose of the proof (e.g., "assertionMethod", "authentication"). REQUIRED.
    required String proofPurpose,

    /// The value of the cryptographic proof (e.g., signature). REQUIRED.
    required String proofValue,

    /// Optional challenge used in the proof creation (relevant for VPs).
    String? challenge,

    /// Optional domain for which the proof is valid (relevant for VPs).
    String? domain,

    /// Optional JSON Web Signature (JWS) if the proof is in JWS format.
    String? jws,
  }) = _EidasProof;

  factory EidasProof.fromJson(Map<String, dynamic> json) =>
      _$EidasProofFromJson(json);
}

/// Represents evidence used during the issuance of an eIDAS credential.
@freezed
class EidasEvidence with _$EidasEvidence {
  const factory EidasEvidence({
    /// The type of evidence provided (e.g., "DocumentVerification", "IdentityVerification"). REQUIRED.
    required String type,

    /// Identifier of the entity that verified the evidence. REQUIRED.
    required String verifier,

    /// Optional list of identifiers or references to evidence documents.
    List<String>? evidenceDocument,

    /// Optional indicator of the subject's presence during verification (e.g., "Physical", "Digital").
    String? subjectPresence,

    /// Optional indicator of the document's presence during verification (e.g., "Physical", "Digital").
    String? documentPresence,

    /// Optional timestamp related to the evidence collection or verification.
    DateTime? time,
  }) = _EidasEvidence;

  factory EidasEvidence.fromJson(Map<String, dynamic> json) =>
      _$EidasEvidenceFromJson(json);
}
