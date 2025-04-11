import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran pour la présentation sélective d'attributs avec ZKP
class CredentialPresentationScreen extends ConsumerStatefulWidget {
  const CredentialPresentationScreen({
    super.key,
    required this.credentialIds,
  });

  /// IDs des attestations à présenter
  final List<String> credentialIds;

  @override
  ConsumerState<CredentialPresentationScreen> createState() =>
      _CredentialPresentationScreenState();
}

class _CredentialPresentationScreenState
    extends ConsumerState<CredentialPresentationScreen> {
  // État local
  final Map<String, List<String>> _selectedAttributes = {};
  final List<CredentialPredicate> _predicates = [];
  final TextEditingController _messageController = TextEditingController();
  bool _isGenerating = false;
  bool _usePredicate = false;
  String? _errorMessage;

  // Récupérer les attestations correspondantes
  List<Credential> get _credentials {
    final allCredentials = ref.read(credentialNotifierProvider).credentials;
    return allCredentials
        .where((cred) => widget.credentialIds.contains(cred.id))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    // Initialiser les attributs sélectionnés
    _initSelectedAttributes();
  }

  void _initSelectedAttributes() {
    for (final credential in _credentials) {
      // Présélectionner les attributs courants (nom, prénom, etc.)
      final defaultAttrs = <String>[];
      if (credential.claims?.containsKey('firstName') ?? false) {
        defaultAttrs.add('firstName');
      }
      if (credential.claims?.containsKey('lastName') ?? false) {
        defaultAttrs.add('lastName');
      }
      if (defaultAttrs.isNotEmpty) {
        _selectedAttributes[credential.id] = defaultAttrs;
      } else {
        // Si pas d'attributs courants, présélectionner le premier
        final keys = credential.claims?.keys.toList() ?? [];
        if (keys.isNotEmpty) {
          _selectedAttributes[credential.id] = [keys.first];
        } else {
          _selectedAttributes[credential.id] = [];
        }
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Présentation sélective'),
      ),
      body: _isGenerating
          ? _buildLoadingState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  ..._credentials.map(_buildCredentialSection).toList(),
                  if (_usePredicate && _credentials.isNotEmpty)
                    _buildPredicatesSection(),
                  const SizedBox(height: 16),
                  _buildMessageSection(),
                  if (_errorMessage != null) _buildErrorMessage(),
                  const SizedBox(height: 24),
                  _buildActions(),
                ],
              ),
            ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 24),
          Text(
            'Génération de la présentation...',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Création des preuves cryptographiques',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Présentation sélective d\'attributs',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'Sélectionnez les attributs que vous souhaitez partager. Vous pouvez '
          'également créer des preuves sans révéler les valeurs exactes.',
          style: TextStyle(color: Colors.grey),
        ),
        if (_credentials.any((c) => c.supportsZkp))
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SwitchListTile(
              title: const Text('Utiliser des prédicats (ZKP)'),
              subtitle: const Text(
                'Prouver une condition sans révéler la valeur exacte',
                style: TextStyle(fontSize: 12),
              ),
              value: _usePredicate,
              onChanged: (value) {
                setState(() {
                  _usePredicate = value;
                });
              },
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Les attestations sélectionnées ne supportent pas les preuves à '
              'divulgation nulle de connaissance (ZKP).',
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildCredentialSection(Credential credential) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getCredentialTypeIcon(
                      _getCredentialTypeFromList(credential.type)),
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    credential.name ?? 'Attestation',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (credential.supportsZkp)
                  Tooltip(
                    message: 'Supporte la preuve à divulgation nulle',
                    child: Icon(
                      Icons.lock,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),
            const Text(
              'Attributs à partager:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...(credential.claims?.keys ?? []).map((attr) {
              final selectedAttrs = _selectedAttributes[credential.id] ?? [];
              return CheckboxListTile(
                title: Text(attr),
                subtitle: Text(
                  credential.claims?[attr]?.toString() ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
                value: selectedAttrs.contains(attr),
                dense: true,
                onChanged: (selected) {
                  setState(() {
                    if (selected == true) {
                      if (!selectedAttrs.contains(attr)) {
                        _selectedAttributes[credential.id] = [
                          ...selectedAttrs,
                          attr
                        ];
                      }
                    } else {
                      _selectedAttributes[credential.id] =
                          selectedAttrs.where((item) => item != attr).toList();
                    }
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPredicatesSection() {
    // Dans une implémentation réelle, cette section permettrait de créer des prédicats
    // pour des preuves à divulgation nulle de connaissance
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.privacy_tip,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Prédicats (ZKP)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  tooltip: 'Ajouter un prédicat',
                  onPressed: () {
                    // Pour la démo, on ajoute un prédicat factice
                    setState(() {
                      // Trouver une attestation qui supporte ZKP
                      final credential = _credentials.firstWhere(
                        (c) => c.supportsZkp,
                        orElse: () => _credentials.first,
                      );

                      // Trouver un attribut numérique
                      String? numericAttr;
                      credential.claims?.forEach((key, value) {
                        if (value is num ||
                            value is String && int.tryParse(value) != null) {
                          numericAttr = key;
                        }
                      });

                      if (numericAttr != null) {
                        _predicates.add(
                          CredentialPredicate(
                            attributeName: numericAttr!,
                            predicateType: PredicateType.greaterThan,
                            value: 18,
                          ),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
            const Divider(height: 24),
            if (_predicates.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Aucun prédicat ajouté',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            else
              Column(
                children: _predicates.map((predicate) {
                  return ListTile(
                    title: Text(predicate.attributeName),
                    subtitle: Text(
                      _getPredicateDescription(predicate),
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _predicates.remove(predicate);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(height: 8),
            const Text(
              'Note: Les prédicats permettent de prouver une condition (par exemple, "âge > 18") '
              'sans révéler la valeur exacte de l\'attribut.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Message au destinataire',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message (optionnel)',
                hintText:
                    'Ex: Voici les informations demandées pour ma candidature',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        const SizedBox(width: 16),
        FilledButton.icon(
          onPressed: _generatePresentation,
          icon: const Icon(Icons.send),
          label: const Text('Générer la présentation'),
        ),
      ],
    );
  }

  Future<void> _generatePresentation() async {
    // Vérifier que des attributs ont été sélectionnés
    bool hasAttributes = false;
    for (final attrs in _selectedAttributes.values) {
      if (attrs.isNotEmpty) {
        hasAttributes = true;
        break;
      }
    }

    if (!hasAttributes && _predicates.isEmpty) {
      setState(() {
        _errorMessage =
            'Veuillez sélectionner au moins un attribut ou ajouter un prédicat';
      });
      return;
    }

    setState(() {
      _isGenerating = true;
      _errorMessage = null;
    });

    try {
      // Récupérer l'identité
      final identity = ref.read(identityNotifierProvider).identity;
      if (identity == null) {
        throw Exception('Identité non disponible');
      }

      // Créer la présentation
      final presentation = await ref
          .read(credentialNotifierProvider.notifier)
          .createPresentation(
            credentialIds: widget.credentialIds,
            revealedAttributes: _selectedAttributes,
            predicates: _predicates.isEmpty ? null : _predicates,
          );

      // Générer un lien pour la présentation
      String? link;
      if (presentation != null) {
        link = await ref
            .read(credentialNotifierProvider.notifier)
            .sharePresentation(presentation.id);
      }

      // Réinitialiser l'état et naviguer vers la page de résultat
      setState(() {
        _isGenerating = false;
      });

      if (context.mounted && presentation != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PresentationResultScreen(
              presentation: presentation,
              link: link,
              message: _messageController.text,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isGenerating = false;
        _errorMessage = 'Erreur lors de la génération: $e';
      });
    }
  }

  // Méthodes utilitaires
  IconData _getCredentialTypeIcon(CredentialType type) {
    switch (type) {
      case CredentialType.identity:
        return Icons.person;
      case CredentialType.diploma:
        return Icons.school;
      case CredentialType.drivingLicense:
        return Icons.directions_car;
      case CredentialType.ageVerification:
        return Icons.cake;
      case CredentialType.addressProof:
        return Icons.home;
      case CredentialType.employmentProof:
        return Icons.work;
      case CredentialType.membershipCard:
        return Icons.card_membership;
      case CredentialType.healthInsurance:
        return Icons.medical_services;
      case CredentialType.other:
        return Icons.badge;
    }
  }

  CredentialType _getCredentialTypeFromList(List<String> types) {
    if (types.contains('IdentityCredential')) {
      return CredentialType.identity;
    } else if (types.contains('UniversityDegreeCredential')) {
      return CredentialType.diploma;
    } else if (types.contains('HealthInsuranceCredential')) {
      return CredentialType.healthInsurance;
    } else if (types.contains('EmploymentCredential')) {
      return CredentialType.employmentProof;
    } else if (types.contains('DrivingLicenseCredential')) {
      return CredentialType.drivingLicense;
    } else if (types.contains('AgeVerificationCredential')) {
      return CredentialType.ageVerification;
    } else if (types.contains('AddressProofCredential')) {
      return CredentialType.addressProof;
    } else if (types.contains('MembershipCardCredential')) {
      return CredentialType.membershipCard;
    } else {
      return CredentialType.other;
    }
  }

  String _getPredicateDescription(CredentialPredicate predicate) {
    switch (predicate.predicateType) {
      case PredicateType.greaterThan:
        return '> ${predicate.value}';
      case PredicateType.greaterThanOrEqual:
        return '≥ ${predicate.value}';
      case PredicateType.lessThan:
        return '< ${predicate.value}';
      case PredicateType.lessThanOrEqual:
        return '≤ ${predicate.value}';
      case PredicateType.equal:
        return '= ${predicate.value}';
    }
  }
}

/// Écran affichant le résultat de la génération d'une présentation
class PresentationResultScreen extends StatelessWidget {
  const PresentationResultScreen({
    super.key,
    required this.presentation,
    this.link,
    this.message,
  });

  final CredentialPresentation presentation;
  final String? link;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Présentation générée'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Présentation générée avec succès',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // QR Code - Dans une implémentation réelle, on utiliserait qr_flutter
            // Pour le prototype, on montre juste un placeholder
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: link != null
                    ? const Icon(Icons.qr_code,
                        size: 150, color: Colors.black87)
                    : const Icon(Icons.error, size: 64, color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            if (link != null)
              Text(
                'Lien: $link',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 32),
            _buildInfoCard(
              context,
              title: 'Informations partagées',
              children: [
                _buildInfoRow('Nombre d\'attestations',
                    '${presentation.verifiableCredentials.length}'),
                _buildInfoRow('Attributs révélés',
                    '${presentation.revealedAttributes?.length ?? 0}'),
                if (presentation.predicates != null &&
                    presentation.predicates!.isNotEmpty)
                  _buildInfoRow(
                      'Prédicats', '${presentation.predicates!.length}'),
                _buildInfoRow('Créée le',
                    _formatDate(presentation.created ?? DateTime.now())),
              ],
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInfoCard(
                context,
                title: 'Message',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(message!),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 32),
            Text(
              'Partagez ce QR code ou ce lien avec le destinataire',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.check),
              label: const Text('Terminé'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }
}
