import 'dart:convert';

import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/domain/credential/revocation_service.dart';
import 'package:did_app/infrastructure/credential/credential_status_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

/// Service d'implémentation de la révocation des attestations
/// utilisant le standard Status List 2021
class StatusList2021RevocationService implements RevocationService {

  StatusList2021RevocationService({
    required http.Client httpClient,
    required CredentialStatusService statusService,
    required Box<Map<dynamic, dynamic>> historyBox,
    required String apiEndpoint,
    required String apiKey,
  })  : _httpClient = httpClient,
        _statusService = statusService,
        _historyBox = historyBox,
        _apiEndpoint = apiEndpoint,
        _apiKey = apiKey;
  final http.Client _httpClient;
  final CredentialStatusService _statusService;
  final Box<Map<dynamic, dynamic>> _historyBox;
  final String _apiEndpoint;
  final String _apiKey;

  @override
  Future<RevocationResult> revokeCredential({
    required String credentialId,
    required RevocationReason reason,
    String? details,
  }) async {
    try {
      // Vérifier si l'attestation est déjà révoquée
      if (await isRevoked(credentialId)) {
        return RevocationResult(
          credentialId: credentialId,
          success: false,
          errorMessage: "L'attestation est déjà révoquée",
          timestamp: DateTime.now(),
        );
      }

      // Appeler l'API pour révoquer l'attestation
      final response = await _httpClient.post(
        Uri.parse('$_apiEndpoint/credentials/$credentialId/revoke'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: json.encode({
          'reason': reason.toString(),
          'details': details,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        // Enregistrer l'action dans l'historique
        final historyEntry = RevocationHistoryEntry(
          credentialId: credentialId,
          timestamp: DateTime.now(),
          action: RevocationAction.revoke,
          reason: reason,
          details: details,
          actor: 'current_user', // À remplacer par l'utilisateur actuel
        );

        await _saveHistoryEntry(historyEntry);

        // Forcer la mise à jour du statut dans le cache
        await _statusService.refreshAllStatusLists();

        return RevocationResult(
          credentialId: credentialId,
          success: true,
          details: 'Attestation révoquée avec succès',
          timestamp: DateTime.now(),
        );
      } else {
        final error = response.body;
        return RevocationResult(
          credentialId: credentialId,
          success: false,
          errorMessage: 'Erreur lors de la révocation: $error',
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      return RevocationResult(
        credentialId: credentialId,
        success: false,
        errorMessage: 'Exception lors de la révocation: $e',
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  Future<RevocationResult> unrevokeCredential({
    required String credentialId,
    String? details,
  }) async {
    try {
      // Vérifier si l'attestation est révoquée
      if (!await isRevoked(credentialId)) {
        return RevocationResult(
          credentialId: credentialId,
          success: false,
          errorMessage: "L'attestation n'est pas révoquée",
          timestamp: DateTime.now(),
        );
      }

      // Appeler l'API pour annuler la révocation
      final response = await _httpClient.post(
        Uri.parse('$_apiEndpoint/credentials/$credentialId/unrevoke'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: json.encode({
          'details': details,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        // Enregistrer l'action dans l'historique
        final historyEntry = RevocationHistoryEntry(
          credentialId: credentialId,
          timestamp: DateTime.now(),
          action: RevocationAction.unrevoke,
          details: details,
          actor: 'current_user', // À remplacer par l'utilisateur actuel
        );

        await _saveHistoryEntry(historyEntry);

        // Forcer la mise à jour du statut dans le cache
        await _statusService.refreshAllStatusLists();

        return RevocationResult(
          credentialId: credentialId,
          success: true,
          details: 'Révocation annulée avec succès',
          timestamp: DateTime.now(),
        );
      } else {
        final error = response.body;
        return RevocationResult(
          credentialId: credentialId,
          success: false,
          errorMessage: "Erreur lors de l'annulation de la révocation: $error",
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      return RevocationResult(
        credentialId: credentialId,
        success: false,
        errorMessage: "Exception lors de l'annulation de la révocation: $e",
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  Future<bool> isRevoked(String credentialId) async {
    try {
      // Utiliser le service de statut pour vérifier la révocation
      final credential = await _getDummyCredential(credentialId);
      final result = await _statusService.checkStatus(credential);

      return result.status == CredentialStatusType.revoked;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<RevocationHistoryEntry>> getRevocationHistory(
    String credentialId,
  ) async {
    try {
      // Récupérer l'historique depuis Hive
      final entries = _historyBox.values
          .map(_mapToHistoryEntry)
          .where((entry) => entry.credentialId == credentialId)
          .toList();

      // Trier par date (plus récent d'abord)
      entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return entries;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> syncRevocationStatus(String credentialId) async {
    await _statusService.refreshAllStatusLists();
  }

  @override
  Future<void> syncAllRevocationStatuses() async {
    await _statusService.refreshAllStatusLists();
  }

  // Convertit un Map en RevocationHistoryEntry
  RevocationHistoryEntry _mapToHistoryEntry(Map<dynamic, dynamic> map) {
    return RevocationHistoryEntry(
      credentialId: map['credentialId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      action: map['action'] == 'revoke'
          ? RevocationAction.revoke
          : RevocationAction.unrevoke,
      reason: _parseReason(map['reason']),
      details: map['details'] as String?,
      actor: map['actor'] as String,
    );
  }

  // Parse la raison depuis la chaîne stockée
  RevocationReason? _parseReason(String? reasonStr) {
    if (reasonStr == null) return null;

    try {
      return RevocationReason.values.firstWhere(
        (r) => r.toString() == reasonStr,
      );
    } catch (e) {
      return null;
    }
  }

  // Sauvegarde une entrée d'historique
  Future<void> _saveHistoryEntry(RevocationHistoryEntry entry) async {
    try {
      final map = {
        'credentialId': entry.credentialId,
        'timestamp': entry.timestamp.toIso8601String(),
        'action':
            entry.action == RevocationAction.revoke ? 'revoke' : 'unrevoke',
        if (entry.reason != null) 'reason': entry.reason.toString(),
        if (entry.details != null) 'details': entry.details,
        'actor': entry.actor,
      };

      await _historyBox.add(map);
    } catch (e) {
      // Gérer l'erreur
    }
  }

  // Crée un credential factice pour les tests
  Future<dynamic> _getDummyCredential(String credentialId) async {
    // Implémentation temporaire - à remplacer par un véritable repository d'attestations
    return {
      'id': credentialId,
      'statusListUrl': 'https://example.com/status/list1',
      'statusListIndex': 123,
    };
  }
}

// Provider pour le service de révocation
final revocationServiceProvider = Provider<RevocationService>((ref) {
  final httpClient = http.Client();
  final statusService = ref.watch(credentialStatusServiceProvider);
  final historyBox = Hive.box<Map<dynamic, dynamic>>('revocation_history');

  return StatusList2021RevocationService(
    httpClient: httpClient,
    statusService: statusService,
    historyBox: historyBox,
    apiEndpoint: 'https://api.example.com/v1', // À configurer
    apiKey: 'YOUR_API_KEY', // À configurer de façon sécurisée
  );
});

// Provider pour le service de statut des attestations
final credentialStatusServiceProvider =
    Provider<CredentialStatusService>((ref) {
  return CredentialStatusService();
});
