import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';

/// Configuration class for Archethic blockchain environments
class ArchethicConfig {
  /// Get the endpoint URL for the given environment
  static String getEndpoint(Environment env) => switch (env) {
        Environment.mainnet => 'https://mainnet.archethic.net',
        Environment.testnet => 'https://testnet.archethic.net',
        Environment.devnet => 'https://devnet.archethic.net',
      };

  /// Get the explorer URL for the given environment
  static String getExplorerUrl(Environment env) => switch (env) {
        Environment.mainnet => 'https://mainnet.archethic.net/explorer',
        Environment.testnet => 'https://testnet.archethic.net/explorer',
        Environment.devnet => 'https://devnet.archethic.net/explorer',
      };

  /// Generate a transaction URL for the explorer
  static String getTransactionUrl(Environment env, String address) =>
      '${getExplorerUrl(env)}/transaction/$address';

  /// Generate an address URL for the explorer
  static String getAddressUrl(Environment env, String address) =>
      '${getExplorerUrl(env)}/chain/$address';
}
