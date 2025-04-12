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
class SimplifiedCredential {
  /// Creates a simplified Credential instance.
  SimplifiedCredential({
    /// A unique identifier for this credential instance (e.g., a UUID or database ID).
    required this.id,

    /// The application-specific type of the credential. See [SimplifiedCredentialType].
    required this.type,

    /// An identifier (e.g., name, URI, or DID) of the entity that issued the credential.
    required this.issuer,

    /// The date and time when the credential was issued.
    required this.issuanceDate,

    /// The date and time when the credential expires.
    required this.expirationDate,

    /// A map containing the core claims or attributes of the credential.
    /// The structure depends on the credential `type`.
    required this.attributes,

    /// A simple flag indicating if this credential representation has been locally verified.
    /// This does not necessarily imply full cryptographic verification according to W3C standards.
    this.isVerified = false,
  });

  /// The unique identifier for this credential.
  final String id;

  /// The application-specific type of the credential.
  final SimplifiedCredentialType type;

  /// The identifier of the issuer.
  final String issuer;

  /// The date and time of issuance.
  final DateTime issuanceDate;

  /// The date and time of expiration.
  final DateTime expirationDate;

  /// The core attributes or claims of the credential.
  final Map<String, dynamic> attributes;

  /// Local verification status flag.
  final bool isVerified;

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

  /// Creates a copy of this SimplifiedCredential instance with potentially modified fields.
  ///
  /// Useful for updating immutable SimplifiedCredential objects.
  SimplifiedCredential copyWith({
    String? id,
    SimplifiedCredentialType? type,
    String? issuer,
    DateTime? issuanceDate,
    DateTime? expirationDate,
    Map<String, dynamic>? attributes,
    bool? isVerified,
  }) {
    return SimplifiedCredential(
      id: id ?? this.id,
      type: type ?? this.type,
      issuer: issuer ?? this.issuer,
      issuanceDate: issuanceDate ?? this.issuanceDate,
      expirationDate: expirationDate ?? this.expirationDate,
      attributes: attributes ?? this.attributes,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
