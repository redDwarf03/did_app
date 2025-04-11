import 'package:freezed_annotation/freezed_annotation.dart';
import 'credential.dart';

part 'qualified_credential.freezed.dart';
part 'qualified_credential.g.dart';

/// Niveau d'assurance pour les attestations qualifiées
enum AssuranceLevel {
  /// Niveau basique
  low,

  /// Niveau substantiel
  substantial,

  /// Niveau élevé
  high
}

/// Type de signature électronique qualifiée
enum QualifiedSignatureType {
  /// Signature électronique qualifiée
  qes,

  /// Sceau électronique qualifié
  qeseal,

  /// Certificat qualifié de site web
  qwac
}

/// Modèle représentant une attestation qualifiée selon eIDAS 2.0
@freezed
class QualifiedCredential with _$QualifiedCredential {
  const factory QualifiedCredential({
    /// Attestation de base
    required Credential credential,

    /// Niveau d'assurance
    required AssuranceLevel assuranceLevel,

    /// Type de signature qualifiée
    required QualifiedSignatureType signatureType,

    /// Identifiant de l'autorité de certification qualifiée
    required String qualifiedTrustServiceProviderId,

    /// Date de certification
    required DateTime certificationDate,

    /// Date d'expiration de la certification
    required DateTime certificationExpiryDate,

    /// Pays de l'autorité de certification
    required String certificationCountry,

    /// URL du registre de confiance qualifié
    required String qualifiedTrustRegistryUrl,

    /// Identifiant du certificat qualifié
    required String qualifiedCertificateId,

    /// Liste des attributs qualifiés
    required Map<String, dynamic> qualifiedAttributes,

    /// Preuve de certification qualifiée
    required String qualifiedProof,
  }) = _QualifiedCredential;

  factory QualifiedCredential.fromJson(Map<String, dynamic> json) =>
      _$QualifiedCredentialFromJson(json);
}

/// Service de confiance qualifié selon eIDAS
@freezed
class QualifiedTrustService with _$QualifiedTrustService {
  const factory QualifiedTrustService({
    /// Identifiant unique du service
    required String id,

    /// Nom du service
    required String name,

    /// Type de service
    required String type,

    /// Pays du service
    required String country,

    /// Statut du service
    required String status,

    /// Date de début de validité
    required DateTime startDate,

    /// Date de fin de validité
    required DateTime endDate,

    /// URL du service
    required String serviceUrl,

    /// Liste des certificats qualifiés
    required List<String> qualifiedCertificates,

    /// Niveau d'assurance
    required AssuranceLevel assuranceLevel,
  }) = _QualifiedTrustService;

  factory QualifiedTrustService.fromJson(Map<String, dynamic> json) =>
      _$QualifiedTrustServiceFromJson(json);
}
