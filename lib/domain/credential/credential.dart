import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:did_app/domain/credential/status_list_2021.dart';

part 'credential.freezed.dart';
part 'credential.g.dart';

/// Statut de vérification d'une attestation
enum VerificationStatus {
  /// Statut de vérification non déterminé
  unverified,

  /// Attestation vérifiée avec succès
  verified,

  /// Échec de la vérification
  invalid,

  /// Attestation expirée
  expired,

  /// Attestation révoquée
  revoked,
}

/// Types d'attestations pris en charge
enum CredentialType {
  /// Diplôme
  diploma,

  /// Identité
  identity,

  /// Permis de conduire
  drivingLicense,

  /// Attestation médicale
  medicalCertificate,

  /// Badge professionnel
  professionalBadge,

  /// Attestation de santé
  healthInsurance,

  /// Preuve d'emploi
  employmentProof,

  /// Vérification d'âge
  ageVerification,

  /// Preuve d'adresse
  addressProof,

  /// Carte de membre
  membershipCard,

  /// Autre
  other,
}

/// Modèle représentant une attestation
@freezed
class Credential with _$Credential {
  const Credential._(); // Ajout d'un constructeur privé pour les getters

  const factory Credential({
    /// Identifiant unique de l'attestation
    required String id,

    /// Type de l'attestation
    required List<String> type,

    /// Émetteur de l'attestation
    required String issuer,

    /// Nom de l'attestation
    String? name,

    /// Description de l'attestation
    String? description,

    /// Sujet de l'attestation (pour la comptabilité avec les URIs DID)
    String? subject,

    /// Date d'émission
    required DateTime issuanceDate,

    /// Date d'expiration
    DateTime? expirationDate,

    /// URL de la liste de statut
    String? statusListUrl,

    /// Index dans la liste de statut
    int? statusListIndex,

    /// Statut de l'attestation
    @Default(VerificationStatus.unverified)
    VerificationStatus verificationStatus,

    /// Schéma de l'attestation
    Map<String, dynamic>? credentialSchema,

    /// Statut de l'attestation
    Map<String, dynamic>? status,

    /// Indique si l'attestation supporte les preuves à divulgation nulle
    @Default(false) bool supportsZkp,

    /// Sujet de l'attestation (claims)
    required Map<String, dynamic> credentialSubject,

    /// Contexte JSON-LD
    @Default([]) @JsonKey(name: '@context') List<String> context,

    /// Preuve cryptographique
    required Map<String, dynamic> proof,
  }) = _Credential;

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  /// Alias pour issuanceDate
  DateTime? get issuedAt => issuanceDate;

  /// Alias pour expirationDate
  DateTime? get expiresAt => expirationDate;

  /// Alias pour credentialSubject
  Map<String, dynamic>? get claims => credentialSubject;

  /// Vérifie si l'attestation est valide (non expirée)
  bool get isValid =>
      expirationDate == null || expirationDate!.isAfter(DateTime.now());

  /// Vérifie si l'attestation est révoquée
  bool get isRevoked => false; // À implémenter avec les données de révocation

  /// Extrait les informations de statut Status List 2021 de l'attestation
  StatusList2021Entry? getStatusList2021Entry() {
    if (status == null ||
        !status!.containsKey('type') ||
        status!['type'] != 'StatusList2021Entry') {
      return null;
    }

    try {
      return StatusList2021Entry(
        id: status!['id'] as String? ?? '$id#status',
        statusListCredential: status!['statusListCredential'] as String,
        statusPurpose: StatusPurpose.values.firstWhere(
          (p) => p.toString().split('.').last == status!['statusPurpose'],
          orElse: () => StatusPurpose.revocation,
        ),
        statusListIndex: status!['statusListIndex'] as int,
      );
    } catch (e) {
      return null;
    }
  }
}

/// Modèle représentant une présentation d'attestation
@freezed
class CredentialPresentation with _$CredentialPresentation {
  const factory CredentialPresentation({
    /// Identifiant unique de la présentation
    required String id,

    /// Type de la présentation
    required List<String> type,

    /// Liste des attestations incluses
    required List<Credential> verifiableCredentials,

    /// Challenge utilisé pour la vérification
    String? challenge,

    /// Domaine pour lequel la présentation est générée
    String? domain,

    /// Attributs révélés par attestation
    required Map<String, List<String>> revealedAttributes,

    /// Preuve de la présentation
    required Map<String, dynamic> proof,

    /// Date de création
    required DateTime created,
  }) = _CredentialPresentation;

  factory CredentialPresentation.fromJson(Map<String, dynamic> json) =>
      _$CredentialPresentationFromJson(json);
}

/// Modèle représentant un prédicat pour les preuves à divulgation nulle
@freezed
class CredentialPredicate with _$CredentialPredicate {
  const factory CredentialPredicate({
    /// Identifiant de l'attestation
    required String credentialId,

    /// Attribut sur lequel appliquer le prédicat
    required String attribute,

    /// Nom de l'attribut (pour l'affichage)
    required String attributeName,

    /// Prédicat (>=, <=, ==, etc.)
    required String predicate,

    /// Type de prédicat
    required PredicateType predicateType,

    /// Valeur à comparer
    required dynamic value,
  }) = _CredentialPredicate;

  factory CredentialPredicate.fromJson(Map<String, dynamic> json) =>
      _$CredentialPredicateFromJson(json);
}

/// Modèle représentant une preuve d'attestation
@freezed
class Proof with _$Proof {
  const factory Proof({
    /// Type de preuve
    required String type,

    /// Date de création
    required DateTime created,

    /// Méthode de vérification
    required String verificationMethod,

    /// Signature de la preuve
    required String proofValue,
  }) = _Proof;

  factory Proof.fromJson(Map<String, dynamic> json) => _$ProofFromJson(json);
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
  equal;

  /// Retourne une représentation du prédicat lisible par un humain
  String get humanReadable {
    switch (this) {
      case PredicateType.greaterThan:
        return '>';
      case PredicateType.greaterThanOrEqual:
        return '≥';
      case PredicateType.lessThan:
        return '<';
      case PredicateType.lessThanOrEqual:
        return '≤';
      case PredicateType.equal:
        return '=';
    }
  }
}

/// Prédicat pour une preuve à divulgation nulle
class CredentialPredicateValue {
  CredentialPredicateValue({
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
