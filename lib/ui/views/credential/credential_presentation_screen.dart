import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/providers/credential_presentation_provider.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialPresentationTitle),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(credentialPresentationProvider);

          return Column(
            children: [
              // Bannière explicative pour débutants
              const _BeginnerInfoBox(),

              Expanded(
                child: state.loading
                    ? _buildLoadingState(context)
                    : _buildContent(context, ref),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            l10n.verificationInProgress,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.credentialPresentationTitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          // Liste des attestations
          ..._credentials
              .map(_buildCredentialSection),
          const SizedBox(height: 24),
          // Section prédicat (si affichée)
          if (_usePredicate) _buildPredicatesSection(),
          const SizedBox(height: 24),
          // Message facultatif
          _buildMessageSection(),
          const SizedBox(height: 32),
          // Actions en bas d'écran
          _buildActionButtons(context, ref),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.credentialPresentationTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.selectiveDisclosureDescription,
          style: const TextStyle(color: Colors.grey),
        ),
        if (_credentials.any((c) => c.supportsZkp))
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SwitchListTile(
              title: Text(l10n.beginnerZkpTitle),
              subtitle: Text(
                l10n.selectiveDisclosureDescription,
                style: const TextStyle(fontSize: 12),
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
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              l10n.noEidasCompatibleCredentials,
              style: const TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildCredentialSection(Credential credential) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
                      _getCredentialTypeFromList(credential.type),),
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    credential.name ?? l10n.defaultCredentialName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (credential.supportsZkp)
                  Tooltip(
                    message: l10n.beginnerZkpTitle,
                    child: Icon(
                      Icons.lock,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),
            Text(
              l10n.selectiveDisclosureDescription,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                          attr,
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
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
                    l10n.beginnerZkpTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  tooltip: l10n.addCredentialButton,
                  onPressed: () {
                    // Pour la démo, on ajoute un prédicat factice
                    setState(() {
                      // Trouver une attestation qui supporte ZKP
                      final credential = _credentials.firstWhere(
                        (c) => c.supportsZkp,
                        orElse: () => _credentials.first,
                      );

                      // Trouver un attribut numérique
                      final numericAttr = _getNumericAttribute(credential);

                      if (numericAttr != null) {
                        final predicate = CredentialPredicate(
                          credentialId: credential.id,
                          attribute: numericAttr,
                          attributeName: numericAttr,
                          predicate: '>',
                          predicateType: PredicateType.greaterThan,
                          value: 18,
                        );
                        _predicates.add(predicate);
                      }
                    });
                  },
                ),
              ],
            ),
            const Divider(height: 24),
            if (_predicates.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    l10n.noCredentials,
                    style: const TextStyle(fontStyle: FontStyle.italic),
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
            Text(
              l10n.beginnerZkpMessage,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageSection() {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.credentialTypeLabel,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: l10n.howToUseCredentialContent,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check_circle),
          label: Text(l10n.createPresentationButton),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onPressed: _isGenerating ? null : () => _generatePresentation(ref),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          icon: const Icon(Icons.cancel),
          label: Text(l10n.closeButton),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Future<void> _generatePresentation(WidgetRef ref) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    setState(() {
      _isGenerating = true;
      _errorMessage = null;
    });

    try {
      // Dans une implémentation réelle, nous utiliserions le provider pour générer
      // une présentation avec les attributs sélectionnés
      await Future.delayed(const Duration(seconds: 2)); // Simuler un délai

      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _errorMessage = l10n.errorOccurredMessage(e.toString());
      });
    } finally {
      setState(() {
        _isGenerating = false;
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
      case CredentialType.medicalCertificate:
        return Icons.local_hospital;
      case CredentialType.professionalBadge:
        return Icons.badge;
      case CredentialType.other:
      default:
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
    } else if (types.contains('MedicalCertificateCredential')) {
      return CredentialType.medicalCertificate;
    } else if (types.contains('ProfessionalBadgeCredential')) {
      return CredentialType.professionalBadge;
    } else {
      return CredentialType.other;
    }
  }

  String _getPredicateDescription(CredentialPredicate predicate) {
    return '${predicate.predicateType.humanReadable} ${predicate.value}';
  }

  String? _getNumericAttribute(Credential credential) {
    if (credential.claims != null) {
      for (final key in credential.claims!.keys) {
        if (credential.claims![key] is num ||
            (credential.claims![key] is String &&
                int.tryParse(credential.claims![key] as String) != null)) {
          return key;
        }
      }
    }
    return null;
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
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialPresentationTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.verificationResult,
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
                        size: 150, color: Colors.black87,)
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
              title: l10n.generalInformationSection,
              children: [
                _buildInfoRow(l10n.credentialTypeLabel,
                    '${presentation.verifiableCredentials.length}',),
                _buildInfoRow(l10n.documentTypeLabel,
                    '${presentation.revealedAttributes.length ?? 0}',),
                if (presentation.verifiableCredentials.isNotEmpty)
                  _buildInfoRow(l10n.credentialsSection,
                      '${presentation.verifiableCredentials.length}',),
                _buildInfoRow(l10n.createdLabel,
                    _formatDate(presentation.created ?? DateTime.now()),),
              ],
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInfoCard(
                context,
                title: l10n.understandCredentialTitle,
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
              l10n.onlySelectedInfoShared,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.check),
              label: Text(l10n.comprehendButton),
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

/// Panneau d'explication pour les débutants sur la divulgation sélective
class _BeginnerInfoBox extends StatefulWidget {
  const _BeginnerInfoBox();

  @override
  State<_BeginnerInfoBox> createState() => _BeginnerInfoBoxState();
}

class _BeginnerInfoBoxState extends State<_BeginnerInfoBox> {
  bool _expanded = false;
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    if (_dismissed) return const SizedBox.shrink();

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
                    l10n.selectiveDisclosureDescription,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  tooltip: _expanded
                      ? l10n.closeButtonTooltip
                      : l10n.aboutCredentialsTooltip,
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () {
                    setState(() {
                      _dismissed = true;
                    });
                  },
                  tooltip: l10n.closeButtonTooltip,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.howToUseCredentialContent,
            ),
            if (_expanded) ...[
              const SizedBox(height: 16),
              Text(
                l10n.understandCredentialTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                l10n.beginnerZkpMessage,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.play_circle_outline),
                label: Text(l10n.beginnerZkpTitle),
                onPressed: () => _showZkpExplanation(context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _showZkpExplanation(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.beginnerZkpTitle),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildExplanationWithImage(
                  l10n.beginnerZkpMessage,
                ),
                const SizedBox(height: 16),
                _buildExplanationWithImage(
                  l10n.tutorialPage3Desc,
                  imageName: 'zkp_example.png',
                ),
                const SizedBox(height: 16),
                const Text(
                  "C'est comme prouver que vous connaissez le code d'un coffre-fort sans révéler le code lui-même.",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.selectiveDisclosureDescription,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.comprehendButton),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExplanationWithImage(String text, {String? imageName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        if (imageName != null) ...[
          const SizedBox(height: 8),
          Center(
            child: Image.asset(
              'assets/images/$imageName',
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback icon if image is not available
                return Icon(
                  Icons.privacy_tip,
                  size: 80,
                  color: Colors.blue.shade200,
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
