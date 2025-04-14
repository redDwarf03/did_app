import 'dart:async';
import 'dart:convert';

import 'package:did_app/application/secure_storage.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

/// Provider for the CredentialRepository implementation.
final credentialRepositoryProvider = Provider<CredentialRepository>((ref) {
  final secureStorage = ref.watch(flutterSecureStorageProvider);
  // Return the secure storage implementation
  final repository = SecureStorageCredentialRepository(secureStorage);

  // Ensure the stream controller is closed when the provider is disposed
  ref.onDispose(repository.dispose);

  return repository;
});

/// Implementation of [CredentialRepository] that uses [FlutterSecureStorage]
/// for persisting Verifiable Credentials securely on the device.
///
/// Credentials are stored as a JSON array string under a specific key.
class SecureStorageCredentialRepository implements CredentialRepository {
  // Use sync for immediate notification

  /// Creates an instance of [SecureStorageCredentialRepository].
  /// Requires an instance of [FlutterSecureStorage].
  SecureStorageCredentialRepository(this._secureStorage) {
    _logger.info('SecureStorageCredentialRepository initialized.');

    _loadInitialData();
  }
  final FlutterSecureStorage _secureStorage;
  final _logger = Logger('SecureStorageCredentialRepository');

  static const _credentialsStorageKey = 'verifiable_credentials_list';

  // Stream controller to notify listeners about changes in the credential list.
  // Using broadcast stream to allow multiple listeners.
  final StreamController<List<Credential>> _credentialStreamController =
      StreamController.broadcast(sync: true);

  // Load initial data when the repository is created
  Future<void> _loadInitialData() async {
    final currentCredentials = await _readCredentialsFromStorage();
    _credentialStreamController.add(currentCredentials);
  }

  /// Reads the stored JSON string, deserializes it into a list of maps,
  /// and then into a list of [Credential] objects.
  Future<List<Credential>> _readCredentialsFromStorage() async {
    try {
      final jsonString = await _secureStorage.read(key: _credentialsStorageKey);
      if (jsonString == null || jsonString.isEmpty) {
        _logger.fine('No credentials found in storage.');
        return []; // No credentials stored yet
      }
      _logger.fine('Reading credentials from storage...');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final credentials = jsonList
          .map((jsonItem) {
            try {
              // Ensure each item is a map before parsing
              if (jsonItem is Map<String, dynamic>) {
                return Credential.fromJson(jsonItem);
              } else {
                _logger.warning(
                  'Found non-map item in stored credentials: $jsonItem',
                );
                return null; // Skip invalid items
              }
            } catch (e, stackTrace) {
              _logger.severe(
                'Failed to parse stored credential item: $jsonItem',
                e,
                stackTrace,
              );
              return null; // Skip items that fail parsing
            }
          })
          .whereType<Credential>() // Filter out nulls from skipped/failed items
          .toList();
      _logger.fine('Successfully read ${credentials.length} credentials.');
      return credentials;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to read or decode credentials from secure storage',
        e,
        stackTrace,
      );
      // In case of error (e.g., corrupted data), return empty list or throw?
      // Returning empty might be safer for UX.
      return [];
    }
  }

  /// Serializes the list of [Credential] objects into a JSON string
  /// and writes it to secure storage. Also notifies listeners.
  Future<void> _writeCredentialsToStorage(List<Credential> credentials) async {
    try {
      final jsonList = credentials.map((cred) => cred.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      _logger.fine('Writing ${credentials.length} credentials to storage...');
      await _secureStorage.write(
        key: _credentialsStorageKey,
        value: jsonString,
      );
      // Notify listeners about the change *after* successful write
      _credentialStreamController
          .add(List.unmodifiable(credentials)); // Emit immutable list
      _logger.info(
        'Successfully wrote ${credentials.length} credentials to storage.',
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to encode or write credentials to secure storage',
        e,
        stackTrace,
      );
      // Decide how to handle write errors. Throwing might be appropriate.
      throw Exception('Failed to save credentials securely: $e');
    }
  }

  // --- CredentialRepository Implementation ---

  @override
  Future<List<Credential>> getCredentials() async {
    _logger.info('Getting all credentials...');
    return _readCredentialsFromStorage();
  }

  @override
  Future<Credential?> getCredentialById(String id) async {
    _logger.info('Getting credential by id: $id');
    final credentials = await _readCredentialsFromStorage();
    try {
      // Use firstWhereOrNull from collection package for cleaner null handling
      // return credentials.firstWhereOrNull((cred) => cred.id == id);
      // Using try-catch for now as collection package might not be added
      return credentials.firstWhere((cred) => cred.id == id);
    } catch (e) {
      // firstWhere throws StateError if no element is found
      _logger.warning('Credential with id $id not found.');
      return null;
    }
  }

  @override
  Future<void> saveCredential(Credential credential) async {
    _logger.info('Saving credential with id: ${credential.id}');
    final credentials = await _readCredentialsFromStorage();
    // Use a modifiable list for manipulation
    final updatedList = List<Credential>.from(credentials);
    final index = updatedList.indexWhere((cred) => cred.id == credential.id);
    if (index != -1) {
      _logger.info('Updating existing credential with id: ${credential.id}');
      updatedList[index] = credential;
    } else {
      _logger.info('Adding new credential with id: ${credential.id}');
      updatedList.add(credential);
    }
    await _writeCredentialsToStorage(updatedList);
  }

  @override
  Future<void> deleteCredential(String id) async {
    _logger.info('Deleting credential with id: $id');
    final credentials = await _readCredentialsFromStorage();
    // Use a modifiable list for manipulation
    final updatedList = List<Credential>.from(credentials);
    final initialLength = updatedList.length;
    updatedList.removeWhere((cred) => cred.id == id);

    if (updatedList.length < initialLength) {
      _logger.info('Credential found and removed. Writing updated list.');
      await _writeCredentialsToStorage(updatedList);
    } else {
      _logger.warning('Credential with id $id not found for deletion.');
      // No need to write or notify if nothing changed
    }
  }

  @override
  Stream<List<Credential>> watchCredentials() {
    _logger.info('Providing credential watch stream.');
    // Seed the stream with current data when a listener attaches for the first time
    if (!_credentialStreamController.hasListener) {
      _logger.fine('No listeners yet, seeding stream with initial data.');
      getCredentials().then((initialData) {
        if (!_credentialStreamController.isClosed) {
          _credentialStreamController.add(List.unmodifiable(initialData));
        }
      }).catchError((e, s) {
        _logger.severe('Error seeding credential stream', e, s);
        if (!_credentialStreamController.isClosed) {
          _credentialStreamController.addError(e, s);
        }
      });
    } else {
      _logger.fine('Stream already has listeners.');
    }
    return _credentialStreamController.stream;
  }

  @override
  Future<bool> verifyCredential(Credential credential) async {
    _logger.info('Verifying credential (basic checks): ${credential.id}');
    // Basic checks: Expiration
    // NOTE: This does NOT perform cryptographic proof verification!
    if (credential.expirationDate != null &&
        credential.expirationDate!.isBefore(DateTime.now())) {
      _logger.warning('Credential ${credential.id} has expired.');
      return false; // Expired
    }

    // TODO: Implement cryptographic verification of the credential.proof
    // TODO: Implement credentialStatus (revocation) check.

    _logger.info(
        'Credential ${credential.id} passed basic checks (expiration). Proof/Status not checked.');
    // For now, return true if not expired. This is NOT a full verification.
    return true;
  }

  @override
  Future<CredentialPresentation> createPresentation({
    required List<Credential> credentials,
    required Map<String, List<String>> selectiveDisclosure,
    String? challenge,
    String? domain,
  }) async {
    _logger.warning('createPresentation not implemented yet.');
    throw UnimplementedError('Presentation creation is not yet implemented.');
  }

  @override
  Future<bool> verifyPresentation(CredentialPresentation presentation) async {
    _logger.warning('verifyPresentation not implemented yet.');
    throw UnimplementedError(
        'Presentation verification is not yet implemented.');
  }

  @override
  Future<String> sharePresentation(CredentialPresentation presentation) async {
    _logger.warning('sharePresentation not implemented yet.');
    throw UnimplementedError('Sharing presentations is not yet implemented.');
  }

  @override
  Future<Credential> receiveCredential(String uri) async {
    _logger.warning('receiveCredential not implemented yet.');
    throw UnimplementedError('Receiving credentials is not yet implemented.');
  }

  @override
  Future<Map<String, dynamic>> receivePresentationRequest(String uri) async {
    _logger.warning('receivePresentationRequest not implemented yet.');
    throw UnimplementedError(
        'Receiving presentation requests is not yet implemented.');
  }

  /// Closes the stream controller when the repository is disposed.
  void dispose() {
    _credentialStreamController.close();
    _logger
        .info('SecureStorageCredentialRepository disposed and stream closed.');
  }
}
