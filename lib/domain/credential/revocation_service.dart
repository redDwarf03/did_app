import 'package:did_app/domain/credential/credential_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revocation_service.freezed.dart';
part 'revocation_service.g.dart';

/// Holds the outcome of a credential revocation or un-revocation operation.
@freezed
class RevocationResult with _$RevocationResult {
  const factory RevocationResult({
    /// The unique identifier of the credential that was targeted by the operation.
    required String credentialId,

    /// Indicates whether the revocation or un-revocation operation was successful.
    required bool success,

    /// An optional message providing details in case of failure (`success` is false).
    String? errorMessage,

    /// Optional additional details about the result of the operation.
    String? details,

    /// The timestamp when the revocation or un-revocation operation was processed.
    required DateTime timestamp,
  }) = _RevocationResult;

  /// Creates a [RevocationResult] instance from a JSON map.
  factory RevocationResult.fromJson(Map<String, dynamic> json) =>
      _$RevocationResultFromJson(json);
}

/// Abstract interface defining the contract for a service that manages credential revocation.
///
/// This service provides functionalities to revoke credentials, undo revocations (if supported),
/// check the current status, and retrieve revocation history. This represents an active
/// management approach, distinct from passive status checking mechanisms like StatusList2021.
/// Implementations might interact with a dedicated revocation registry, a ledger,
/// or another backend system.
/// See also: W3C VC Data Model v2 §4.10 Status
abstract class RevocationService {
  /// Attempts to revoke a specific credential.
  ///
  /// - [credentialId]: The ID of the credential to revoke.
  /// - [reason]: The reason for revocation. See [RevocationReason].
  /// - [details]: Optional additional details about the revocation.
  ///
  /// Returns a [RevocationResult] indicating the outcome of the operation.
  Future<RevocationResult> revokeCredential({
    required String credentialId,
    required RevocationReason reason,
    String? details,
  });

  /// Attempts to undo the revocation of a specific credential.
  ///
  /// Note: This functionality might not be supported by all revocation systems.
  ///
  /// - [credentialId]: The ID of the credential to un-revoke.
  /// - [details]: Optional additional details about the operation.
  ///
  /// Returns a [RevocationResult] indicating the outcome.
  Future<RevocationResult> unrevokeCredential({
    required String credentialId,
    String? details,
  });

  /// Checks if a specific credential is currently considered revoked.
  ///
  /// - [credentialId]: The ID of the credential to check.
  ///
  /// Returns `true` if the credential is currently revoked, `false` otherwise.
  Future<bool> isRevoked(String credentialId);

  /// Retrieves the historical log of revocation-related events for a specific credential.
  ///
  /// - [credentialId]: The ID of the credential whose history is requested.
  ///
  /// Returns a list of [RevocationHistoryEntry] objects, typically ordered by timestamp.
  Future<List<RevocationHistoryEntry>> getRevocationHistory(
    String credentialId,
  );

  /// Synchronizes the local or cached revocation status for a specific credential
  /// with the authoritative revocation source (e.g., backend service, ledger).
  ///
  /// Implementations might use this for proactive updates or cache refreshes.
  Future<void> syncRevocationStatus(String credentialId);

  /// Synchronizes the revocation status for all relevant credentials managed locally.
  ///
  /// This is likely a more resource-intensive operation than syncing a single credential.
  Future<void> syncAllRevocationStatuses();
}

/// Represents a single entry in the revocation history log for a credential.
@freezed
class RevocationHistoryEntry with _$RevocationHistoryEntry {
  const factory RevocationHistoryEntry({
    /// The ID of the credential this history entry pertains to.
    required String credentialId,

    /// The timestamp when the revocation action occurred.
    required DateTime timestamp,

    /// The specific action performed (revoke or un-revoke). See [RevocationAction].
    required RevocationAction action,

    /// The reason provided if the action was a revocation. See [RevocationReason].
    RevocationReason? reason,

    /// Optional additional details about this specific history event.
    String? details,

    /// An identifier for the entity (e.g., issuer DID, administrator ID) that performed the action.
    required String actor,
  }) = _RevocationHistoryEntry;

  /// Creates a [RevocationHistoryEntry] instance from a JSON map.
  factory RevocationHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$RevocationHistoryEntryFromJson(json);
}

/// Enumerates the possible actions recorded in the revocation history.
enum RevocationAction {
  /// The credential was revoked.
  revoke,

  /// A previous revocation was undone.
  unrevoke
}
