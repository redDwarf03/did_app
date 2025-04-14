import 'dart:convert';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:http/http.dart' as http;

/// Service pour gérer la vérification des statuts de révocation
class CredentialStatusService {
  CredentialStatusService({
    http.Client? httpClient,
    Duration? checkInterval,
  })  : _httpClient = httpClient ?? http.Client(),
        _checkInterval = checkInterval ?? const Duration(hours: 1);
  final http.Client _httpClient;
  final Duration _checkInterval;
  final Map<String, StatusList> _statusListCache = {};

  /// Vérifie le statut d'une attestation
  Future<StatusCheckResult> checkStatus(Credential credential) async {
    try {
      // final statusListUrl = credential.statusListUrl;
      // Use the helper method to extract the StatusList2021Entry
      final statusEntry = credential.getStatusList2021Entry();

      if (statusEntry == null) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'StatusList2021 entry data not found or invalid in credential',
        );
      }

      final statusListUrl = statusEntry.statusListCredential;
      final statusListIndex = statusEntry.statusListIndex;

      // Récupérer la liste de statut
      final statusList = await _getStatusList(statusListUrl);
      if (statusList == null) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'Liste de statut non trouvée',
        );
      }

      // Vérifier le statut dans la liste
      final isRevoked =
          // statusList.statuses[credential.statusListIndex] ?? false;
          statusList.statuses[statusListIndex] ?? false;
      final status =
          isRevoked ? CredentialStatusType.revoked : CredentialStatusType.valid;

      return StatusCheckResult(
        credentialId: credential.id,
        status: status,
        checkedAt: DateTime.now(),
        details: isRevoked ? 'Attestation révoquée' : 'Attestation valide',
      );
    } catch (e) {
      return StatusCheckResult(
        credentialId: credential.id,
        status: CredentialStatusType.unknown,
        checkedAt: DateTime.now(),
        error: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Vérifie le statut de plusieurs attestations
  Future<List<StatusCheckResult>> checkStatuses(
    List<Credential> credentials,
  ) async {
    final results = <StatusCheckResult>[];
    for (final credential in credentials) {
      final result = await checkStatus(credential);
      results.add(result);
    }
    return results;
  }

  /// Récupère une liste de statut depuis le cache ou le réseau
  Future<StatusList?> _getStatusList(String url) async {
    // Vérifier le cache
    final cachedList = _statusListCache[url];
    if (cachedList != null &&
        DateTime.now().difference(cachedList.lastUpdated) < _checkInterval) {
      return cachedList;
    }

    try {
      final response = await _httpClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final statusList = StatusList.fromJson(data);
        _statusListCache[url] = statusList;
        return statusList;
      }
    } catch (e) {
      // En cas d'erreur, retourner la version en cache si disponible
      return _statusListCache[url];
    }

    return null;
  }

  /// Force la mise à jour d'une liste de statut
  Future<void> refreshStatusList(String url) async {
    _statusListCache.remove(url);
    await _getStatusList(url);
  }

  /// Force la mise à jour de toutes les listes de statut
  Future<void> refreshAllStatusLists() async {
    final urls = _statusListCache.keys.toList();
    for (final url in urls) {
      await refreshStatusList(url);
    }
  }
}
