import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.freezed.dart';
part 'credential.g.dart';

/// Représente une attestation vérifiable (Verifiable Credential)
@freezed
class Credential with _$Credential {
  const factory Credential({
    /// Identifiant unique de l'attestation
    required String id,

    /// Type d'attestation
    required CredentialType type,

    /// Nom de l'attestation
    required String name,

    /// Description de l'attestation
    String? description,

    /// Émetteur de l'attestation (autorité, institution, etc.)
    required String issuer,

    /// Identifiant de l'émetteur (DID)
    required String issuerId,

    /// Sujet de l'attestation (à qui elle appartient)
    required String subjectId,

    /// Date d'émission
    required DateTime issuedAt,

    /// Date d'expiration (si applicable)
    DateTime? expiresAt,

    /// Attributs vérifiables contenus dans l'attestation
    required Map<String, dynamic> claims,

    /// Schéma de l'attestation
    required String schemaId,

    /// Preuve cryptographique
    required CredentialProof proof,

    /// Statut de révocation
    required RevocationStatus revocationStatus,

    /// URL pour vérifier le statut de révocation
    String? revocationRegistryUrl,

    /// Statut de vérification
    @Default(VerificationStatus.unverified)
    VerificationStatus verificationStatus,

    /// Indique si des preuves à divulgation nulle de connaissance sont disponibles
    @Default(false) bool supportsZkp,

    /// Métadonnées supplémentaires
    Map<String, dynamic>? metadata,
  }) = _Credential;

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);
}

/// Preuve cryptographique de l'attestation
@freezed
class CredentialProof with _$CredentialProof {
  const factory CredentialProof({
    /// Type de preuve (par exemple, "Ed25519Signature2018")
    required String type,

    /// Date de création de la preuve
    required DateTime created,

    /// ID du vérificateur
    required String verificationMethod,

    /// But de la preuve (par exemple, "assertionMethod")
    required String proofPurpose,

    /// Valeur de la preuve
    required String proofValue,
  }) = _CredentialProof;

  factory CredentialProof.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofFromJson(json);
}

/// Types d'attestations pris en charge
enum CredentialType {
  /// Attestation d'identité
  identity,

  /// Diplôme ou certification
  diploma,

  /// Permis de conduire
  drivingLicense,

  /// Vérification d'âge
  ageVerification,

  /// Preuve d'adresse
  addressProof,

  /// Preuve d'emploi
  employmentProof,

  /// Carte de membre
  membershipCard,

  /// Assurance maladie
  healthInsurance,

  /// Autre type d'attestation
  other,
}

/// Statut de vérification
enum VerificationStatus {
  /// Non vérifié
  unverified,

  /// Vérifié avec succès
  verified,

  /// Vérification échouée
  invalid,

  /// Expiré
  expired,

  /// Révoqué
  revoked,
}

/// Statut de révocation
enum RevocationStatus {
  /// Non révoqué
  notRevoked,

  /// Révoqué
  revoked,

  /// Inconnu (impossible de vérifier)
  unknown,
}

/// Représente une présentation d'attestation
@freezed
class CredentialPresentation with _$CredentialPresentation {
  const factory CredentialPresentation({
    /// Identifiant unique de la présentation
    required String id,

    /// Type de présentation
    required String type,

    /// Attestations incluses
    required List<Credential> verifiableCredentials,

    /// Date de création
    required DateTime created,

    /// Attributs révélés (pour divulgation sélective)
    required Map<String, dynamic> revealedAttributes,

    /// Prédicats vérifiables (pour ZKP)
    List<CredentialPredicate>? predicates,

    /// Preuve cryptographique
    required CredentialProof proof,
  }) = _CredentialPresentation;

  factory CredentialPresentation.fromJson(Map<String, dynamic> json) =>
      _$CredentialPresentationFromJson(json);
}

/// Représente un prédicat pour une preuve à divulgation nulle de connaissance
@freezed
class CredentialPredicate with _$CredentialPredicate {
  const factory CredentialPredicate({
    /// Nom de l'attribut
    required String attributeName,

    /// Opérateur de comparaison
    required PredicateType predicateType,

    /// Valeur de comparaison
    required dynamic value,
  }) = _CredentialPredicate;

  factory CredentialPredicate.fromJson(Map<String, dynamic> json) =>
      _$CredentialPredicateFromJson(json);
}

/// Types de prédicat pour ZKP
enum PredicateType {
  /// Supérieur à
  greaterThan,

  /// Supérieur ou égal à
  greaterThanOrEqual,

  /// Inférieur à
  lessThan,

  /// Inférieur ou égal à
  lessThanOrEqual,

  /// Égal à
  equal,
}
