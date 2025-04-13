import 'dart:convert';
import 'dart:typed_data';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/domain/credential/status_list_2021.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

/// Service implementing Status List 2021 according to the W3C specification:
/// https://w3c.github.io/vc-status-list-2021/
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

  /// Checks the status of a credential using the Status List 2021 mechanism.
  Future<StatusCheckResult> checkCredentialStatus(Credential credential) async {
    try {
      // Check if the credential has Status List 2021 information
      final statusEntry = _getStatusEntryFromCredential(credential);
      if (statusEntry == null) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'No Status List 2021 information found in credential',
        );
      }

      // Fetch the status list credential
      final statusList =
          await _fetchStatusListCredential(statusEntry.statusListCredential);
      if (statusList == null) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'Could not fetch the status list credential',
        );
      }

      // Verify that the list's purpose matches the entry's purpose
      if (statusList.credentialSubject.statusPurpose !=
          statusEntry.statusPurpose) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error: 'Status list purpose does not match status entry purpose',
        );
      }

      // Validate the status index
      // Infer size from the decoded bitset length
      final decodedList = _decodeBitset(
        statusList.credentialSubject.encodedList,
        statusList.credentialSubject.encoding,
      );
      final statusListSize = decodedList.length * 8;
      final maxIndex = statusListSize - 1;

      if (statusEntry.statusListIndex < 0 ||
          statusEntry.statusListIndex > maxIndex) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.unknown,
          checkedAt: DateTime.now(),
          error:
              'Invalid status index (index: ${statusEntry.statusListIndex}, max: $maxIndex)',
        );
      }

      // Decode the bitset and check the status
      final bitset = decodedList; // Use already decoded list

      final isRevoked = _getBitAtIndex(bitset, statusEntry.statusListIndex);
      final statusType =
          isRevoked ? CredentialStatusType.revoked : CredentialStatusType.valid;

      // Status List 2021 does not handle expiration; check separately.
      if (statusType == CredentialStatusType.valid &&
          credential.expirationDate != null &&
          DateTime.now().isAfter(credential.expirationDate!)) {
        return StatusCheckResult(
          credentialId: credential.id,
          status: CredentialStatusType.expired,
          checkedAt: DateTime.now(),
          details: 'Credential has expired',
        );
      }

      final details = statusType == CredentialStatusType.revoked
          ? 'Credential revoked according to Status List 2021'
          : 'Credential valid according to Status List 2021';

      return StatusCheckResult(
        credentialId: credential.id,
        status: statusType,
        checkedAt: DateTime.now(),
        details: details,
      );
    } catch (e) {
      // TODO: Log error
      return StatusCheckResult(
        credentialId: credential.id,
        status: CredentialStatusType.unknown,
        checkedAt: DateTime.now(),
        error: 'Error during status check: $e',
      );
    }
  }

  /// Fetches a status list credential from the given URL, using caching.
  Future<StatusList2021Credential?> _fetchStatusListCredential(
    String url,
  ) async {
    try {
      // Check cache first
      final cachedData = _getCachedStatusList(url);
      if (cachedData != null) {
        return cachedData;
      }

      // Fetch from network
      final response = await _httpClient.get(Uri.parse(url));
      if (response.statusCode != 200) {
        // TODO: Log HTTP error
        return null;
      }

      final jsonData = json.decode(response.body);
      final statusList = StatusList2021Credential.fromJson(jsonData);

      // Store in cache
      _cacheStatusList(url, statusList);

      return statusList;
    } catch (e) {
      // TODO: Log error
      // On error, attempt to return cached version even if expired
      return _getCachedStatusList(url, ignoreExpiry: true);
    }
  }

  /// Retrieves a status list from the cache.
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
        cachedMap['data'] as Map<String, dynamic>,
      );
    } catch (e) {
      // TODO: Log cache read error
      return null;
    }
  }

  /// Stores a status list credential in the cache.
  void _cacheStatusList(String url, StatusList2021Credential credential) {
    try {
      final cacheKey = _getCacheKey(url);
      final cacheData = {
        'timestamp': DateTime.now().toIso8601String(),
        'data': credential.toJson(),
      };

      _cacheBox.put(cacheKey, cacheData);
    } catch (e) {
      // TODO: Log cache write error
      // Ignore cache errors for now
    }
  }

  /// Generates a cache key for a given URL.
  String _getCacheKey(String url) {
    // Use base64url encoding of the URL for a safe cache key
    return 'status_list_${base64Url.encode(utf8.encode(url))}';
  }

  /// Forces a refresh of a specific status list in the cache.
  Future<void> refreshStatusList(String url) async {
    final cacheKey = _getCacheKey(url);
    await _cacheBox.delete(cacheKey);
    await _fetchStatusListCredential(url); // Fetch and re-cache
  }

  /// Retrieves a status list by its URL (fetches if not cached or expired).
  Future<StatusList2021Credential> getStatusList(String url) async {
    final statusList = await _fetchStatusListCredential(url);
    if (statusList == null) {
      throw Exception('Could not retrieve status list credential from $url');
    }
    return statusList;
  }

  /// Extracts the StatusList2021Entry from a credential's status property.
  StatusList2021Entry? _getStatusEntryFromCredential(Credential credential) {
    return credential.getStatusList2021Entry();
  }

  /// Decodes a base64url encoded bitset.
  Uint8List _decodeBitset(String encodedList, String encoding) {
    // Currently only supports base64url encoding as per spec example
    if (encoding != 'base64url') {
      throw UnsupportedError(
          'Only base64url encoding is supported for status list');
    }
    // Add padding if needed for base64Url decoding
    final padded = base64Url.normalize(encodedList);
    return base64Url.decode(padded);
  }

  /// Gets the value of a bit at a specific index in the bitset.
  bool _getBitAtIndex(Uint8List bitset, int index) {
    final byteIndex = index ~/ 8;
    final bitIndex = index % 8;

    if (byteIndex >= bitset.length) {
      // Index out of bounds defaults to not revoked (bit = 0)
      return false;
    }

    // Check the specific bit within the byte (MSB is bit 0)
    return (bitset[byteIndex] & (1 << (7 - bitIndex))) != 0;
  }

  // Note: _buildBitset method removed as it seems related to creating/managing
  // status lists, not just checking them, which might belong elsewhere.
  // /// Builds a bitset from a status map (for creating/updating lists).
  // Uint8List _buildBitset(Map<int, bool> statusMap, int size) {
  //   ...
  // }
}

/// Provider for the Status List 2021 service
final statusList2021ServiceProvider = Provider<StatusList2021Service>((ref) {
  return StatusList2021Service(
    httpClient: http.Client(),
    cacheBox: Hive.box<Map<dynamic, dynamic>>('status_list_cache'),
  );
});
