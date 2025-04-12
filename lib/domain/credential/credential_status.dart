import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart'; // Import needed for @JsonValue

part 'credential_status.freezed.dart';
part 'credential_status.g.dart';

/// Defines the possible high-level statuses of a Verifiable Credential.
enum CredentialStatusType {
  /// The credential is currently considered valid (not revoked or expired).
  valid,

  /// The credential has been revoked by the issuer.
  revoked,

  /// The credential has passed its expiration date.
  expired,

  /// The status of the credential could not be determined or is unknown.
  unknown
}

/// Enumerates common reasons for credential revocation.
///
/// These reasons provide context when a credential's status is [CredentialStatusType.revoked].
enum RevocationReason {
  /// The credential's key or associated information was compromised.
  compromised,

  /// The credential has been replaced by a newer version.
  superseded,

  /// The credential is no longer considered valid for reasons not covered by other codes.
  noLongerValid,

  /// The issuer explicitly revoked the credential.
  issuerRevoked,

  /// A reason other than the predefined ones.
  other
}

/// Represents the resolved or cached status information for a specific Verifiable Credential
/// within the application.
///
/// This model aggregates information obtained from checking a status mechanism (like StatusList2021,
/// indicated by [statusListUrl] and [statusListIndex]) and combines it with other relevant data
/// like expiration dates and check timestamps.
/// W3C VC Data Model v2 §4.10 Status.
@freezed
class CredentialStatus with _$CredentialStatus {
  const factory CredentialStatus({
    /// The unique ID of the credential whose status this object represents.
    required String credentialId,

    /// The determined status of the credential. See [CredentialStatusType].
    required CredentialStatusType status,

    /// The timestamp when the credential's status was last successfully checked
    /// against its status mechanism (e.g., StatusList2021).
    required DateTime lastChecked,

    /// If the status is [CredentialStatusType.revoked], the timestamp when the revocation occurred.
    DateTime? revokedAt,

    /// If the status is [CredentialStatusType.revoked], the reason for revocation.
    /// See [RevocationReason].
    RevocationReason? revocationReason,

    /// Optional additional details regarding the revocation.
    String? revocationDetails,

    /// The URL of the status list credential (e.g., a StatusList2021Credential)
    /// used to determine the status.
    required String statusListUrl,

    /// The index within the referenced status list that corresponds to this credential.
    required int statusListIndex,

    /// The expiration date of the credential itself, if applicable.
    DateTime? expiresAt,

    /// The timestamp when the status of this credential should be checked again.
    /// Useful for managing cache validity or polling frequency.
    required DateTime nextCheck,
  }) = _CredentialStatus;

  /// Creates a [CredentialStatus] instance from a JSON map.
  factory CredentialStatus.fromJson(Map<String, dynamic> json) =>
      _$CredentialStatusFromJson(json);
}

/// Represents a processed or cached Status List, likely corresponding to a
/// StatusList2021Credential's `encodedList`.
///
/// This model holds the decoded status information (typically a map of index to boolean status)
/// for efficient lookup.
@freezed
class StatusList with _$StatusList {
  const factory StatusList({
    /// The identifier (usually the URL) of the source StatusList2021Credential.
    required String id, // Corresponds to statusListUrl in CredentialStatus

    // /// The URL of the status list (potentially redundant with id).
    // required String url,

    /// Timestamp indicating when this local representation of the list was last updated
    /// from the source.
    required DateTime lastUpdated,

    /// The decoded status information, mapping the status index to its boolean status
    /// (e.g., true might mean revoked/suspended, false means active).
    required Map<int, bool> statuses,

    /// The total number of status entries (bits) in the list.
    required int size,

    /// Optional version identifier for the status list, if provided by the source.
    String? version,
  }) = _StatusList;

  /// Creates a [StatusList] instance from a JSON map.
  factory StatusList.fromJson(Map<String, dynamic> json) =>
      _$StatusListFromJson(json);
}

/// Represents the result of performing a status check operation on a credential.
@freezed
class StatusCheckResult with _$StatusCheckResult {
  const factory StatusCheckResult({
    /// The ID of the credential that was checked.
    required String credentialId,

    /// The status determined during the check. See [CredentialStatusType].
    required CredentialStatusType status,

    /// The timestamp when the check was performed.
    required DateTime checkedAt,

    /// Optional details about the verification process or the result.
    String? details,

    /// Optional error message if the status check failed.
    String? error,
  }) = _StatusCheckResult;

  /// Creates a [StatusCheckResult] instance from a JSON map.
  factory StatusCheckResult.fromJson(Map<String, dynamic> json) =>
      _$StatusCheckResultFromJson(json);
}
