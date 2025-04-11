import 'dart:convert';
import 'dart:typed_data';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/domain/credential/status_list_2021.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

/// Service d'implémentation du Status List 2021
/// selon la spécification du W3C: https://w3c.github.io/vc-status-list-2021/
class StatusList2021Service {

  StatusList2021Service({
    required http.Client httpClient,
    required Box<Map<dynamic, dynamic>> cacheBox,
    Duration? cacheDuration,
  })  : _httpClient = httpClient,
        _cacheBox = cacheBox,
        _cacheDuration = cacheDuration ?? const Duration(hours: 1);
  final http.Client _httpClient;
  final Box<Map<dynamic, dynamic>> _cacheBox;
  final Duration _cacheDuration;

  /// Vérifie le statut d'une attestation à l'aide de Status List 2021
  Future<StatusCheckResult> checkCredentialStatus(Credential credential) async {
    try {
      // Vérifier si l'attestation a un statut Status List 2021
      final statusEntry = _getStatusEntryFromCredential(credential);
      if (statusEntry == null) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'Aucune information de statut Status List 2021 trouvée',
        );
      }

      // Récupérer la liste de statut
      final statusList =
          await _fetchStatusListCredential(statusEntry.statusListCredential);
      if (statusList == null) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'Impossible de récupérer la liste de statut',
        );
      }

      // Vérifier que la liste est valide pour l'usage prévu
      if (statusList.credentialSubject.statusPurpose !=
          statusEntry.statusPurpose) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error:
              "La finalité de la liste ne correspond pas à celle de l'entrée",
        );
      }

      // Vérifier l'index
      final maxIndex = statusList.credentialSubject.statusListSize - 1;
      if (statusEntry.statusListIndex < 0 ||
          statusEntry.statusListIndex > maxIndex) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'Index de statut invalide',
        );
      }

      // Décoder la liste et vérifier le statut
      final bitset = _decodeBitset(
        statusList.credentialSubject.encodedList,
        statusList.credentialSubject.encoding,
      );

      final isRevoked = _getBitAtIndex(bitset, statusEntry.statusListIndex);
      final statusType =
          isRevoked ? CredentialStatusType.revoked : CredentialStatusType.valid;

      // Status List 2021 ne gère pas l'expiration, nous devons vérifier séparément
      if (statusType == CredentialStatusType.valid &&
          credential.expirationDate != null &&
          DateTime.now().isAfter(credential.expirationDate!)) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.expired,
          checkedAt: DateTime.now(),
          details: 'Attestation expirée',
        );
      }

      final details = statusType == CredentialStatusType.revoked
          ? 'Attestation révoquée via Status List 2021'
          : 'Attestation valide selon Status List 2021';

      return StatusCheckResult(
        credentialId: credential.id,
        status: statusType,
        checkedAt: DateTime.now(),
        details: details,
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

  /// Récupère une liste de statut depuis l'URL fournie
  /// avec mise en cache pour les performances
  Future<StatusList2021Credential?> _fetchStatusListCredential(
      String url,) async {
    try {
      // Vérifier le cache d'abord
      final cachedData = _getCachedStatusList(url);
      if (cachedData != null) {
        return cachedData;
      }

      // Récupérer depuis le réseau
      final response = await _httpClient.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return null;
      }

      final jsonData = json.decode(response.body);
      final statusList = StatusList2021Credential.fromJson(jsonData);

      // Stocker dans le cache
      _cacheStatusList(url, statusList);

      return statusList;
    } catch (e) {
      // En cas d'erreur, essayer de retourner la version en cache même expirée
      return _getCachedStatusList(url, ignoreExpiry: true);
    }
  }

  /// Récupère une liste de statut depuis le cache
  StatusList2021Credential? _getCachedStatusList(
    String url, {
    bool ignoreExpiry = false,
  }) {
    try {
      final cacheKey = _getCacheKey(url);
      final cachedMap = _cacheBox.get(cacheKey);

      if (cachedMap == null) {
        return null;
      }

      final cachedTime = DateTime.parse(cachedMap['timestamp'] as String);
      final isExpired = DateTime.now().difference(cachedTime) > _cacheDuration;

      if (isExpired && !ignoreExpiry) {
        return null;
      }

      return StatusList2021Credential.fromJson(
          cachedMap['data'] as Map<String, dynamic>,);
    } catch (e) {
      return null;
    }
  }

  /// Stocke une liste de statut dans le cache
  void _cacheStatusList(String url, StatusList2021Credential credential) {
    try {
      final cacheKey = _getCacheKey(url);
      final cacheData = {
        'timestamp': DateTime.now().toIso8601String(),
        'data': credential.toJson(),
      };

      _cacheBox.put(cacheKey, cacheData);
    } catch (e) {
      // Ignorer les erreurs de cache
    }
  }

  /// Génère une clé de cache pour une URL
  String _getCacheKey(String url) {
    return 'status_list_${base64Url.encode(utf8.encode(url))}';
  }

  /// Force la mise à jour d'une liste de statut dans le cache
  Future<void> refreshStatusList(String url) async {
    final cacheKey = _getCacheKey(url);
    await _cacheBox.delete(cacheKey);
    await _fetchStatusListCredential(url);
  }

  /// Récupère une liste de statut par son URL
  Future<StatusList2021Credential> getStatusList(String url) async {
    final statusList = await _fetchStatusListCredential(url);
    if (statusList == null) {
      throw Exception('Impossible de récupérer la liste de statut');
    }
    return statusList;
  }

  /// Extrait l'entrée de statut Status List 2021 d'une attestation
  StatusList2021Entry? _getStatusEntryFromCredential(Credential credential) {
    return credential.getStatusList2021Entry();
  }

  /// Décode une liste de statut encodée en base64url
  Uint8List _decodeBitset(String encodedList, String encoding) {
    if (encoding != 'base64url') {
      throw UnsupportedError("Seul l'encodage base64url est supporté");
    }

    return base64Url.decode(encodedList);
  }

  /// Récupère la valeur d'un bit à un index donné
  bool _getBitAtIndex(Uint8List bitset, int index) {
    final byteIndex = index ~/ 8;
    final bitIndex = index % 8;

    if (byteIndex >= bitset.length) {
      return false;
    }

    return (bitset[byteIndex] & (1 << (7 - bitIndex))) != 0;
  }

  /// Construit une liste de statut à partir d'un mappage de bits
  Uint8List _buildBitset(Map<int, bool> statusMap, int size) {
    final byteLength = (size + 7) ~/ 8;
    final bitset = Uint8List(byteLength);

    // Initialiser tous les bits à 0
    for (var i = 0; i < bitset.length; i++) {
      bitset[i] = 0;
    }

    // Définir les bits selon le mappage
    statusMap.forEach((index, isRevoked) {
      if (isRevoked && index >= 0 && index < size) {
        final byteIndex = index ~/ 8;
        final bitIndex = index % 8;
        bitset[byteIndex] |= 1 << bitIndex;
      }
    });

    return bitset;
  }
}

/// Provider pour le service Status List 2021
final statusList2021ServiceProvider = Provider<StatusList2021Service>((ref) {
  return StatusList2021Service(
    httpClient: http.Client(),
    cacheBox: Hive.box<Map<dynamic, dynamic>>('status_list_cache'),
  );
});
