import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_list_2021.freezed.dart';
part 'status_list_2021.g.dart';

/// Represents a Verifiable Credential of type `StatusList2021Credential`.
///
/// This specific type of Verifiable Credential acts as a container for a status list,
/// typically represented as a compressed bitstring (the `encodedList` within its subject).
/// It is used to efficiently check the status (e.g., revoked, suspended) of other
/// Verifiable Credentials that reference it.
///
/// Verifiers fetch this credential (using the URL provided in the `statusListCredential`
/// property of a `StatusList2021Entry`) and check the bit at the specified `statusListIndex`
/// within the decoded `encodedList` to determine the status.
///
/// Specification: <https://w3c-ccg.github.io/vc-status-list-2021/>
@freezed
class StatusList2021Credential with _$StatusList2021Credential {
  const factory StatusList2021Credential({
    /// The unique identifier (URI) for this Status List credential.
    /// This is the URL that other credentials reference in their `statusListCredential` field.
    required String id,

    /// The JSON-LD context(s). Must include the base VC context (`https://www.w3.org/2018/credentials/v1`)
    /// and the StatusList2021 context (`https://w3id.org/vc/status-list/2021/v1`).
    @JsonKey(name: '@context') required List<String> context,

    /// The type(s) of the credential. Must include `VerifiableCredential` and `StatusList2021Credential`.
    required List<String> type,

    /// The DID or URI of the issuer responsible for creating and maintaining this status list.
    required String issuer,

    /// The date and time when this specific version of the status list credential was issued.
    /// Verifiers use this to determine the freshness of the status information.
    required DateTime issuanceDate,

    /// An optional date and time after which this status list credential (and the statuses it represents)
    /// should no longer be considered valid.
    DateTime? expirationDate,

    /// An optional human-readable description of the status list (e.g., "Revocation List for Employee Badges").
    String? description,

    /// The main subject of the credential, containing the actual status list data.
    /// See [StatusList2021Subject].
    required StatusList2021Subject credentialSubject,

    /// The cryptographic proof (e.g., digital signature) that ensures the integrity and authenticity
    /// of the status list credential, binding its contents to the issuer.
    /// See [StatusList2021Proof].
    required StatusList2021Proof proof,
  }) = _StatusList2021Credential;

  /// Creates a [StatusList2021Credential] instance from a JSON map.
  factory StatusList2021Credential.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021CredentialFromJson(json);
}

/// Represents the `credentialSubject` property of a [StatusList2021Credential].
///
/// This object contains the core information about the status list itself, most importantly
/// the `encodedList` which is a compressed bitstring representing the individual statuses.
@freezed
class StatusList2021Subject with _$StatusList2021Subject {
  const factory StatusList2021Subject({
    /// An identifier for the subject, often constructed from the credential ID (e.g., `credentialId#list`).
    required String id,

    /// The type of the credential subject. Must be `StatusList2021`.
    required String type,

    /// Specifies the purpose of the status entries in this list (e.g., revocation, suspension).
    /// This determines how the bits in the `encodedList` are interpreted.
    /// See [StatusPurpose].
    required StatusPurpose statusPurpose,

    /// Specifies the encoding format used for the `encodedList`. While the spec allows flexibility,
    /// it's typically expected to be a format like base64url combined with a compression algorithm (e.g., GZip).
    /// The exact method (compression + encoding) should ideally be discoverable or standardized.
    /// Defaulting to 'base64url' assumes the consumer knows about potential compression.
    @Default('base64url') String encoding,

    /// The core status list, represented as a compressed bitstring, typically encoded
    /// using base64url after compression (e.g., GZip).
    /// After decoding and decompressing, this yields a sequence of bits.
    /// Each bit corresponds to a specific `statusListIndex` from a [StatusList2021Entry].
    /// If `statusPurpose` is `revocation`, a '1' bit usually means revoked, '0' means not revoked.
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

/// Represents the `proof` property required by a Verifiable Credential,
/// specifically for a [StatusList2021Credential].
///
/// Contains the details necessary to verify the integrity and authenticity of the
/// status list credential, typically via a digital signature linked to the issuer.
@freezed
class StatusList2021Proof with _$StatusList2021Proof {
  const factory StatusList2021Proof({
    /// The type of the cryptographic suite used for the proof (e.g., `Ed25519Signature2020`).
    /// Determines the algorithms used for signing and verification.
    required String type,

    /// The timestamp when the proof (signature) was generated.
    required DateTime created,

    /// The DID URL identifying the specific public key (verification method) of the issuer
    /// used to create the proof. This is essential for verifiers to locate the correct key.
    required String verificationMethod,

    /// The relationship between the verification method and the issuer (e.g., `assertionMethod`)
    /// indicating the purpose for which the key is authorized.
    required String proofPurpose,

    /// The digital signature or proof value itself, typically encoded in base64url or multibase format.
    /// This value is verified against the credential data using the issuer's public key.
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

/// Defines the intended semantic meaning of the status values encoded in the status list.
///
/// This helps interpret the boolean value associated with a specific index in the decoded list.
enum StatusPurpose {
  /// Indicates the status list is used to signal credential revocation.
  /// A '1' at the corresponding index typically means the credential IS revoked.
  /// A '0' typically means the credential IS NOT revoked.
  @JsonValue('revocation')
  revocation,

  /// Indicates the status list is used to signal credential suspension.
  /// A '1' at the corresponding index typically means the credential IS suspended.
  /// A '0' typically means the credential IS NOT suspended.
  /// (Note: Suspension purpose might be less commonly implemented than revocation).
  @JsonValue('suspension')
  suspension,
}

/// Represents the `credentialStatus` property as found within a standard Verifiable Credential
/// when it uses the `StatusList2021` mechanism.
///
/// This object acts as a pointer, directing a verifier to the specific
/// [StatusList2021Credential] (`statusListCredential`) and the exact position (`statusListIndex`)
/// within that list to check for the status of the credential containing this entry.
@freezed
class StatusList2021Entry with _$StatusList2021Entry {
  const factory StatusList2021Entry({
    /// A unique identifier for this status entry itself. Conventionally, this might be
    /// constructed as `<statusListCredential_URL>#<statusListIndex>`.
    required String id,

    /// The type of this status entry object. Must be `StatusList2021` according to the standard.
    /// (Note: The class name is `StatusList2021Entry` for clarity in Dart, but the `type` field
    /// in the JSON representation should be `StatusList2021`).
    @Default('StatusList2021') String type,

    /// The purpose of the status check (e.g., "revocation"). This MUST match the
    /// `statusPurpose` declared in the `credentialSubject` of the referenced
    /// [StatusList2021Credential] for the check to be valid.
    /// See [StatusPurpose].
    required StatusPurpose statusPurpose,

    /// The URL (or DID) identifying the [StatusList2021Credential] that holds the
    /// actual bitstring list relevant to this credential.
    required String statusListCredential,

    /// The zero-based index of the bit within the `encodedList` (after decoding and decompression)
    /// of the credential at `statusListCredential`. This bit represents the status.
    required int statusListIndex,
  }) = _StatusList2021Entry;

  /// Creates a [StatusList2021Entry] instance from a JSON map.
  factory StatusList2021Entry.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021EntryFromJson(json);
}
