import 'dart:async';
import 'dart:developer';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:did_app/application/dapp_client.dart';
import 'package:did_app/application/session/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

/// Environment provider based on the current session
@riverpod
Environment environment(Ref ref) => ref.watch(
      sessionNotifierProvider.select(
        (session) => session.environment,
      ),
    );

/// Session state provider
@riverpod
class SessionNotifier extends _$SessionNotifier {
  SessionNotifier();

  StreamSubscription<awc.ArchethicDappConnectionState>?
      _connectionStateSubscription;

  Completer? _connectionCompleter;
  StreamSubscription<awc.ArchethicDappConnectionState>?
      _connectionTaskStateSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      _connectionStateSubscription?.cancel();
    });

    // Listen for dapp client changes
    ref.watch(dappClientProvider).when(
          data: (dappClient) {
            _listenConnectionState(dappClient);

            // Auto-connect after a short delay
            Future.delayed(
              const Duration(milliseconds: 50),
              connectWallet,
            );
          },
          loading: () {},
          error: (error, stack) {},
        );

    // Initial state
    return const Session(
      environment: Environment.mainnet,
      walletConnectionState: awc.ArchethicDappConnectionState.disconnected(),
    );
  }

  /// Connects to Archethic Wallet and waits for the connection to complete
  Future<void> connectWallet() async {
    if (_connectionCompleter != null) return _connectionCompleter!.future;

    // Force a new client creation if there was an error
    if (ref.exists(dappClientProvider) &&
        ref.read(dappClientProvider).hasError) {
      ref.invalidate(dappClientProvider);
    }

    final dappClientAsync = ref.read(dappClientProvider);

    if (dappClientAsync is! AsyncData || dappClientAsync.value == null) {
      return Future.error('Dapp client not ready or null');
    }

    final dappClient = dappClientAsync.value!;

    _connectionCompleter = Completer();
    _connectionTaskStateSubscription =
        dappClient.connectionStateStream.listen((connectionState) {
      connectionState.maybeWhen(
        connected: () {
          _connectionCompleter?.complete();
          _connectionCompleter = null;
          _connectionTaskStateSubscription?.cancel();
          _connectionTaskStateSubscription = null;
        },
        orElse: () {
          _connectionCompleter?.complete();
          _connectionCompleter = null;
          _connectionTaskStateSubscription?.cancel();
          _connectionTaskStateSubscription = null;
        },
      );
    });

    try {
      await dappClient.connect();
    } catch (e) {
      _handleConnectionFailure();
    }

    return _connectionCompleter?.future;
  }

  /// Listens for changes in the wallet connection state
  void _listenConnectionState(awc.ArchethicDAppClient dappClient) {
    _connectionStateSubscription =
        dappClient.connectionStateStream.listen((connectionState) {
      connectionState.maybeWhen(
        disconnected: _onWalletDisconnected,
        connected: () => _onWalletConnected(dappClient),
        orElse: () => update(
          (state) => state.copyWith(walletConnectionState: connectionState),
        ),
      );
    });
  }

  /// Handle when wallet is disconnected
  Future<void> _onWalletDisconnected() async {
    state = const Session(
      environment: Environment.mainnet,
      walletConnectionState: awc.ArchethicDappConnectionState.disconnected(),
    );
  }

  /// Handle when wallet is connected
  Future<void> _onWalletConnected(awc.ArchethicDAppClient dappClient) async {
    log('Wallet connected');
    try {
      // Get the endpoint from the wallet
      final endpointResult = await dappClient.getEndpoint().valueOrThrow;
      final environment = Environment.byEndpoint(endpointResult.endpointUrl);

      // Get the current account
      final currentAccount = await dappClient.getCurrentAccount().valueOrNull;

      // Subscribe to account updates
      final subscription = await dappClient.subscribeCurrentAccount();

      await subscription.when(
        success: (success) async => update(
          (state) => state.copyWith(
            environment: environment,
            walletConnectionState:
                const awc.ArchethicDappConnectionState.connected(),
            error: '',
            genesisAddress:
                currentAccount?.genesisAddress ?? state.genesisAddress,
            nameAccount: currentAccount?.shortName ?? state.nameAccount,
            accountSub: success,
            accountStreamSub: success.updates.listen(
              (event) {
                update(
                  (state) => state.copyWith(
                    genesisAddress: event.genesisAddress,
                    nameAccount: event.name,
                  ),
                );
              },
            ),
          ),
        ),
        failure: (failure) async {
          state = state.copyWith(
            walletConnectionState:
                const awc.ArchethicDappConnectionState.disconnected(),
            error: failure.message,
          );
        },
      );
    } catch (e) {
      log('Error Wallet connection $e');
      _handleConnectionFailure();
    }
  }

  /// Handle failure during connection to wallet
  void _handleConnectionFailure() {
    update((state) {
      return state.copyWith(
        walletConnectionState:
            const awc.ArchethicDappConnectionState.disconnected(),
        error: 'Please, open your Archethic Wallet.',
      );
    });
  }

  /// Disconnect from the wallet
  Future<void> cancelConnection() async {
    state = state.copyWith(
      walletConnectionState:
          const awc.ArchethicDappConnectionState.disconnected(),
    );

    final dappClientAsync = ref.read(dappClientProvider);

    if (dappClientAsync is! AsyncData || dappClientAsync.value == null) {
      return Future.error('Wallet connection not ready or null');
    }

    await dappClientAsync.value!.close();
  }

  /// Helper to update the state
  Future<void> update(FutureOr<Session> Function(Session previous) func) async {
    state = await func(state);
  }
}
