import 'package:flutter/foundation.dart';

/// Représente une attestation vérifiable (Verifiable Credential)
class Credential {
  Credential({
    required this.id,
    required this.context,
    required this.type,
    required this.issuanceDate,
    required this.issuer,
    required this.subject,
    required this.credentialSubject,
    this.expirationDate,
    this.proof,
    this.status,
    this.credentialSchema,
    this.name,
    this.description,
    this.claims,
    this.verificationStatus = VerificationStatus.unverified,
    this.supportsZkp = false,
  });

  /// Identifiant unique de l'attestation
  final String id;

  /// Contexte de l'attestation (URI définissant les termes)
  final List<String> context;

  /// Type de l'attestation
  final List<String> type;

  /// Date d'émission de l'attestation
  final DateTime issuanceDate;

  /// Date d'expiration de l'attestation (facultatif)
  final DateTime? expirationDate;

  /// Identifiant de l'émetteur de l'attestation
  final String issuer;

  /// Identifiant du sujet de l'attestation
  final String subject;

  /// Contenu de l'attestation
  final Map<String, dynamic> credentialSubject;

  /// Preuve cryptographique de l'attestation (facultatif)
  final CredentialProof? proof;

  /// État de l'attestation (facultatif)
  final CredentialStatus? status;

  /// Schéma de l'attestation (facultatif)
  final CredentialSchema? credentialSchema;

  /// Nom de l'attestation (lisible par l'utilisateur)
  final String? name;

  /// Description de l'attestation
  final String? description;

  /// Attributs de l'attestation (forme simplifiée du credentialSubject)
  final Map<String, dynamic>? claims;

  /// Statut de vérification de l'attestation
  final VerificationStatus verificationStatus;

  /// Indique si l'attestation supporte les preuves à divulgation nulle (ZKP)
  final bool supportsZkp;

  /// Alias pour issuanceDate
  DateTime get issuedAt => issuanceDate;

  /// Alias pour expirationDate
  DateTime? get expiresAt => expirationDate;

  /// Retourne une nouvelle instance avec les valeurs modifiées
  Credential copyWith({
    String? id,
    List<String>? context,
    List<String>? type,
    DateTime? issuanceDate,
    DateTime? expirationDate,
    ValueGetter<DateTime?>? clearExpirationDate,
    String? issuer,
    String? subject,
    Map<String, dynamic>? credentialSubject,
    CredentialProof? proof,
    ValueGetter<CredentialProof?>? clearProof,
    CredentialStatus? status,
    ValueGetter<CredentialStatus?>? clearStatus,
    CredentialSchema? credentialSchema,
    ValueGetter<CredentialSchema?>? clearCredentialSchema,
    String? name,
    String? description,
    Map<String, dynamic>? claims,
    VerificationStatus? verificationStatus,
    bool? supportsZkp,
  }) {
    return Credential(
      id: id ?? this.id,
      context: context ?? this.context,
      type: type ?? this.type,
      issuanceDate: issuanceDate ?? this.issuanceDate,
      expirationDate: clearExpirationDate != null
          ? clearExpirationDate()
          : expirationDate ?? this.expirationDate,
      issuer: issuer ?? this.issuer,
      subject: subject ?? this.subject,
      credentialSubject: credentialSubject ?? this.credentialSubject,
      proof: clearProof != null ? clearProof() : proof ?? this.proof,
      status: clearStatus != null ? clearStatus() : status ?? this.status,
      credentialSchema: clearCredentialSchema != null
          ? clearCredentialSchema()
          : credentialSchema ?? this.credentialSchema,
      name: name ?? this.name,
      description: description ?? this.description,
      claims: claims ?? this.claims,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      supportsZkp: supportsZkp ?? this.supportsZkp,
    );
  }

  /// Vérifie si l'attestation est valide (non expirée)
  bool get isValid {
    if (expirationDate == null) {
      return true;
    }
    return DateTime.now().isBefore(expirationDate!);
  }

  /// Vérifie si l'attestation est vérifiée (a une preuve)
  bool get isVerified => proof != null;

  /// Vérifie si l'attestation est révoquée
  bool get isRevoked => status?.revoked ?? false;
}

/// Représente une preuve cryptographique pour une attestation
class CredentialProof {
  CredentialProof({
    required this.type,
    required this.created,
    required this.proofPurpose,
    required this.verificationMethod,
    required this.proofValue,
    this.challenge,
    this.domain,
  });

  /// Type de preuve
  final String type;

  /// Date de création de la preuve
  final DateTime created;

  /// Objectif de la preuve
  final String proofPurpose;

  /// Méthode de vérification (clé publique)
  final String verificationMethod;

  /// Signature cryptographique
  final String proofValue;

  /// Challenge utilisé pour la preuve (facultatif, pour les présentations)
  final String? challenge;

  /// Domaine pour lequel la preuve est créée (facultatif, pour les présentations)
  final String? domain;
}

/// Représente l'état d'une attestation (ex: révocation)
class CredentialStatus {
  CredentialStatus({
    required this.id,
    required this.type,
    this.revoked = false,
  });

  /// Identifiant de l'état
  final String id;

  /// Type d'état
  final String type;

  /// Indique si l'attestation est révoquée
  final bool revoked;
}

/// Représente le schéma d'une attestation
class CredentialSchema {
  CredentialSchema({
    required this.id,
    required this.type,
  });

  /// Identifiant du schéma
  final String id;

  /// Type de schéma
  final String type;
}

/// Représente une présentation d'attestation (Verifiable Presentation)
class CredentialPresentation {
  CredentialPresentation({
    required this.id,
    required this.context,
    required this.type,
    required this.verifiableCredentials,
    this.proof,
    this.holder,
    this.revealedAttributes,
    this.predicates,
    this.created,
  });

  /// Identifiant unique de la présentation
  final String id;

  /// Contexte de la présentation
  final List<String> context;

  /// Type de la présentation
  final List<String> type;

  /// Adresse du détenteur de la présentation
  final String? holder;

  /// Attestations incluses dans la présentation
  final List<Credential> verifiableCredentials;

  /// Preuve cryptographique de la présentation
  final CredentialProof? proof;

  /// Attributs révélés par attestation
  final Map<String, List<String>>? revealedAttributes;

  /// Prédicats pour les preuves à divulgation nulle
  final List<CredentialPredicate>? predicates;

  /// Date de création de la présentation
  final DateTime? created;

  /// Vérifie si la présentation est vérifiée (a une preuve)
  bool get isVerified => proof != null;
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

/// Type de prédicat pour les preuves à divulgation nulle
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

/// Prédicat pour une preuve à divulgation nulle
class CredentialPredicate {
  CredentialPredicate({
    required this.attributeName,
    required this.predicateType,
    required this.value,
  });

  /// Nom de l'attribut concerné par le prédicat
  final String attributeName;

  /// Type de prédicat (>, >=, <, <=, =)
  final PredicateType predicateType;

  /// Valeur du prédicat
  final dynamic value;
}
