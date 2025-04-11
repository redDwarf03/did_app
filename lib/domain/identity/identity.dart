/// Représente une identité numérique sur la blockchain
class DigitalIdentity {
  DigitalIdentity({
    required this.address,
    required this.name,
    required this.createdAt,
    this.publicName,
    this.profileImage,
    this.services = const [],
  });

  /// Adresse de l'identité sur la blockchain
  final String address;

  /// Nom de l'identité (usage privé)
  final String name;

  /// Nom public de l'identité (facultatif)
  final String? publicName;

  /// URL de l'image de profil (facultatif)
  final String? profileImage;

  /// Date de création de l'identité
  final DateTime createdAt;

  /// Services associés à l'identité (authentification, messagerie, etc.)
  final List<IdentityService> services;

  /// Retourne le nom à afficher (public ou privé)
  String get displayName => publicName ?? name;

  /// Crée une copie de l'identité avec des valeurs modifiées
  DigitalIdentity copyWith({
    String? address,
    String? name,
    String? publicName,
    String? profileImage,
    DateTime? createdAt,
    List<IdentityService>? services,
  }) {
    return DigitalIdentity(
      address: address ?? this.address,
      name: name ?? this.name,
      publicName: publicName ?? this.publicName,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      services: services ?? this.services,
    );
  }
}

/// Représente un service associé à une identité numérique
class IdentityService {
  IdentityService({
    required this.id,
    required this.type,
    required this.endpoint,
  });

  /// Identifiant unique du service
  final String id;

  /// Type de service (auth, messaging, etc.)
  final String type;

  /// Endpoint du service
  final String endpoint;
}
