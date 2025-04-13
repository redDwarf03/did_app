import 'dart:async';
import 'dart:convert'; // For jsonEncode
import 'dart:typed_data';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'; // For ApiService and Transaction
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

// Import project specific models and interface
import 'package:did_app/features/identity/domain/models/user_identity_details.dart';
import 'package:did_app/features/identity/domain/models/service_creation_result.dart'
    as models;
import 'package:did_app/features/identity/domain/repositories/digital_identity_repository.dart';
// Import providers
import 'package:did_app/application/dapp_client.dart'; // For dappClientProvider
import 'package:did_app/application/api_service.dart'; // For apiServiceProvider

class AWCDigitalIdentityRepository implements DigitalIdentityRepository {
  final awc.ArchethicDAppClient _awcClient;
  final ApiService _apiService; // Inject ApiService
  final Ref _ref;
  static final _logger = Logger('AWCDigitalIdentityRepository');

  final Keychain? _keychain; // Ensure _keychain is defined

  UserIdentityDetails? _lastKnownDetails;
  StreamSubscription? _awcAccountStreamSubscription; // Renamed for clarity
  final StreamController<UserIdentityDetails?> _detailsStreamController =
      StreamController.broadcast();

  AWCDigitalIdentityRepository._internal(
      this._awcClient, this._apiService, this._ref, this._keychain);

  // Use a static async factory method for initialization
  static Future<AWCDigitalIdentityRepository> create(
      awc.ArchethicDAppClient awcClient, ApiService apiService, Ref ref) async {
    // Get the current account to initialize the repository
    final subscriptionResult = await awcClient.subscribeCurrentAccount();

    Keychain? keychain;
    await subscriptionResult.when(
      success: (subscription) async {
        final account = await subscription.updates.first;
        // Note: We don't need to load the keychain here anymore since we're using AWC's methods
        _logger.info('Successfully got current account: ${account.name}');
      },
      failure: (failure) {
        _logger.warning('Failed to get current account: ${failure.message}');
      },
    );

    final repository = AWCDigitalIdentityRepository._internal(
        awcClient, apiService, ref, keychain);
    await repository._initializeSubscription(); // Initialize the subscription
    return repository;
  }

  Future<void> _initializeSubscription() async {
    // Subscribe to AWC account changes
    final subscriptionResult = await _awcClient.subscribeCurrentAccount();

    subscriptionResult.when(
      success: (subscription) {
        // Successfully got the subscription object containing the stream
        _logger.info(
            'Successfully subscribed to current account updates (ID: ${subscription.id}).');
        _awcAccountStreamSubscription = subscription.updates.listen(
          // Listen on the 'updates' stream
          (accountUpdate) async {
            // accountUpdate is of type awc.Account here
            // Removed redundant null check as stream shouldn't yield null based on type
            _logger.info(
                'AWC account updated via stream: ${accountUpdate.name} (${accountUpdate.genesisAddress}). Fetching DID details...');
            try {
              // Use genesisAddress from the Account object
              final keychainAddress = accountUpdate.genesisAddress;
              final Map<String, Transaction> txMap =
                  await _apiService.getLastTransaction([keychainAddress]);
              final Transaction? keychainTx = txMap[keychainAddress];

              if (keychainTx == null || keychainTx.type != 'keychain') {
                _logger.warning(
                    'Keychain transaction not found or type mismatch for address: $keychainAddress');
                _lastKnownDetails = null;
                _detailsStreamController.add(null);
                return;
              }

              final String? content = keychainTx.data?.content;
              if (content == null || content.isEmpty) {
                _logger.warning(
                    'Keychain transaction content is empty for address: $keychainAddress');
                _lastKnownDetails = null;
                _detailsStreamController.add(null);
                return;
              }

              // Parse DID Document from content
              final Map<String, dynamic> didDocument = jsonDecode(content);
              final String did = didDocument['id'] as String? ?? '';
              // Extract services from DID Document
              final List<dynamic> verificationMethods = (didDocument[
                      'verificationMethod'] ??
                  didDocument[
                      'authentication'] ?? // Fallback if verificationMethod is missing
                  []) as List<dynamic>;
              final List<String> services = verificationMethods
                  .map((vm) {
                    final id = vm['id'] as String?;
                    // Extract fragment, handle potential missing '#' and null id
                    return id?.contains('#') == true
                        ? id!.split('#').last
                        : null;
                  })
                  .whereType<String>() // Filter out nulls
                  .toSet() // Use Set to ensure uniqueness
                  .toList();

              final details = UserIdentityDetails(
                did: did,
                selectedAddress:
                    accountUpdate.genesisAddress, // Use genesisAddress
                availableServices: services,
              );
              _lastKnownDetails = details;
              _detailsStreamController.add(details);
              _logger.info('Successfully fetched DID details: $details');
            } catch (e, stackTrace) {
              _logger.severe('Error fetching or parsing keychain details: $e',
                  e, stackTrace);
              _lastKnownDetails = null;
              _detailsStreamController.addError(e, stackTrace);
            }
          },
          onError: (e, stackTrace) {
            _logger.severe(
                'Error in AWC account subscription stream: $e', e, stackTrace);
            _lastKnownDetails = null;
            _detailsStreamController.addError(e, stackTrace);
          },
        );
      },
      failure: (failure) {
        // Failed to get the subscription object itself
        _logger.severe(
            'Failed to subscribe to AWC current account: ${failure.message}');
        _detailsStreamController.addError(Exception(
            'Failed to subscribe to AWC current account: ${failure.message}'));
      },
    );
  }

  // Dispose subscriptions and controller
  void dispose() {
    _awcAccountStreamSubscription?.cancel(); // Use the correct variable name
    _detailsStreamController.close();
  }

  @override
  Stream<UserIdentityDetails?> watchCurrentUserIdentity() {
    // Return the stream from the controller populated by the AWC subscription
    return _detailsStreamController.stream;
  }

  @override
  Future<models.ServiceCreationResult> addDappService({
    required String serviceName,
    String?
        derivationPath, // Wallet might use a default if null - NOTE: AWC Request might not support it
  }) async {
    _logger.info("Requesting to add service: $serviceName");
    // addService expects AddServiceRequest from AWC
    final request = awc.AddServiceRequest(name: serviceName);
    final response = await _awcClient.addService(request);

    // The return type of addService is Result<SendTransactionResult, Failure>
    return response.when(
      failure: (failure) {
        _logger.severe('Failed to add service: ${failure.message}', failure);
        throw Exception('Failed to add service: ${failure.message}');
      },
      success: (result) {
        // result is of type awc.SendTransactionResult
        _logger.info(
            'Successfully added service: ${jsonEncode(result)} - ${result.transactionAddress}');
        final currentDid = _lastKnownDetails?.did ?? 'unknown:did';
        // Trigger a refresh of identity details after adding service?
        // Or assume the wallet/AWC subscription will pick up the change.
        // Use the imported model with alias
        return models.ServiceCreationResult(
          serviceName: serviceName,
          did: currentDid,
          rawResponse: result.toJson(), // Convert AWC result model to JSON Map
        );
      },
    );
  }

  @override
  Future<bool> checkDappServiceExists({required String serviceName}) async {
    final details = _lastKnownDetails;
    _logger.info(
        'Checking if service "$serviceName" exists. Known details: $details');
    if (details == null) {
      _logger.warning(
          'Cannot check service existence, no identity details available.');
      // Optionally, try to fetch details if null?
      return false;
    }
    return details.availableServices.contains(serviceName);
  }

  @override
  Future<dynamic> requestTransactionSignature(
      Map<String, dynamic> transactionJsonData) async {
    _logger.info('Requesting transaction signature via AWC...');

    // Extract parameters for SendTransactionRequest based on its definition
    final String? type = transactionJsonData['type'] as String?;
    final int? version = transactionJsonData['version'] as int?;
    final Map<String, dynamic>? dataMap =
        transactionJsonData['data'] as Map<String, dynamic>?;
    final bool? generateEncryptedSeedSC =
        transactionJsonData['generateEncryptedSeedSC']
            as bool?; // Optional param

    if (type == null || version == null || dataMap == null) {
      _logger.severe(
          'Transaction data is missing required fields: type, version, or data map');
      throw ArgumentError(
          'Transaction data must contain type, version, and a data map.');
    }

    // Construct the libdart Data object from the map
    final Data dataObject;
    try {
      dataObject = Data.fromJson(dataMap);
    } catch (e, stackTrace) {
      _logger.severe(
          'Failed to create Data object from json: $e', e, stackTrace);
      throw ArgumentError('Invalid format for transaction data map: $e');
    }

    // Construct the request using named parameters
    final request = awc.SendTransactionRequest(
      type: type,
      version: version,
      data: dataObject, // Pass the constructed Data object
      generateEncryptedSeedSC: generateEncryptedSeedSC, // Pass optional param
    );

    final response = await _awcClient.sendTransaction(request);

    // sendTransaction returns Result<SendTransactionResult, Failure>
    response.when(
      failure: (f) =>
          _logger.warning('Transaction signature failed: ${f.message}'),
      success: (r) => // r is SendTransactionResult
          _logger.info('Transaction signature successful: ${jsonEncode(r)}'),
    );
    // Return the whole response object (Result<SendTransactionResult, Failure>)
    // or handle/transform it as needed. Returning dynamic allows flexibility.
    return response;
  }

  @override
  Future<String?> getExpectedServiceAddress(String serviceName) async {
    try {
      // Use AWC's keychain_derive_address method instead of direct keychain access
      final response = await _awcClient.keychainDeriveAddress(
        awc.KeychainDeriveAddressRequest(
          serviceName: serviceName,
          index: 0, // Default index
          pathSuffix: '', // Default suffix
        ),
      );

      return response.when(
        success: (result) => result.address,
        failure: (failure) {
          _logger
              .warning('Failed to derive service address: ${failure.message}');
          return null;
        },
      );
    } catch (e) {
      _logger.severe('Error deriving service address: $e');
      return null;
    }
  }
}

// Provider for the repository - Changed to FutureProvider
final digitalIdentityRepositoryProvider =
    FutureProvider<AWCDigitalIdentityRepository>((ref) async {
  // Get ApiService instance
  final apiService = ref.watch(apiServiceProvider);

  // Await the AWC client instance using the correct provider
  // FutureProvider handles the async states automatically.
  final dappClient = await ref.watch(dappClientProvider.future);

  // Create the repository using the async factory
  final repo =
      await AWCDigitalIdentityRepository.create(dappClient, apiService, ref);

  // Ensure dispose is called when the provider is disposed/recomputed
  ref.onDispose(() => repo.dispose());

  return repo;
});
