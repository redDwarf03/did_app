import 'package:did_app/domain/credential/credential_status.dart';

/// Résultat d'une opération de révocation
class RevocationResult {
  /// ID de l'attestation révoquée
  final String credentialId;

  /// Succès de l'opération
  final bool success;

  /// Message d'erreur éventuel
  final String? errorMessage;

  /// Détails sur la révocation
  final String? details;

  /// Date de la révocation
  final DateTime timestamp;

  const RevocationResult({
    required this.credentialId,
    required this.success,
    this.errorMessage,
    this.details,
    required this.timestamp,
  });
}

/// Interface pour le service de révocation des attestations
abstract class RevocationService {
  /// Révoque une attestation
  Future<RevocationResult> revokeCredential({
    required String credentialId,
    required RevocationReason reason,
    String? details,
  });

  /// Annule la révocation d'une attestation (si possible)
  Future<RevocationResult> unrevokeCredential({
    required String credentialId,
    String? details,
  });

  /// Vérifie si l'attestation est révoquée
  Future<bool> isRevoked(String credentialId);

  /// Obtient l'historique des révocations d'une attestation
  Future<List<RevocationHistoryEntry>> getRevocationHistory(
      String credentialId);

  /// Synchronise le statut de révocation avec le serveur
  Future<void> syncRevocationStatus(String credentialId);

  /// Synchronise tous les statuts de révocation
  Future<void> syncAllRevocationStatuses();
}

/// Entrée d'historique de révocation
class RevocationHistoryEntry {
  /// ID de l'attestation
  final String credentialId;

  /// Date de l'événement
  final DateTime timestamp;

  /// Action effectuée (révocation ou annulation)
  final RevocationAction action;

  /// Raison (pour une révocation)
  final RevocationReason? reason;

  /// Détails supplémentaires
  final String? details;

  /// Acteur ayant effectué l'action
  final String actor;

  const RevocationHistoryEntry({
    required this.credentialId,
    required this.timestamp,
    required this.action,
    this.reason,
    this.details,
    required this.actor,
  });
}

/// Action de révocation
enum RevocationAction {
  /// Révocation de l'attestation
  revoke,

  /// Annulation de la révocation
  unrevoke
}
