import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revocation_status.freezed.dart';
part 'revocation_status.g.dart';

/// Represents the result of a revocation status check.
@freezed
class RevocationStatus with _$RevocationStatus {
  const factory RevocationStatus({
    /// Indicates whether the credential is confirmed revoked.
    required bool isRevoked,

    /// A message providing details about the status check outcome.
    required String message,

    /// Timestamp indicating when the status was last checked.
    required DateTime lastChecked,

    /// An optional error message if the status check failed.
    String? error,
  }) = _RevocationStatus;

  factory RevocationStatus.fromJson(Map<String, dynamic> json) =>
      _$RevocationStatusFromJson(json);
}
