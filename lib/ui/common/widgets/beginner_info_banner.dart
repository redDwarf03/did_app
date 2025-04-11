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
                const Expanded(
                  child: Text(
                    'Bienvenue dans vos attestations numériques',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: onDismiss,
                  tooltip: 'Fermer',
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Les attestations numériques sont l'équivalent digital de vos documents d'identité, diplômes, permis et autres certifications.",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Utiliser vos attestations numériques',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  children: [
                    _buildTutorialPage(
                      'Vos attestations sont classées par type',
                      "Vous pouvez retrouver rapidement vos pièces d'identité, diplômes, permis et autres documents. Appuyez sur les onglets pour passer d'une catégorie à l'autre.",
                      Icons.category,
                    ),
                    _buildTutorialPage(
                      "Consultez les détails d'une attestation",
                      "Appuyez sur une attestation pour voir toutes les informations qu'elle contient, sa date d'expiration et son statut.",
                      Icons.description,
                    ),
                    _buildTutorialPage(
                      'Partagez de façon sécurisée',
                      'Vous pouvez créer une "présentation" qui vous permet de partager uniquement les informations que vous choisissez. Par exemple, prouver que vous avez plus de 18 ans sans révéler votre date de naissance complète.',
                      Icons.share,
                    ),
                    _buildTutorialPage(
                      'Conformité eIDAS 2.0',
                      "Les attestations avec le symbole € sont reconnues dans toute l'Union Européenne grâce au règlement eIDAS 2.0.",
                      Icons.verified_user,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("J'ai compris"),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Construit une page de tutoriel
  Widget _buildTutorialPage(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.blue),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Glissez pour voir la suite →',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
