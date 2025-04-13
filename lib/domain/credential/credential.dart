import 'package:did_app/domain/credential/status_list_2021.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.freezed.dart';
part 'credential.g.dart';

/// Represents the verification status of a Verifiable Credential.
enum VerificationStatus {
  /// The verification status has not been determined yet.
  unverified,

  /// The credential has been successfully verified.
  verified,

  /// The credential failed verification (e.g., signature mismatch, invalid structure).
  invalid,

  /// The credential has expired based on its `expirationDate`.
  expired,

  /// The credential has been revoked by the issuer.
  revoked,
}

/// Defines the supported types of Verifiable Credentials within this application.
/// These types help categorize credentials and can influence UI representation or processing logic.
enum CredentialType {
  /// Represents a diploma or educational achievement.
  diploma,

  /// Represents proof of identity.
  identity,

  /// Represents a driver's license.
  drivingLicense,

  /// Represents a medical certificate.
  medicalCertificate,

  /// Represents a professional badge or certification.
  professionalBadge,

  /// Represents health insurance information.
  healthInsurance,

  /// Represents proof of employment.
  employmentProof,

  /// Represents verification of age.
  ageVerification,

  /// Represents proof of address.
  addressProof,

  /// Represents a membership card for an organization or club.
  membershipCard,

  /// Represents any other type of credential not explicitly listed.
  other,
}

/// Represents a Verifiable Credential (VC) based on the W3C VC Data Model v2.0.
///
/// A Verifiable Credential is a set of claims made by an issuer about a subject.
/// This model includes core properties defined by the standard, along with some
/// application-specific fields like `name` and `description`.
///
/// See: https://www.w3.org/TR/vc-data-model-2.0/
@freezed
class Credential with _$Credential {
  /// Creates a Credential instance.
  ///
  /// Corresponds to the core properties of a VC.
  const factory Credential({
    /// A unique identifier for the credential (URI). REQUIRED by W3C standard.
    /// Corresponds to the `id` property in the W3C VC Data Model.
    required String id,

    /// One or more URIs identifying the type(s) of the credential. REQUIRED.
    /// The first type MUST be `VerifiableCredential`. Additional types define the specific credential schema.
    /// Corresponds to the `type` property in the W3C VC Data Model.
    required List<String> type,

    /// The Decentralized Identifier (DID) URI or other identifier of the issuer. REQUIRED.
    /// Corresponds to the `issuer` property in the W3C VC Data Model. Can be a URI or an object containing an `id`.
    required String issuer, // W3C allows string or object { id: string, ... }

    /// A human-readable name for the credential. OPTIONAL.
    /// Not part of the core W3C VC model, but useful for display.
    String? name,

    /// A human-readable description of the credential. OPTIONAL.
    /// Not part of the core W3C VC model, but useful for display.
    String? description,

    /// The identifier (e.g., DID URI) of the subject/holder of the credential. OPTIONAL.
    /// If not present, the credential subject is typically identified indirectly or is the holder.
    /// Corresponds to the `credentialSubject.id` property if the subject is represented by a URI.
    String? subject, // Often inferred or part of credentialSubject

    /// The date and time when the credential was issued. REQUIRED.
    /// Must be an XMLSchema dateTime value (e.g., '2023-10-26T10:00:00Z').
    /// Corresponds to the `issuanceDate` property in the W3C VC Data Model.
    required DateTime issuanceDate,

    /// The date and time when the credential expires. OPTIONAL.
    /// Must be an XMLSchema dateTime value. If absent, the credential does not expire.
    /// Corresponds to the `expirationDate` property in the W3C VC Data Model.
    DateTime? expirationDate,

    /// **DEPRECATED:** Use the `status` field instead.
    /// URL pointing to the Status List 2021 credential used for revocation checks.
    /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
    /// See: https://w3c-ccg.github.io/vc-status-list-2021/
    @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object',
    )
    String? statusListUrl,

    /// **DEPRECATED:** Use the `status` field instead.
    /// Index within the Status List 2021 bitstring.
    /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
    @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object',
    )
    int? statusListIndex,

    /// The current verification status of the credential (a local assessment). OPTIONAL.
    /// This is application-specific and not part of the core W3C VC model's properties.
    @Default(VerificationStatus.unverified)
    VerificationStatus verificationStatus,

    /// Information about the schema used for the credential's subject data. OPTIONAL.
    /// Helps interpret the `credentialSubject` data structure.
    /// Corresponds to the `credentialSchema` property in the W3C VC Data Model (can be object or array).
    /// Use [CredentialSchema] for a typed representation.
    Map<String, dynamic>?
        credentialSchema, // W3C allows object or array { id: string, type: string, ... }

    /// Information used to determine the current status of the credential (e.g., revocation). OPTIONAL.
    /// Corresponds to the `credentialStatus` property in the W3C VC Data Model.
    /// Must contain `id` and `type`. Example type: `StatusList2021Entry`.
    /// Use [CredentialStatus] or specific implementations like [StatusList2021Entry].
    /// See: https://www.w3.org/TR/vc-data-model-2.0/#status
    Map<String, dynamic>?
        status, // W3C requires { id: string, type: string, ... }

    /// Indicates if the credential supports Zero-Knowledge Proofs (ZKPs). OPTIONAL.
    /// This is a non-standard property, specific to the application's ZKP implementation.
    @Default(false) bool supportsZkp,

    /// The claims (properties) about the subject. REQUIRED.
    /// This is the core data payload of the credential. Its structure is defined by the credential `type` and `credentialSchema`.
    /// Corresponds to the `credentialSubject` property in the W3C VC Data Model.
    /// Can be a map or a list of maps. Must contain at least an `id` if representing a specific entity.
    required Map<String, dynamic>
        credentialSubject, // W3C allows object or array

    /// The JSON-LD context(s) used in the credential. REQUIRED.
    /// Defines the vocabulary used in the credential. The first item MUST be `https://www.w3.org/ns/credentials/v2`.
    /// Corresponds to the `@context` property in the W3C VC Data Model.
    @Default(<String>['https://www.w3.org/ns/credentials/v2'])
    @JsonKey(name: '@context')
    List<String> context, // Reverted to List<String> for compatibility

    /// One or more cryptographic proofs verifying the credential's integrity and issuer. REQUIRED.
    /// Contains information like the proof type, creation date, verification method, and proof value.
    /// Corresponds to the `proof` property in the W3C VC Data Model.
    /// Can be a single proof object or an array of proof objects. Use the [Proof] model.
    required Map<String, dynamic> proof, // W3C allows object or array
  }) = _Credential;

  /// Private constructor for implementing custom getters and methods.
  const Credential._();

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  /// Alias for `issuanceDate`. Provides semantic alternative.
  DateTime get issuedAt => issuanceDate;

  /// Alias for `expirationDate`. Provides semantic alternative.
  DateTime? get expiresAt => expirationDate;

  /// Alias for `credentialSubject`. Provides semantic alternative for accessing claims.
  Map<String, dynamic> get claims => credentialSubject;

  /// Checks if the credential is currently considered valid based on its expiration date.
  /// Returns `true` if `expirationDate` is null or in the future.
  /// Returns `false` if `expirationDate` is in the past.
  bool get isValid =>
      expirationDate == null || expirationDate!.isAfter(DateTime.now());

  /// Checks if the credential's status indicates it is revoked.
  /// This is a preliminary check based on the local `verificationStatus`.
  /// A full revocation check requires processing the `status` property against the corresponding Status List.
  /// TODO: Implement full revocation check using `getStatusList2021Entry()` and fetching/checking the list.
  bool get isRevoked =>
      verificationStatus ==
      VerificationStatus.revoked; // Placeholder - needs actual check

  /// Attempts to extract Status List 2021 entry information from the `status` property map.
  ///
  /// Returns a [StatusList2021Entry] object if the `status` map conforms to the
  /// StatusList2021Entry structure (has `type='StatusList2021Entry'`, `statusListCredential`,
  /// `statusPurpose`, and `statusListIndex`).
  ///
  /// Returns `null` if the `status` property is missing, null, not a map,
  /// lacks the required fields, has an incorrect `type`, or if parsing fails.
  StatusList2021Entry? getStatusList2021Entry() {
    // Check if status exists and is a map
    if (status == null || status is! Map<String, dynamic>) {
      return null;
    }
    final statusMap = status!;

    // Check for mandatory 'type' field
    // Accept both 'StatusList2021Entry' (common in embedded status)
    // and 'StatusList2021' (type used in StatusList2021 spec itself)
    final statusType = statusMap['type'] as String?;
    if (statusType != 'StatusList2021Entry' && statusType != 'StatusList2021') {
      if (kDebugMode) {
        print(
          'Status check failed: status type "$statusType" is not StatusList2021Entry or StatusList2021.',
        );
      }
      return null;
    }

    try {
      // Extract required fields, checking for nulls where necessary
      final statusListCredential = statusMap['statusListCredential'] as String?;
      final statusPurposeStr = statusMap['statusPurpose'] as String?;
      final dynamic statusListIndexDynamic =
          statusMap['statusListIndex']; // Read as dynamic first
      final id = statusMap['id']
          as String?; // ID is also required by status list entry spec

      // Validate mandatory fields are present
      if (statusListCredential == null ||
          statusPurposeStr == null ||
          statusListIndexDynamic == null ||
          id == null) {
        return null;
      }

      // Convert statusListIndex to int
      final int statusListIndex;
      if (statusListIndexDynamic is int) {
        statusListIndex = statusListIndexDynamic;
      } else if (statusListIndexDynamic is String) {
        statusListIndex = int.tryParse(statusListIndexDynamic) ?? 0;
      } else {
        if (kDebugMode) {
          print(
            'StatusList2021Entry parsing failed: statusListIndex is not a valid integer.',
          );
        }
        return null;
      }

      // Parse StatusPurpose enum robustly using .name
      final statusPurpose = StatusPurpose.values.firstWhere(
        (p) => p.name.toLowerCase() == statusPurposeStr.toLowerCase(),
        orElse: () {
          if (kDebugMode) {
            print(
              'StatusList2021Entry parsing warning: Unknown statusPurpose "$statusPurposeStr", defaulting to revocation.',
            );
          }
          return StatusPurpose
              .revocation; // Default to revocation if purpose is missing/invalid
        },
      );

      return StatusList2021Entry(
        id: id, // Use the mandatory ID from the status map
        // Use the actual type found in the map
        type: statusType!,
        statusListCredential: statusListCredential,
        statusPurpose: statusPurpose,
        statusListIndex: statusListIndex,
      );
    } catch (e, stacktrace) {
      // Catch potential type errors or other exceptions during field access/parsing
      if (kDebugMode) {
        print('Error parsing StatusList2021Entry: $e\n$stacktrace');
      }
      return null; // Return null if any parsing step fails
    }
  }
}

/// Represents a Verifiable Presentation (VP) based on the W3C VC Data Model v2.0.
///
/// A Verifiable Presentation is a data format used to present Verifiable Credentials
/// to a verifier. It can bundle one or more credentials and includes a proof generated
/// by the holder to demonstrate control over the credentials.
///
/// See: https://www.w3.org/TR/vc-data-model-2.0/#presentations-0
@freezed
class CredentialPresentation with _$CredentialPresentation {
  /// Creates a CredentialPresentation instance.
  const factory CredentialPresentation({
    /// The JSON-LD context(s) used in the presentation. REQUIRED.
    /// Defines the vocabulary used. The first item MUST be `https://www.w3.org/2018/credentials/v1`.
    /// Corresponds to the `@context` property in the W3C VC Data Model.
    @Default(<String>['https://www.w3.org/2018/credentials/v1'])
    @JsonKey(name: '@context')
    List<String> context,

    /// A unique identifier for the presentation (URI). OPTIONAL.
    /// Corresponds to the `id` property in the W3C VC Data Model.
    String? id,

    /// One or more URIs identifying the type(s) of the presentation. REQUIRED.
    /// The first type MUST be `VerifiablePresentation`. Additional types can be used.
    /// Corresponds to the `type` property in the W3C VC Data Model.
    required List<String> type,

    /// The identifier (e.g., DID URI) of the holder who created the presentation. REQUIRED.
    /// Corresponds to the `holder` property in the W3C VC Data Model.
    required String holder,

    /// One or more Verifiable Credentials being presented. OPTIONAL but typically present.
    /// Corresponds to the `verifiableCredential` property in the W3C VC Data Model.
    /// Can be an array of VCs (as JSON strings or objects).
    @JsonKey(name: 'verifiableCredential')
    List<Credential>? verifiableCredentials,

    /// Information about which credential attributes are revealed. OPTIONAL.
    /// Used in conjunction with ZKP schemes like BBS+ for selective disclosure.
    /// This field's structure depends on the specific ZKP implementation.
    Map<String, List<String>>? revealedAttributes,

    /// Information about predicates used in the presentation. OPTIONAL.
    /// Used with ZKP schemes to prove statements about credential attributes
    /// without revealing the attributes themselves.
    List<CredentialPredicate>? predicates,

    /// A cryptographic proof generated by the holder. REQUIRED.
    /// Demonstrates control over the presented credentials and the presentation itself.
    /// Corresponds to the `proof` property in the W3C VC Data Model.
    /// Can be a single proof object or an array. Use the [Proof] model.
    required Map<String, dynamic> proof, // W3C allows object or array

    /// The date and time when the presentation was created. OPTIONAL.
    /// Useful for tracking presentation freshness. Not explicitly in the core model,
    /// but often included within the proof (`created`).
    DateTime? created,

    /// A nonce or challenge provided by the verifier. OPTIONAL but recommended for replay protection.
    /// Corresponds to the `challenge` property used within some proof types (e.g., `proof.challenge`).
    String? challenge,

    /// The intended domain or audience for the presentation. OPTIONAL but recommended.
    /// Helps prevent presentation reuse across different relying parties.
    /// Corresponds to the `domain` property used within some proof types (e.g., `proof.domain`).
    String? domain,
  }) = _CredentialPresentation;

  const CredentialPresentation._(); // Private constructor for potential custom logic

  factory CredentialPresentation.fromJson(Map<String, dynamic> json) =>
      _$CredentialPresentationFromJson(json);
}

/// Represents a predicate used in Zero-Knowledge Proofs (ZKPs) for selective disclosure.
///
/// Allows proving a statement about a credential attribute (e.g., "age >= 21")
/// without revealing the exact value of the attribute. This enhances privacy.
/// This structure is specific to a ZKP implementation and not part of the core W3C VC/VP model.
@freezed
class CredentialPredicate with _$CredentialPredicate {
  /// Creates a CredentialPredicate instance.
  const factory CredentialPredicate({
    /// The identifier of the credential to which the predicate applies.
    required String credentialId,

    /// The specific attribute (claim) within the credential subject to apply the predicate to.
    /// Can use dot notation for nested attributes (e.g., "address.postalCode").
    required String attribute,

    /// A human-readable name for the attribute, potentially used for display purposes during proof request generation.
    required String attributeName,

    /// The predicate operator (e.g., ">=", "<=", "=="). Defines the comparison logic.
    required String predicate,

    /// The type of the predicate, indicating the ZKP scheme or constraint system used (e.g., range proof, set membership).
    required PredicateType predicateType,

    /// The value to compare the attribute against using the predicate operator.
    /// The type of this value should match the type of the credential attribute.
    required dynamic value,
  }) = _CredentialPredicate;

  factory CredentialPredicate.fromJson(Map<String, dynamic> json) =>
      _$CredentialPredicateFromJson(json);
}

/// Represents the cryptographic proof associated with a Verifiable Credential (VC) or Verifiable Presentation (VP).
///
/// Based on the `proof` property in the W3C VC/VP Data Model. Contains the essential
/// information needed to verify the integrity and authenticity of the VC or VP.
/// See: https://www.w3.org/TR/vc-data-model-2.0/#proofs-signatures
@freezed
class Proof with _$Proof {
  /// Creates a Proof instance.
  const factory Proof({
    /// The type of the cryptographic proof suite used (e.g., "DataIntegrityProof", "Ed25519Signature2020"). REQUIRED.
    /// Identifies the algorithms and protocols used to generate and verify the proof.
    /// Corresponds to the `type` property of the proof.
    required String type,

    /// The date and time when the proof was created. REQUIRED.
    /// Must be an XMLSchema dateTime value. Used to check against credential validity and potential replay attacks.
    /// Corresponds to the `created` property of the proof.
    required DateTime created,

    /// The purpose of the proof, indicating the relationship between the proof and the controller. REQUIRED.
    /// Examples: "assertionMethod" (for VCs, issuer asserts claims), "authentication" (for VPs, holder authenticates).
    /// Corresponds to the `proofPurpose` property of the proof.
    required String proofPurpose,

    /// The identifier (e.g., DID URL with fragment) of the verification method used to create the proof. REQUIRED.
    /// This typically points to the public key required to verify the proof.
    /// Corresponds to the `verificationMethod` property of the proof.
    required String verificationMethod,

    /// The value of the cryptographic proof itself (e.g., the digital signature). REQUIRED.
    /// The format depends on the proof `type` (e.g., base64url, multibase).
    /// Corresponds to the `proofValue` property of the proof.
    required String
        proofValue, // Often multibase encoded, e.g., starting with 'z'

    /// The intended domain for which the proof is valid (relevant for VPs). OPTIONAL.
    /// Helps prevent replay attacks across different domains (audiences).
    /// Corresponds to the `domain` property of the proof options.
    String? domain,

    /// The cryptographic challenge provided by the verifier (relevant for VPs). OPTIONAL.
    /// Ensures the proof was created in response to a specific request, preventing replay.
    /// Corresponds to the `challenge` property of the proof options.
    String? challenge,

    // --- Additional properties for DataIntegrityProof ---
    // These might be nested or directly part of the proof depending on the exact proof type.
    // Example: cryptographicSuite for DataIntegrityProof
    // String? cryptographicSuite, // e.g., "eddsa-rdfc-2022"
  }) = _Proof;

  factory Proof.fromJson(Map<String, dynamic> json) => _$ProofFromJson(json);
}

/// Represents the base structure for credential status information, aligning with W3C VC Data Model.
/// Specific status methods like StatusList2021 extend this concept.
/// See: https://www.w3.org/TR/vc-data-model-2.0/#status
@freezed
class CredentialStatus with _$CredentialStatus {
  /// Creates a CredentialStatus instance.
  const factory CredentialStatus({
    /// The unique identifier of the status entry (URI). REQUIRED.
    required String id,

    /// The type of the credential status mechanism (e.g., "StatusList2021Entry"). REQUIRED.
    required String type,
    // Add other common fields if necessary, or handle specific types via subclasses/factories
  }) = _CredentialStatus;

  factory CredentialStatus.fromJson(Map<String, dynamic> json) =>
      _$CredentialStatusFromJson(json);
}

/// Represents the structure for credential schema information, aligning with W3C VC Data Model.
/// See: https://www.w3.org/TR/vc-data-model-2.0/#data-schemas
@freezed
class CredentialSchema with _$CredentialSchema {
  /// Creates a CredentialSchema instance.
  const factory CredentialSchema({
    /// The unique identifier of the schema (URI). REQUIRED.
    required String id,

    /// The type of the credential schema (e.g., "JsonSchema"). REQUIRED.
    required String type,
    // Add other schema-specific fields if needed based on the type
  }) = _CredentialSchema;

  factory CredentialSchema.fromJson(Map<String, dynamic> json) =>
      _$CredentialSchemaFromJson(json);
}

/// Defines the types of predicates supported for Zero-Knowledge Proofs.
/// This enum should align with the capabilities of the underlying ZKP library.
enum PredicateType {
  /// Predicate proving an attribute value is greater than a given value.
  greaterThan,

  /// Predicate proving an attribute value is greater than or equal to a given value.
  greaterThanOrEqual,

  /// Predicate proving an attribute value is less than a given value.
  lessThan,

  /// Predicate proving an attribute value is less than or equal to a given value.
  lessThanOrEqual,

  /// Predicate proving an attribute value is equal to a given value.
  equal;

  /// Returns a human-readable representation of the predicate operator.
  String get humanReadable {
    switch (this) {
      case PredicateType.greaterThan:
        return '>';
      case PredicateType.greaterThanOrEqual:
        return '≥';
      case PredicateType.lessThan:
        return '<';
      case PredicateType.lessThanOrEqual:
        return '≤';
      case PredicateType.equal:
        return '=';
    }
  }
}

/// Represents the value associated with a ZKP predicate request.
/// Combines the attribute name, predicate type, and comparison value.
@freezed
class CredentialPredicateValue with _$CredentialPredicateValue {
  /// Creates a CredentialPredicateValue instance.
  const factory CredentialPredicateValue({
    /// Name of the attribute the predicate applies to (e.g., "age", "nationality").
    required String attributeName,

    /// The type of comparison to perform. See [PredicateType].
    required PredicateType predicateType,

    /// The value to use in the comparison.
    required dynamic value,
  }) = _CredentialPredicateValue;

  factory CredentialPredicateValue.fromJson(Map<String, dynamic> json) =>
      _$CredentialPredicateValueFromJson(json);
}
