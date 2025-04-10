import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dapp_client.g.dart';

/// Provider for the Archethic DApp client
@riverpod
Future<awc.ArchethicDAppClient> dappClient(Ref ref) async {
  // Create a new connection to the Archethic wallet
  final client = await awc.ArchethicDAppClient.auto(
    origin: const awc.RequestOrigin(name: 'Archethic dApp Template'),
    replyBaseUrl: '',
    authorizedMethods: [
      awc.ArchethicDAppTransportMethods.webBrowserExtension,
      awc.ArchethicDAppTransportMethods.websocket,
      awc.ArchethicDAppTransportMethods.messageChannel,
    ],
  );

  // Close the client when the provider is disposed
  ref.onDispose(client.close);

  return client;
}
