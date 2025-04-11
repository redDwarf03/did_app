import 'package:did_app/application/session/provider.dart';
import 'package:did_app/ui/views/welcome/wallet_connection_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Welcome screen for the dApp
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archethic Digital Identity'),
        actions: const [
          // Wallet connection status in the app bar
          WalletConnectionStatus(),
          SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fingerprint,
              size: 80,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 24),
            const Text(
              'Archethic Digital Identity',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Secure, Sovereign, Compliant',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Show connect wallet button if not connected
            if (!ref.watch(sessionNotifierProvider).isConnected)
              ElevatedButton(
                onPressed:
                    ref.read(sessionNotifierProvider.notifier).connectWallet,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text('Connect Wallet'),
              ),
            // Show application content when connected
            if (ref.watch(sessionNotifierProvider).isConnected) ...[
              const Text(
                'You are connected to the Archethic wallet!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.badge),
                label: const Text('Manage Digital Identity'),
                onPressed: () {
                  context.go('/main/identity');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.shield),
                label: const Text('eIDAS Compliance'),
                onPressed: () {
                  // Will be implemented in future features
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
