import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Écran d'accueil de l'application
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.identityWalletTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeaderCard(context),
          const SizedBox(height: 24),
          _buildMenuSection(context),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.welcomeBack,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.manageYourIdentitySecurely,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatsItem(
                  context,
                  Icons.credit_card,
                  '3',
                  l10n.credentialsStatsLabel,
                ),
                _buildStatsItem(
                  context,
                  Icons.security,
                  '1',
                  l10n.verifiedIdentityStatsLabel,
                ),
                _buildStatsItem(
                  context,
                  Icons.share,
                  '5',
                  l10n.sharesStatsLabel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsItem(
    BuildContext context,
    IconData icon,
    String count,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            l10n.featuresSectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildMenuCard(
          context,
          l10n.secureAuthMenuTitle,
          l10n.secureAuthMenuDesc,
          Icons.security,
          Colors.indigo,
          () => context.push('/secure_auth'),
        ),
        const SizedBox(height: 12),
        _buildMenuCard(
          context,
          l10n.eidasInteropMenuTitle,
          l10n.eidasInteropMenuDesc,
          Icons.public,
          Colors.green,
          () => context.push('/eidas/interop'),
        ),
        const SizedBox(height: 12),
        _buildMenuCard(
          context,
          l10n.credentialsMenuTitle,
          l10n.credentialsMenuDesc,
          Icons.credit_card,
          Colors.orange,
          () {}, // À implémenter
        ),
        const SizedBox(height: 12),
        _buildMenuCard(
          context,
          l10n.statusListMenuTitle,
          l10n.statusListMenuDesc,
          Icons.verified_user,
          Colors.teal,
          () => context.push('/status_list/dashboard'),
        ),
        const SizedBox(height: 12),
        _buildMenuCard(
          context,
          l10n.secureShareMenuTitle,
          l10n.secureShareMenuDesc,
          Icons.share,
          Colors.purple,
          () {}, // À implémenter
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
