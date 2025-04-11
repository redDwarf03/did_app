import 'package:did_app/application/session/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Widget displaying the current wallet connection status
class WalletConnectionStatus extends ConsumerWidget {
  const WalletConnectionStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    // If not connected, show a connect button
    if (!session.isConnected) {
      return TextButton(
        onPressed: ref.read(sessionNotifierProvider.notifier).connectWallet,
        child: Text(
          l10n.connectWalletStatusButton,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }

    // If connected, show account information and a disconnect button
    return Row(
      children: [
        // Account info
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              session.nameAccount,
              style: const TextStyle(fontSize: 14),
            ),
            // Display genesis address with truncation
            Text(
              _formatAddress(session.genesisAddress),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 8),
        // Disconnect button
        IconButton(
          icon: const Icon(Icons.logout),
          iconSize: 18,
          onPressed:
              ref.read(sessionNotifierProvider.notifier).cancelConnection,
          tooltip: l10n.disconnectWalletTooltip,
        ),
      ],
    );
  }

  /// Format an address to display only the first and last characters
  String _formatAddress(String address) {
    if (address.length < 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }
}
