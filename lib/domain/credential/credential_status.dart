import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_status.freezed.dart';
part 'credential_status.g.dart';

/// Defines the possible high-level statuses of a Verifiable Credential (VC).
///
/// This enum represents the overall validity state of a VC after considering
/// factors like revocation, expiration, and the result of status checks.
enum CredentialStatusType {
  /// The credential is currently considered valid (not revoked or expired).
  valid,

  /// The credential has been revoked by the issuer.
  /// Details should be checked in the corresponding [CredentialStatus] object.
  revoked,

  /// The credential has passed its expiration date.
  expired,

  /// The status of the credential could not be determined or is unknown.
  /// This might occur if a status check failed or is pending.
  unknown
}

/// Enumerates common reasons for credential revocation, providing context
/// when a credential's status is [CredentialStatusType.revoked].
///
/// These reasons align with common practices in Public Key Infrastructure (PKI)
/// and Verifiable Credentials status management.
enum RevocationReason {
  /// The credential's key or associated information was compromised.
  compromised,

  /// The credential has been replaced by a newer version.
  superseded,

  /// The credential is no longer considered valid for reasons not covered by other codes
  /// (e.g., change in holder status, policy violation).
  noLongerValid,

  /// The issuer explicitly revoked the credential without specifying a standard reason.
  issuerRevoked,

  /// A reason other than the predefined ones.
  /// Check accompanying details if available.
  other
}

/// Represents the resolved or cached status information for a specific Verifiable Credential
/// within the application.
///
/// This model aggregates information obtained from checking a status mechanism
/// (like the W3C StatusList2021 specified in the credential's `credentialStatus` property).
/// It combines the result of checking the status list entry (identified by
/// [statusListUrl] and [statusListIndex]) with other relevant data like
/// expiration dates and check timestamps.
///
/// References:
/// - W3C VC Data Model v2 §4.10 Status: <https://www.w3.org/TR/vc-data-model-2.0/#status>
@freezed
class CredentialStatus with _$CredentialStatus {
  const factory CredentialStatus({
    /// The unique ID of the Verifiable Credential whose status this object represents.
    required String credentialId,

    /// The determined status of the credential after performing checks.
    /// See [CredentialStatusType].
    required CredentialStatusType status,

    /// The timestamp when the credential's status was last successfully checked
    /// against its designated status mechanism (e.g., by fetching the list at
    /// [statusListUrl] and checking the bit at [statusListIndex]).
    required DateTime lastChecked,

    /// If the status is [CredentialStatusType.revoked], the timestamp when the revocation
    /// was recorded or became effective (may be derived from the status list update time).
    DateTime? revokedAt,

    /// If the status is [CredentialStatusType.revoked], the reason for revocation.
    /// See [RevocationReason].
    RevocationReason? revocationReason,

    /// Optional additional human-readable details regarding the revocation.
    String? revocationDetails,

    /// The URL or DID identifying the Verifiable Credential containing the status list
    /// (e.g., a StatusList2021Credential or BitstringStatusListCredential).
    /// This is the source used to determine the status via the [statusListIndex].
    required String statusListUrl,

    /// The zero-based index within the referenced status list ([statusListUrl])
    /// that corresponds to this specific credential's status.
    required int statusListIndex,

    /// The expiration date defined within the Verifiable Credential itself, if present.
    DateTime? expiresAt,

    /// The timestamp indicating when the status of this credential should ideally be
    /// checked again. Useful for managing cache validity or scheduling polling.
    required DateTime nextCheck,
  }) = _CredentialStatus;

  /// Creates a [CredentialStatus] instance from a JSON map.
  factory CredentialStatus.fromJson(Map<String, dynamic> json) =>
      _$CredentialStatusFromJson(json);
}

/// Represents a processed or cached Status List, likely derived from a
/// Verifiable Credential like `StatusList2021Credential` or `BitstringStatusListCredential`.
///
/// This model holds the decoded status information (typically as a map of index-to-boolean
/// status, extracted from the `encodedList` property of the source credential)
/// for efficient status lookups within the application.
///
/// Example (Conceptual Source Credential - StatusList2021Credential):
/// ```json
/// {
///   "@context": ["https://www.w3.org/ns/credentials/v2", ...],
///   "id": "https://issuer.example/status/3", // Matches StatusList.id
///   "type": ["VerifiableCredential", "StatusList2021Credential"],
///   "issuer": "did:example:issuer1",
///   "validFrom": "2023-10-26T12:00:00Z",
///   "credentialSubject": {
///     "id": "https://issuer.example/status/3#list",
///     "type": "StatusList2021",
///     "encodedList": "H4sIAAAAAA..." // Compressed bitstring
///   },
///   "proof": { ... }
/// }
/// ```
@freezed
class StatusList with _$StatusList {
  const factory StatusList({
    /// The identifier (usually the URL or DID) of the source Status List Credential.
    /// This corresponds to the `statusListCredential` property in the VCs referencing this list.
    required String id,

    /// Timestamp indicating when this local, decoded representation of the list
    /// was last updated or fetched from the source credential at [id].
    required DateTime lastUpdated,

    /// The decoded status information derived from the `encodedList` of the source credential.
    /// Maps the status index (key) to its boolean status (value).
    /// The interpretation of `true`/`false` depends on the `statusPurpose`
    /// (e.g., for `revocation`, `true` often means revoked, `false` means not revoked).
    required Map<int, bool> statuses,

    /// The total number of status entries (bits) declared or inferred from the source list.
    /// Used for validation and ensuring indices are within bounds.
    required int size,

    /// Optional version identifier for the status list, if provided by the source credential.
    /// Useful for tracking updates to the list.
    String? version,
  }) = _StatusList;

  /// Creates a [StatusList] instance from a JSON map.
  factory StatusList.fromJson(Map<String, dynamic> json) =>
      _$StatusListFromJson(json);
}

/// Represents the outcome of performing a status check operation on a Verifiable Credential.
///
/// This provides a summary of the result, including the determined status,
/// timestamp, and any relevant details or errors encountered during the check.
@freezed
class StatusCheckResult with _$StatusCheckResult {
  const factory StatusCheckResult({
    /// The ID of the credential that was checked.
    required String credentialId,

    /// The status determined during the check. See [CredentialStatusType].
    required CredentialStatusType status,

    /// The timestamp when the check was performed.
    required DateTime checkedAt,

    /// Optional human-readable details about the verification process or the result
    /// (e.g., "Successfully verified against status list", "Expired", "Status list fetch failed").
    String? details,

    /// Optional error message if the status check failed.
    String? error,
  }) = _StatusCheckResult;

  /// Creates a [StatusCheckResult] instance from a JSON map.
  factory StatusCheckResult.fromJson(Map<String, dynamic> json) =>
      _$StatusCheckResultFromJson(json);
}
