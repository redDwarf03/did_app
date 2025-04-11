import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_status.freezed.dart';
part 'credential_status.g.dart';

/// Type de statut d'une attestation
enum CredentialStatusType {
  /// L'attestation est valide
  valid,

  /// L'attestation a été révoquée
  revoked,

  /// L'attestation a expiré
  expired,

  /// Le statut est inconnu
  unknown
}

/// Raison de la révocation d'une attestation
enum RevocationReason {
  /// L'attestation a été compromise
  compromised,

  /// L'attestation a été remplacée
  superseded,

  /// L'attestation n'est plus valide
  noLongerValid,

  /// L'attestation a été révoquée par l'émetteur
  issuerRevoked,

  /// Autre raison
  other
}

/// Statut d'une attestation selon Status List 2021
@freezed
class CredentialStatus with _$CredentialStatus {
  const factory CredentialStatus({
    /// ID unique de l'attestation
    required String credentialId,

    /// Type de statut
    required CredentialStatusType status,

    /// Date de la dernière vérification
    required DateTime lastChecked,

    /// Date de révocation (si applicable)
    DateTime? revokedAt,

    /// Raison de la révocation (si applicable)
    RevocationReason? revocationReason,

    /// Détails supplémentaires sur la révocation
    String? revocationDetails,

    /// URL de la liste de statut
    required String statusListUrl,

    /// Index dans la liste de statut
    required int statusListIndex,

    /// Date d'expiration de l'attestation
    DateTime? expiresAt,

    /// Date de la prochaine vérification
    required DateTime nextCheck,
  }) = _CredentialStatus;

  factory CredentialStatus.fromJson(Map<String, dynamic> json) =>
      _$CredentialStatusFromJson(json);
}

/// Liste de statuts pour la vérification en masse
@freezed
class StatusList with _$StatusList {
  const factory StatusList({
    /// ID de la liste de statut
    required String id,

    /// URL de la liste de statut
    required String url,

    /// Date de la dernière mise à jour
    required DateTime lastUpdated,

    /// Liste des statuts indexés
    required Map<int, bool> statuses,

    /// Taille de la liste
    required int size,

    /// Version de la liste
    required String version,
  }) = _StatusList;

  factory StatusList.fromJson(Map<String, dynamic> json) =>
      _$StatusListFromJson(json);
}

/// Résultat de la vérification d'un statut
@freezed
class StatusCheckResult with _$StatusCheckResult {
  const factory StatusCheckResult({
    /// ID de l'attestation vérifiée
    required String credentialId,

    /// Statut de l'attestation
    required CredentialStatusType status,

    /// Date de la vérification
    required DateTime checkedAt,

    /// Détails de la vérification
    String? details,

    /// Erreur éventuelle
    String? error,
  }) = _StatusCheckResult;

  factory StatusCheckResult.fromJson(Map<String, dynamic> json) =>
      _$StatusCheckResultFromJson(json);
}
