import 'package:freezed_annotation/freezed_annotation.dart';

part 'simplified_credential.freezed.dart';
part 'simplified_credential.g.dart';

/// Enum representing simplified, application-specific types of credentials.
/// Note: This is distinct from the more detailed `CredentialType` in `lib/domain/credential/credential.dart`.
enum SimplifiedCredentialType {
  /// Represents proof of identity.
  identity,

  /// Represents a diploma or educational achievement.
  diploma,

  /// Represents a general certificate.
  certificate,

  /// Represents a membership.
  membership,

  /// Represents a license (e.g., professional license).
  license,

  /// Represents a health card.
  healthCard,

  /// Represents any other custom or application-specific credential type.
  custom,
}

/// Simplified model class for representing basic credential information within the application.
///
/// This model provides a lightweight structure, distinct from the comprehensive
/// W3C-compliant `Credential` model defined in `lib/domain/credential/credential.dart`.
/// It might be used for UI display, internal storage representations, or simpler use cases
/// where full W3C compliance is not immediately needed.
@freezed
class SimplifiedCredential with _$SimplifiedCredential {
  /// Creates a simplified Credential instance.
  const factory SimplifiedCredential({
    /// A unique identifier for this credential instance (e.g., a UUID or database ID).
    required String id,

    /// The application-specific type of the credential. See [SimplifiedCredentialType].
    required SimplifiedCredentialType type,

    /// An identifier (e.g., name, URI, or DID) of the entity that issued the credential.
    required String issuer,

    /// The date and time when the credential was issued.
    required DateTime issuanceDate,

    /// The date and time when the credential expires.
    required DateTime expirationDate,

    /// A map containing the core claims or attributes of the credential.
    /// The structure depends on the credential `type`.
    required Map<String, dynamic> attributes,

    /// A simple flag indicating if this credential representation has been locally verified.
    /// This does not necessarily imply full cryptographic verification according to W3C standards.
    @Default(false) bool isVerified,
  }) = _SimplifiedCredential;

  /// Private constructor for implementing custom getters or methods (if needed).
  const SimplifiedCredential._();

  /// Factory constructor to create a [SimplifiedCredential] instance from a JSON map.
  factory SimplifiedCredential.fromJson(Map<String, dynamic> json) =>
      _$SimplifiedCredentialFromJson(json);

  /// Checks if the credential has expired based on the current time and `expirationDate`.
  /// Returns `true` if the current time is after the `expirationDate`.
  bool get isExpired => DateTime.now().isAfter(expirationDate);

  /// Checks if the credential is about to expire soon (within the next 30 days).
  /// Returns `true` if the credential is not already expired and the expiration date
  /// is within 30 days from now.
  bool get isExpiringSoon {
    final daysUntilExpiration =
        expirationDate.difference(DateTime.now()).inDays;
    return !isExpired && daysUntilExpiration <= 30;
  }
}
