/// Enum representing different types of credentials
enum CredentialType {
  identity,
  diploma,
  certificate,
  membership,
  license,
  healthCard,
  custom,
}

/// Model class for a verifiable credential
class Credential {

  Credential({
    required this.id,
    required this.type,
    required this.issuer,
    required this.issuanceDate,
    required this.expirationDate,
    required this.attributes,
    this.isVerified = false,
  });
  final String id;
  final CredentialType type;
  final String issuer;
  final DateTime issuanceDate;
  final DateTime expirationDate;
  final Map<String, dynamic> attributes;
  final bool isVerified;

  /// Check if the credential is expired
  bool get isExpired => DateTime.now().isAfter(expirationDate);

  /// Check if the credential is about to expire (within 30 days)
  bool get isExpiringSoon {
    final daysUntilExpiration =
        expirationDate.difference(DateTime.now()).inDays;
    return !isExpired && daysUntilExpiration <= 30;
  }

  /// Create a copy of this credential with some changes
  Credential copyWith({
    String? id,
    CredentialType? type,
    String? issuer,
    DateTime? issuanceDate,
    DateTime? expirationDate,
    Map<String, dynamic>? attributes,
    bool? isVerified,
  }) {
    return Credential(
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
