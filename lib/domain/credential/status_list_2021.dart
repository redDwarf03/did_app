import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_list_2021.freezed.dart';
part 'status_list_2021.g.dart';

/// Represents a Verifiable Credential of type "StatusList2021Credential".
///
/// This specific type of Verifiable Credential contains a bitstring (the status list)
/// used to check the status (e.g., revoked, suspended) of other Verifiable Credentials.
/// It provides a highly efficient way to manage the status of a large number of credentials.
///
/// Specification: https://w3c-ccg.github.io/vc-status-list-2021/
@freezed
class StatusList2021Credential with _$StatusList2021Credential {
  const factory StatusList2021Credential({
    /// The unique identifier (URI) for this Status List credential.
    required String id,

    /// The JSON-LD context(s). Must include the VC context and the StatusList2021 context.
    /// e.g., ["https://www.w3.org/2018/credentials/v1", "https://w3id.org/vc/status-list/2021/v1"]
    @JsonKey(name: '@context') required List<String> context,

    /// The type(s) of the credential. Must include "VerifiableCredential" and "StatusList2021Credential".
    required List<String> type,

    /// The DID or URI of the issuer of this status list credential.
    required String issuer,

    /// The date and time when this status list credential was issued.
    required DateTime issuanceDate,

    /// An optional date and time after which this status list credential is no longer valid.
    DateTime? expirationDate,

    /// An optional human-readable description of the status list.
    String? description,

    /// The main subject of the credential, containing the actual status list data.
    /// See [StatusList2021Subject].
    required StatusList2021Subject credentialSubject,

    /// The cryptographic proof (e.g., digital signature) that binds the credential
    /// contents to the issuer and ensures integrity.
    /// See [StatusList2021Proof].
    required StatusList2021Proof proof,
  }) = _StatusList2021Credential;

  /// Creates a [StatusList2021Credential] instance from a JSON map.
  factory StatusList2021Credential.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021CredentialFromJson(json);
}

/// Represents the `credentialSubject` property of a [StatusList2021Credential].
///
/// This contains the core information about the status list itself, including the
/// encoded bitstring representing the statuses.
@freezed
class StatusList2021Subject with _$StatusList2021Subject {
  const factory StatusList2021Subject({
    /// An identifier for the subject, often the same as the credential ID or related.
    required String id,

    /// The type of the credential subject. Must be "StatusList2021".
    required String type,

    /// Specifies the purpose of the status entries (e.g., revocation, suspension).
    /// See [StatusPurpose].
    required StatusPurpose statusPurpose,

    /// The encoding format used for the `encodedList`. Defaults to "base64url".
    /// Other potential values might include "base64", although "base64url" is common.
    @Default('base64url') String encoding,

    /// The core status list, represented as a compressed bitstring, encoded according
    /// to the specified `encoding` (typically base64url).
    /// Each bit in the decoded list corresponds to a specific `statusListIndex` from a
    /// [StatusList2021Entry]. A '1' usually indicates the status applies (e.g., revoked),
    /// while a '0' indicates it does not.
    required String encodedList,

    // /// **Deprecated in Spec:** Optional validity period specifically for the status list.
    // /// The VC `issuanceDate` and `expirationDate` should be used instead.
    // /// Kept here for potential compatibility with older implementations. See [StatusList2021Validity].
    // StatusList2021Validity? validFrom,

    // /// **Deprecated in Spec:** The declared size (number of bits) of the status list.
    // /// The size should be inferred from the decoded `encodedList`. Kept for compatibility.
    // @Default(131072) int statusListSize, // Common default, but size varies.
  }) = _StatusList2021Subject;

  /// Creates a [StatusList2021Subject] instance from a JSON map.
  factory StatusList2021Subject.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021SubjectFromJson(json);
}

/// Represents the `proof` property of a [StatusList2021Credential].
///
/// Contains the cryptographic proof details, such as the signature type, creation date,
/// verification method (issuer's key), proof purpose, and the signature value.
@freezed
class StatusList2021Proof with _$StatusList2021Proof {
  const factory StatusList2021Proof({
    /// The type of the cryptographic suite used for the proof (e.g., "Ed25519Signature2020").
    required String type,

    /// The timestamp when the proof was generated.
    required DateTime created,

    /// The DID URL identifying the verification method (e.g., public key) used to create the proof.
    /// This is used by verifiers to check the signature.
    required String verificationMethod,

    /// The purpose for which the proof was created (e.g., "assertionMethod").
    required String proofPurpose,

    /// The digital signature or proof value itself, typically encoded in base64url or multibase.
    required String proofValue,
  }) = _StatusList2021Proof;

  /// Creates a [StatusList2021Proof] instance from a JSON map.
  factory StatusList2021Proof.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021ProofFromJson(json);
}

// /// **Deprecated in Spec:** Represents a validity period for a status list.
// /// Use `issuanceDate` and `expirationDate` on the `StatusList2021Credential` instead.
// /// Kept here for potential compatibility.
// @freezed
// class StatusList2021Validity with _$StatusList2021Validity {
//   const factory StatusList2021Validity({
//     /// Start date of validity.
//     required DateTime validFrom,
//     /// End date of validity.
//     DateTime? validUntil,
//   }) = _StatusList2021Validity;
//
//   factory StatusList2021Validity.fromJson(Map<String, dynamic> json) =>
//       _$StatusList2021ValidityFromJson(json);
// }

/// Defines the intended meaning of the status values in the list.
enum StatusPurpose {
  /// Indicates the status list is used to signal credential revocation.
  /// A '1' at the corresponding index means the credential is revoked.
  @JsonValue('revocation')
  revocation,

  /// Indicates the status list is used to signal credential suspension.
  /// A '1' at the corresponding index means the credential is suspended.
  /// (Note: Suspension is less common and support may vary).
  @JsonValue('suspension')
  suspension,
}

/// Represents the `credentialStatus` property within a Verifiable Credential
/// that points to an entry in a [StatusList2021Credential].
///
/// This object tells a verifier where (which list and which index) to check
/// the status of the credential it is embedded within.
@freezed
class StatusList2021Entry with _$StatusList2021Entry {
  const factory StatusList2021Entry({
    /// The identifier for this status entry, typically the VC ID + '#status-<index>'.
    required String id,

    /// The type of this status entry. Must be "StatusList2021".
    /// (Note: The spec defines this as "StatusList2021", not "StatusList2021Entry").
    @Default('StatusList2021') String type,

    /// The purpose of the status check (e.g., "revocation"). Should match the
    /// `statusPurpose` of the referenced [StatusList2021Credential].
    /// See [StatusPurpose].
    required StatusPurpose statusPurpose,

    /// The URL (typically the `id`) of the [StatusList2021Credential] containing the relevant status list.
    required String statusListCredential,

    /// The zero-based index of the bit within the `encodedList` (after decoding)
    /// that represents the status of the credential containing this entry.
    required int statusListIndex,
  }) = _StatusList2021Entry;

  /// Creates a [StatusList2021Entry] instance from a JSON map.
  factory StatusList2021Entry.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021EntryFromJson(json);
}
