import 'package:did_app/ui/common/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran d'information sur le standard Status List 2021
class StatusList2021InfoScreen extends ConsumerWidget {
  const StatusList2021InfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statusList2021InfoTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, l10n),
            const SizedBox(height: 24),
            _buildIntroductionSection(context, l10n),
            const SizedBox(height: 32),
            _buildHowItWorksSection(context, l10n),
            const SizedBox(height: 32),
            _buildBenefitsSection(context, l10n),
            const SizedBox(height: 32),
            _buildImplementationSection(context, l10n),
            const SizedBox(height: 32),
            _buildFaqSection(context, l10n),
            const SizedBox(height: 32),
            _buildResourcesSection(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user,
              size: 64,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Status List 2021',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            l10n.standardByW3C,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildIntroductionSection(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.introductionTitle),
        const SizedBox(height: 16),
        Text(
          l10n.statusList2021IntroductionP1,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        Text(
          l10n.statusList2021IntroductionP2,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        Text(
          l10n.statusList2021IntroductionP3,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildHowItWorksSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.howItWorksTitle),
        const SizedBox(height: 16),
        _buildProcessStep(
          context,
          '1',
          l10n.statusList2021HowItWorksStep1Title,
          l10n.statusList2021HowItWorksStep1Desc,
          Icons.create_new_folder,
        ),
        _buildProcessStep(
          context,
          '2',
          l10n.statusList2021HowItWorksStep2Title,
          l10n.statusList2021HowItWorksStep2Desc,
          Icons.format_list_numbered,
        ),
        _buildProcessStep(
          context,
          '3',
          l10n.statusList2021HowItWorksStep3Title,
          l10n.statusList2021HowItWorksStep3Desc,
          Icons.link,
        ),
        _buildProcessStep(
          context,
          '4',
          l10n.statusList2021HowItWorksStep4Title,
          l10n.statusList2021HowItWorksStep4Desc,
          Icons.verified_user,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildProcessStep(
    BuildContext context,
    String stepNumber,
    String title,
    String description,
    IconData icon, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  stepNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.benefitsTitle),
        const SizedBox(height: 16),
        _buildBenefitItem(
          context,
          Icons.privacy_tip,
          l10n.privacyBenefitTitle,
          l10n.privacyBenefitDesc,
        ),
        _buildBenefitItem(
          context,
          Icons.speed,
          l10n.efficiencyBenefitTitle,
          l10n.efficiencyBenefitDesc,
        ),
        _buildBenefitItem(
          context,
          Icons.cloud_download,
          l10n.scalabilityBenefitTitle,
          l10n.scalabilityBenefitDesc,
        ),
        _buildBenefitItem(
          context,
          Icons.handshake,
          l10n.interoperabilityBenefitTitle,
          l10n.interoperabilityBenefitDesc,
        ),
      ],
    );
  }

  Widget _buildBenefitItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImplementationSection(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.implementationTitle),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.bitStringEncodingTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.bitStringEncodingDesc,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  l10n.credentialStatusTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.credentialStatusDesc,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '''
{
  "id": "https://example.com/credentials/123#revocation",
  "type": "StatusList2021Entry",
  "statusPurpose": "revocation",
  "statusListIndex": "94",
  "statusListCredential": "https://example.com/status/3"
}''',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFaqSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.faqTitle),
        const SizedBox(height: 16),
        _buildFaqItem(
          context,
          l10n.faqQuestion1,
          l10n.faqAnswer1,
        ),
        _buildFaqItem(
          context,
          l10n.faqQuestion2,
          l10n.faqAnswer2,
        ),
        _buildFaqItem(
          context,
          l10n.faqQuestion3,
          l10n.faqAnswer3,
        ),
        _buildFaqItem(
          context,
          l10n.faqQuestion4,
          l10n.faqAnswer4,
        ),
      ],
    );
  }

  Widget _buildFaqItem(
    BuildContext context,
    String question,
    String answer,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(answer),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourcesSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.resourcesTitle),
        const SizedBox(height: 16),
        _buildResourceItem(
          context,
          'W3C Status List 2021',
          'https://w3c.github.io/vc-status-list-2021/',
          Icons.description,
        ),
        _buildResourceItem(
          context,
          'Verifiable Credentials Data Model',
          'https://www.w3.org/TR/vc-data-model/',
          Icons.book,
        ),
        _buildResourceItem(
          context,
          'Status List 2021 GitHub Repository',
          'https://github.com/w3c/vc-status-list-2021',
          Icons.code,
        ),
        _buildResourceItem(
          context,
          'DIF Documentation',
          'https://identity.foundation/status-list/',
          Icons.fact_check,
        ),
      ],
    );
  }

  Widget _buildResourceItem(
    BuildContext context,
    String title,
    String url,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: Text(
          url,
          style: TextStyle(color: Colors.blue.shade700),
        ),
        trailing: const Icon(Icons.open_in_new),
        onTap: () {
          // Ouvrir l'URL (à implémenter)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Ouverture de l'URL non implémentée"),
            ),
          );
        },
      ),
    );
  }
}
