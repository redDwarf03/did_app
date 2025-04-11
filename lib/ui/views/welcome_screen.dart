import 'package:did_app/ui/common/widgets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.welcomeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.security,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.digitalIdWalletTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.secureIdManagement,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            MenuCard(
              title: l10n.secureAuthFeatureTitle,
              subtitle: l10n.secureAuthFeatureDesc,
              icon: Icons.fingerprint,
              color: Colors.indigo,
              onTap: () => context.push('/login'),
            ),
            const SizedBox(height: 16),
            MenuCard(
              title: l10n.eidasInteropFeatureTitle,
              subtitle: l10n.eidasInteropFeatureDesc,
              icon: Icons.public,
              color: Colors.green,
              onTap: () => context.push('/eidas/interop'),
            ),
            const SizedBox(height: 16),
            MenuCard(
              title: l10n.appExplorerFeatureTitle,
              subtitle: l10n.appExplorerFeatureDesc,
              icon: Icons.apps,
              color: Colors.orange,
              onTap: () => context.push('/home'),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () => connectToWallet(context, l10n),
              icon: const Icon(Icons.wallet),
              label: Text(l10n.connectToWalletButton),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void connectToWallet(BuildContext context, AppLocalizations l10n) {
    // Implémentation pour se connecter au wallet d'Archethic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.connectingToWalletMessage),
      ),
    );
  }
}
