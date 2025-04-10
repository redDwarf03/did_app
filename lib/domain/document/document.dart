import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

/// Représente un document numérique dans le portefeuille d'identité
@freezed
class Document with _$Document {
  const factory Document({
    /// Identifiant unique du document
    required String id,

    /// Type du document (carte d'identité, passeport, diplôme, etc.)
    required DocumentType type,

    /// Titre du document
    required String title,

    /// Description du document
    String? description,

    /// Émetteur du document (autorité, institution, etc.)
    required String issuer,

    /// Date d'émission du document
    required DateTime issuedAt,

    /// Date d'expiration du document (si applicable)
    DateTime? expiresAt,

    /// Version actuelle du document
    required int version,

    /// Métadonnées du document (format JSON)
    Map<String, dynamic>? metadata,

    /// État de vérification du document
    required DocumentVerificationStatus verificationStatus,

    /// Chemin de stockage du document chiffré
    required String encryptedStoragePath,

    /// Hash du document pour vérification d'intégrité
    required String documentHash,

    /// Vecteur d'initialisation pour le déchiffrement
    required String encryptionIV,

    /// Signature numérique de l'émetteur
    String? issuerSignature,

    /// Adresse blockchain de l'émetteur (pour vérification)
    String? issuerAddress,

    /// Identifiant de transaction blockchain (pour preuve d'existence)
    String? blockchainTxId,

    /// Timestamp de la dernière mise à jour
    required DateTime updatedAt,

    /// Identifiant du propriétaire du document
    required String ownerIdentityId,

    /// Tags pour la recherche et le classement
    List<String>? tags,

    /// Indique si le document est partageable
    @Default(false) bool isShareable,

    /// Niveau eIDAS du document (pour conformité européenne)
    @Default(EidasLevel.low) EidasLevel eidasLevel,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}

/// Types de documents pris en charge
enum DocumentType {
  /// Carte nationale d'identité
  nationalId,

  /// Passeport
  passport,

  /// Permis de conduire
  drivingLicense,

  /// Diplôme universitaire
  diploma,

  /// Certificat professionnel
  certificate,

  /// Preuve d'adresse
  addressProof,

  /// Document bancaire
  bankDocument,

  /// Document médical
  medicalRecord,

  /// Document d'entreprise
  corporateDocument,

  /// Autre type de document
  other
}

/// État de vérification du document
enum DocumentVerificationStatus {
  /// Non vérifié
  unverified,

  /// En cours de vérification
  pending,

  /// Vérifié
  verified,

  /// Rejeté
  rejected,

  /// Expiré
  expired
}

/// Version du document stockée dans l'historique
@freezed
class DocumentVersion with _$DocumentVersion {
  const factory DocumentVersion({
    /// Identifiant de version
    required String id,

    /// Numéro de version
    required int versionNumber,

    /// Date de création de cette version
    required DateTime createdAt,

    /// Hash du document pour vérification d'intégrité
    required String documentHash,

    /// Chemin de stockage du document chiffré
    required String encryptedStoragePath,

    /// Vecteur d'initialisation pour le déchiffrement
    required String encryptionIV,

    /// Identifiant de transaction blockchain (pour preuve d'existence)
    String? blockchainTxId,

    /// Note sur la modification apportée
    String? changeNote,
  }) = _DocumentVersion;

  factory DocumentVersion.fromJson(Map<String, dynamic> json) =>
      _$DocumentVersionFromJson(json);
}

/// Représente le partage d'un document avec un tiers
@freezed
class DocumentShare with _$DocumentShare {
  const factory DocumentShare({
    /// Identifiant unique du partage
    required String id,

    /// Identifiant du document partagé
    required String documentId,

    /// Titre du document (pour affichage au destinataire)
    required String documentTitle,

    /// Identifiant du destinataire (si connu)
    String? recipientId,

    /// Description ou nom du destinataire
    required String recipientDescription,

    /// Date de création du partage
    required DateTime createdAt,

    /// Date d'expiration du partage
    required DateTime expiresAt,

    /// URL de partage (pour accès externe)
    required String shareUrl,

    /// Code d'accès ou PIN (optionnel, pour sécurité supplémentaire)
    String? accessCode,

    /// Indique si le partage est actif
    @Default(true) bool isActive,

    /// Nombre maximal d'accès autorisés
    int? maxAccessCount,

    /// Nombre d'accès effectués
    @Default(0) int accessCount,

    /// Type d'accès accordé
    required DocumentShareAccessType accessType,

    /// Dernier accès au document partagé
    DateTime? lastAccessedAt,
  }) = _DocumentShare;

  factory DocumentShare.fromJson(Map<String, dynamic> json) =>
      _$DocumentShareFromJson(json);
}

/// Types d'accès pour le partage de documents
enum DocumentShareAccessType {
  /// Lecture seule
  readOnly,

  /// Lecture et téléchargement
  download,

  /// Lecture et vérification (pour institutions)
  verify,

  /// Accès complet (incluant possibilité de copie)
  fullAccess
}

/// Niveaux de garantie eIDAS (correspondant à eIDAS 2.0)
enum EidasLevel {
  /// Niveau faible
  low,

  /// Niveau substantiel
  substantial,

  /// Niveau élevé
  high
}
