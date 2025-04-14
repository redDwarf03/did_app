import 'dart:convert';

import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

/// Implementation of [IdentityRepository] that uses [FlutterSecureStorage]
/// for persisting the user's core [DigitalIdentity] profile.
///
/// Stores the single identity profile as a JSON string under a specific key.
class SecureStorageIdentityRepository implements IdentityRepository {
  /// Creates an instance of [SecureStorageIdentityRepository].
  /// Requires an instance of [FlutterSecureStorage].
  SecureStorageIdentityRepository(this._secureStorage);

  final FlutterSecureStorage _secureStorage;
  final _logger = Logger('SecureStorageIdentityRepository');
  final _uuid = const Uuid();

  // Unique key to store the single user identity profile.
  static const _identityStorageKey = 'digital_identity_profile';

  @override
  Future<DigitalIdentity> createIdentity({
    required String displayName,
    required PersonalInfo personalInfo,
  }) async {
    _logger.info('Attempting to create identity...');
    if (await hasIdentity()) {
      _logger.warning('Identity creation failed: An identity already exists.');
      throw Exception('Cannot create identity: An identity already exists.');
    }

    // Generate a temporary UUID-based identity address for local storage.
    // This is NOT a real blockchain address.
    final identityAddress = 'urn:did:uuid:${_uuid.v4()}';
    final now = DateTime.now();

    final identity = DigitalIdentity(
      identityAddress: identityAddress,
      displayName: displayName,
      personalInfo: personalInfo,
      createdAt: now,
      updatedAt: now,
    );

    await _writeIdentity(identity);
    _logger.info(
      'Successfully created and saved identity with address: $identityAddress',
    );
    return identity;
  }

  Future<void> deleteIdentity() async {
    _logger.info('Deleting identity...');
    if (!await hasIdentity()) {
      _logger.warning('Delete operation skipped: No identity found to delete.');
      return; // Nothing to delete
    }
    try {
      await _secureStorage.delete(key: _identityStorageKey);
      _logger.info('Successfully deleted identity from storage.');
    } catch (e, stackTrace) {
      _logger.severe('Failed to delete identity from storage', e, stackTrace);
      throw Exception('Failed to delete identity: $e');
    }
  }

  @override
  Future<DigitalIdentity?> getIdentity() async {
    _logger.fine('Getting identity...');
    final identity = await _readIdentity();
    if (identity == null) {
      _logger.info('No identity found in storage.');
    } else {
      _logger.fine('Identity found with address: ${identity.identityAddress}');
    }
    return identity;
  }

  @override
  Future<bool> hasIdentity() async {
    _logger.fine('Checking if identity exists...');
    final exists = await _secureStorage.containsKey(key: _identityStorageKey);
    _logger.fine('Identity exists check result: $exists');
    return exists;
  }

  @override
  Future<DigitalIdentity> updateIdentity({
    required DigitalIdentity identity,
  }) async {
    _logger.info('Updating identity with address: ${identity.identityAddress}');
    if (!await hasIdentity()) {
      _logger.warning('Update failed: No identity found to update.');
      throw Exception('Cannot update identity: No identity exists.');
    }

    // Ensure the updatedAt timestamp is current
    final updatedIdentity = identity.copyWith(updatedAt: DateTime.now());

    await _writeIdentity(updatedIdentity);
    _logger.info('Successfully updated identity.');
    return updatedIdentity;
  }

  // --- Helper Methods ---

  Future<DigitalIdentity?> _readIdentity() async {
    try {
      final jsonString = await _secureStorage.read(key: _identityStorageKey);
      if (jsonString == null || jsonString.isEmpty) {
        return null; // No identity stored
      }
      _logger.fine('Reading identity JSON from storage.');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      final identity = DigitalIdentity.fromJson(jsonMap);
      _logger.fine('Successfully parsed identity from JSON.');
      return identity;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to read or parse identity from storage',
        e,
        stackTrace,
      );
      // Optionally, delete corrupted data?
      // await _secureStorage.delete(key: _identityStorageKey);
      return null; // Return null on error
    }
  }

  Future<void> _writeIdentity(DigitalIdentity identity) async {
    try {
      _logger.fine('Writing identity JSON to storage...');
      final jsonMap = identity.toJson();
      final jsonString = jsonEncode(jsonMap);
      await _secureStorage.write(key: _identityStorageKey, value: jsonString);
      _logger.fine('Successfully wrote identity to storage.');
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to encode or write identity to storage',
        e,
        stackTrace,
      );
      throw Exception('Failed to save identity securely: $e');
    }
  }
}
