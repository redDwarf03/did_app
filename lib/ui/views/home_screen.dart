import 'package:did_app/ui/common/widgets/menu_card.dart';
import 'package:did_app/ui/common/widgets/stats_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:go_router/go_router.dart';

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
                StatsItem(
                  icon: Icons.credit_card,
                  count: '3',
                  label: l10n.credentialsStatsLabel,
                ),
                StatsItem(
                  icon: Icons.security,
                  count: '1',
                  label: l10n.verifiedIdentityStatsLabel,
                ),
                StatsItem(
                  icon: Icons.share,
                  count: '5',
                  label: l10n.sharesStatsLabel,
                ),
              ],
            ),
          ],
        ),
      ),
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
        MenuCard(
          title: l10n.secureAuthMenuTitle,
          subtitle: l10n.secureAuthMenuDesc,
          icon: Icons.security,
          color: Colors.indigo,
          onTap: () => context.push('/secure_auth'),
        ),
        const SizedBox(height: 12),
        MenuCard(
          title: l10n.eidasInteropMenuTitle,
          subtitle: l10n.eidasInteropMenuDesc,
          icon: Icons.public,
          color: Colors.green,
          onTap: () => context.push('/eidas/interop'),
        ),
        const SizedBox(height: 12),
        MenuCard(
          title: l10n.credentialsMenuTitle,
          subtitle: l10n.credentialsMenuDesc,
          icon: Icons.credit_card,
          color: Colors.orange,
          onTap: () {}, // À implémenter
        ),
        const SizedBox(height: 12),
        MenuCard(
          title: l10n.statusListMenuTitle,
          subtitle: l10n.statusListMenuDesc,
          icon: Icons.verified_user,
          color: Colors.teal,
          onTap: () => context.push('/status_list/dashboard'),
        ),
        const SizedBox(height: 12),
        MenuCard(
          title: l10n.secureShareMenuTitle,
          subtitle: l10n.secureShareMenuDesc,
          icon: Icons.share,
          color: Colors.purple,
          onTap: () {}, // À implémenter
        ),
      ],
    );
  }
}
