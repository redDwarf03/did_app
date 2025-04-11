import 'package:did_app/application/session/provider.dart';
import 'package:did_app/ui/views/welcome/wallet_connection_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Welcome screen for the dApp
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.welcomeTitle),
        actions: const [
          // Wallet connection status in the app bar
          WalletConnectionStatus(),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.fingerprint,
                size: 80,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.welcomeScreenTitle,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.welcomeScreenSubtitle,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Introduction explaining digital identity for beginners
              _WelcomeInfoCard(
                title: l10n.digitalIdentityTitle,
                content: l10n.digitalIdentityDescription,
                icon: Icons.person,
              ),

              const SizedBox(height: 16),

              // EUDI Wallet explanation
              _WelcomeInfoCard(
                title: l10n.eudiWalletTitle,
                content: l10n.eudiWalletDescription,
                icon: Icons.euro_symbol,
              ),

              const SizedBox(height: 16),

              // eIDAS 2.0 explanation
              _WelcomeInfoCard(
                title: l10n.eidasTitle,
                content: l10n.eidasInteropDescription,
                icon: Icons.verified_user,
              ),

              const SizedBox(height: 16),

              // Self-Sovereign Identity explanation
              _WelcomeInfoCard(
                title: l10n.selfSovereignIdentityTitle,
                content: l10n.securityDescription,
                icon: Icons.account_balance,
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
                  child: Text(l10n.connectWallet),
                ),

              // Show application content when connected
              if (ref.watch(sessionNotifierProvider).isConnected) ...[
                Text(
                  l10n.connectedMessage,
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.badge),
                  label: Text(l10n.credentialsMenuTitle),
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
                  label: Text(l10n.eidasInteropMenuTitle),
                  onPressed: () {
                    // Navigate to eIDAS info screen
                    context.go('/credential/eidas-interop');
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.help_outline),
                  label: Text(l10n.beginnerHelpTooltip),
                  onPressed: () {
                    _showBeginnerGuide(context);
                  },
                ),
              ],

              const SizedBox(height: 40),

              // Quick start section for beginners
              if (ref.watch(sessionNotifierProvider).isConnected)
                const _QuickStartGuide(),
            ],
          ),
        ),
      ),
    );
  }

  void _showBeginnerGuide(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    l10n.tutorialTitle,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _buildGuideSection(
                  context,
                  l10n.tutorialPage1Title,
                  l10n.tutorialPage1Desc,
                  Icons.person_add,
                ),
                _buildGuideSection(
                  context,
                  l10n.tutorialPage2Title,
                  l10n.tutorialPage2Desc,
                  Icons.upload_file,
                ),
                _buildGuideSection(
                  context,
                  l10n.tutorialPage3Title,
                  l10n.tutorialPage3Desc,
                  Icons.shield,
                ),
                _buildGuideSection(
                  context,
                  l10n.tutorialPage4Title,
                  l10n.tutorialPage4Desc,
                  Icons.security,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(l10n.gotItButton),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGuideSection(
      BuildContext context, String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget d'information avec titre, contenu et icône
class _WelcomeInfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _WelcomeInfoCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

/// Guide de démarrage rapide pour les débutants
class _QuickStartGuide extends StatelessWidget {
  const _QuickStartGuide();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickGuideButton,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildQuickStartItem(
          context,
          l10n.tutorialPage1Title,
          l10n.tutorialPage1Desc,
          Icons.person_add,
          '/main/identity',
        ),
        _buildQuickStartItem(
          context,
          l10n.tutorialPage2Title,
          l10n.tutorialPage2Desc,
          Icons.badge,
          '/credential/list',
        ),
        _buildQuickStartItem(
          context,
          l10n.tutorialPage3Title,
          l10n.tutorialPage3Desc,
          Icons.share,
          '/credential/presentation',
        ),
      ],
    );
  }

  Widget _buildQuickStartItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String route,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => context.go(route),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    );
  }
}
