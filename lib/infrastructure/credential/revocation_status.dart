import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

/// Represents the result of a revocation status check.
@immutable // Good practice for model classes
class RevocationStatus {
  const RevocationStatus({
    required this.isRevoked,
    required this.message,
    required this.lastChecked,
    this.error,
  });

  /// Indicates whether the credential is confirmed revoked.
  final bool isRevoked;

  /// A message providing details about the status check outcome.
  final String message;

  /// Timestamp indicating when the status was last checked.
  final DateTime lastChecked;

  /// An optional error message if the status check failed.
  final String? error;

  // Optional: Add equality and hashCode for easier testing/comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevocationStatus &&
          runtimeType == other.runtimeType &&
          isRevoked == other.isRevoked &&
          message == other.message &&
          lastChecked == other.lastChecked &&
          error == other.error;

  @override
  int get hashCode =>
      isRevoked.hashCode ^
      message.hashCode ^
      lastChecked.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'RevocationStatus(isRevoked: $isRevoked, message: $message, lastChecked: $lastChecked, error: $error)';
  }
}
