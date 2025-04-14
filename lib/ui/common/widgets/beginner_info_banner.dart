import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Bannière d'information pour les débutants
class BeginnerInfoBanner extends StatelessWidget {
  const BeginnerInfoBanner({required this.onDismiss, super.key});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.amber.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.welcomeTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: onDismiss,
                  tooltip: l10n.closeButtonTooltip,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.aboutDigitalCredentialsInfo1,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.play_circle_outline),
                    label: Text(l10n.quickGuideButton),
                    onPressed: () => _showTutorial(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Affiche un tutoriel rapide sur les attestations
  void _showTutorial(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.tutorialTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTutorialStep(
                context,
                l10n.tutorialPage1Title,
                l10n.tutorialPage1Desc,
                Icons.category,
              ),
              const SizedBox(height: 16),
              _buildTutorialStep(
                context,
                l10n.tutorialPage2Title,
                l10n.tutorialPage2Desc,
                Icons.visibility,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialStep(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(content),
            ],
          ),
        ),
      ],
    );
  }
}
