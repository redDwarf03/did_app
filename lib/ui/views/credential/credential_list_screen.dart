import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/ui/common/utils/dialog_utils.dart';
import 'package:did_app/ui/common/widgets/beginner_info_banner.dart';
import 'package:did_app/ui/common/widgets/empty_state_widget.dart';
import 'package:did_app/ui/views/credential/add_credential_screen.dart';
import 'package:did_app/ui/views/credential/eidas_interop_screen.dart';
import 'package:did_app/ui/views/credential/widgets/credential_card.dart';
import 'package:did_app/ui/views/credential/widgets/request_credential_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Écran affichant les attestations (Verifiable Credentials) de l'utilisateur
class CredentialListScreen extends ConsumerStatefulWidget {
  const CredentialListScreen({super.key});

  @override
  ConsumerState<CredentialListScreen> createState() =>
      _CredentialListScreenState();
}

class _CredentialListScreenState extends ConsumerState<CredentialListScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les attestations au démarrage
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity != null) {
      await ref.read(credentialNotifierProvider.notifier).loadCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    final credentialState = ref.watch(credentialNotifierProvider);
    final identityState = ref.watch(identityNotifierProvider);
    final hasIdentity = identityState.identity != null;
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    if (identityState.identity == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.credentialListTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: EmptyStateWidget(
          icon: Icons.account_circle_outlined,
          title: l10n.identityRequired,
          message: l10n.identityRequiredMessage,
          actionButton: ElevatedButton(
            onPressed: () => context.pushNamed('createIdentity'),
            child: Text(l10n.createIdentityButton),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCredentialScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: l10n.aboutCredentialsTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.euro),
            tooltip: l10n.eidasInteroperabilityTooltip,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EidasInteropScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refreshTooltip,
            onPressed: _loadCredentials,
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed:
                credentialState.isLoading ? null : () => _scanQRCode(context),
            tooltip: l10n.scanQrCodeTooltip,
          ),
        ],
      ),
      body: Column(
        children: [
          // Bandeau d'information pour débutants
          if (_isFirstVisit(ref))
            BeginnerInfoBanner(
              onDismiss: () => _markAsVisited(ref),
            ),

          // Filtres des attestations
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: credentialState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCredentialList(context, credentialState),
          ),
        ],
      ),
      // Bouton pour demander une nouvelle attestation
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'request',
            onPressed: () => _showRequestCredentialDialog(context),
            label: Text(l10n.requestButton),
            icon: const Icon(Icons.add_card),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            heroTag: 'present',
            onPressed: () => _showPresentCredentialDialog(context),
            label: Text(l10n.presentButton),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildCredentialList(BuildContext context, CredentialState state) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    if (state.credentials.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.badge_outlined,
        title: l10n.noCredentials,
        message: l10n.noCredentialsMessage,
        actionButton: ElevatedButton.icon(
          onPressed: () => _showRequestCredentialDialog(context),
          icon: const Icon(Icons.add_card),
          label: Text(l10n.requestCredentialButton),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.credentials.length,
      itemBuilder: (context, index) {
        final credential = state.credentials[index];
        return CredentialCard(
          credential: credential,
          compact: true,
          onTap: () => _openCredentialDetails(context, credential),
          onPresent: () => _presentCredential(context, credential),
          onVerify: () => _verifyCredential(context, credential),
          onDelete: () => _confirmDeleteCredential(context, credential),
        );
      },
    );
  }

  // Ouvrir les détails d'une attestation
  void _openCredentialDetails(BuildContext context, Credential credential) {
    // Navigate to credential details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CredentialDetailScreen(credentialId: credential.id),
      ),
    );
  }

  // Présenter une attestation
  Future<void> _presentCredential(
      BuildContext context, Credential credential,) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    // Ici, on afficherait une interface permettant de créer une présentation sélective
    // puis de générer un QR code ou un lien pour partager cette présentation

    // Pour le prototype, on montre simplement un dialog avec un QR fictif
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.credentialPresentationTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'QR Code de présentation générée',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.qr_code, size: 150, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Seules les informations sélectionnées seront partagées',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Vérifier une attestation
  Future<void> _verifyCredential(
      BuildContext context, Credential credential,) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    // Montrer un indicateur de chargement
    await DialogUtils.showLoadingDialog(context, l10n.verifyingMessage);

    try {
      // Vérifier l'authenticité
      final isValid = await ref
          .read(credentialNotifierProvider.notifier)
          .verifyCredential(credential.id);

      // Fermer le dialogue de chargement
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Afficher le résultat
      if (context.mounted) {
        await DialogUtils.showResultDialog(
          context: context,
          title: l10n.verificationResultTitle,
          content: isValid
              ? l10n.verificationSuccessMessage
              : l10n.verificationFailureMessage,
          isSuccess: isValid,
          closeText: l10n.closeButton,
        );
      }
    } catch (e) {
      // Fermer le dialogue de chargement
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Afficher l'erreur
      if (context.mounted) {
        await DialogUtils.showErrorDialog(
          context: context,
          title: l10n.errorDialogTitle,
          content: l10n.genericErrorMessage(e.toString()),
          closeText: l10n.closeButton,
        );
      }
    }
  }

  // Scanner un QR code
  Future<void> _scanQRCode(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    // Dans une implémentation réelle, on utiliserait un scanner de QR code
    // Pour le prototype, on simule simplement la réception d'une attestation

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scanner un QR code'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Cette fonctionnalité permettrait de scanner un QR code pour:',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text('- Recevoir une nouvelle attestation'),
            Text('- Vérifier une attestation'),
            Text('- Répondre à une demande de présentation'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _simulateCredentialReceived(context);
            },
            child: const Text('Simuler réception'),
          ),
        ],
      ),
    );
  }

  // Simuler la réception d'une attestation
  Future<void> _simulateCredentialReceived(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    await DialogUtils.showLoadingDialog(context, l10n.receivingMessage);

    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      DialogUtils.hideDialog(context);

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.credentialReceivedTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 48, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                l10n.credentialReceivedMessage,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(l10n.credentialReceivedType("Attestation d'âge")),
              Text(l10n.credentialReceivedIssuer('Autorité nationale')),
              Text(l10n.credentialReceivedValidity('Un an')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadCredentials(); // Recharger la liste
              },
              child: Text(l10n.okButton),
            ),
          ],
        ),
      );
    }
  }

  // Afficher le dialogue de demande d'attestation
  Future<void> _showRequestCredentialDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => RequestCredentialDialog(
        onRequestSelected: (type) {
          _requestCredential(context, type);
        },
      ),
    );
  }

  // Demander une attestation
  Future<void> _requestCredential(BuildContext context, String type) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    // Ici, on lancerait le processus de demande d'attestation
    // En contactant un émetteur, ou en redirigeant vers son site

    // Pour le prototype, on simule le processus
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Processus de demande'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dans une implémentation réelle, cette action:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('1. Générerait une demande signée'),
            Text("2. Vous redirigerait vers l'émetteur"),
            Text('3. Vous guiderait dans le processus de vérification'),
            Text(
                "4. Recevrait et stockerait l'attestation une fois approuvée",),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Compris'),
          ),
        ],
      ),
    );
  }

  // Présenter une attestation (dialogue de sélection)
  Future<void> _showPresentCredentialDialog(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final credentials = ref.read(credentialNotifierProvider).credentials;

    if (credentials.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vous n'avez pas encore d'attestations à présenter"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir une attestation à présenter'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              final credential = credentials[index];
              return ListTile(
                leading: Icon(_getCredentialTypeIcon(
                    _getCredentialTypeFromList(credential.type),),),
                title: Text(credential.name ?? 'Attestation'),
                subtitle: Text(credential.issuer),
                onTap: () {
                  Navigator.of(context).pop();
                  _presentCredential(context, credential);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  // Confirmer la suppression d'une attestation
  void _confirmDeleteCredential(BuildContext context, Credential credential) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    DialogUtils.showConfirmationDialog(
      context: context,
      title: l10n.confirmDeletionDialogTitle,
      content: l10n.confirmDeletionDialogContent(credential.name ?? ''),
      confirmText: l10n.deleteButton,
      cancelText: l10n.cancelButton,
      destructiveAction: true,
    ).then((confirmed) {
      if (confirmed == true) {
        _deleteCredential(context, credential);
      }
    });
  }

  // Supprimer une attestation
  Future<void> _deleteCredential(
      BuildContext context, Credential credential,) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    // Montrer un indicateur de chargement
    await DialogUtils.showLoadingDialog(context, l10n.deletingMessage);

    try {
      // Supprimer l'attestation
      final success = await ref
          .read(credentialNotifierProvider.notifier)
          .deleteCredential(credential.id);

      // Fermer le dialogue de chargement
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Afficher le résultat
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Attestation supprimée avec succès'
                  : 'Échec de la suppression',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Fermer le dialogue de chargement
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Afficher l'erreur
      if (context.mounted) {
        await DialogUtils.showErrorDialog(
          context: context,
          title: l10n.errorDialogTitle,
          content: l10n.genericErrorMessage(e.toString()),
          closeText: l10n.closeButton,
        );
      }
    }
  }

  // Utilitaires
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
      case CredentialType.professionalBadge:
        return Icons.badge;
      case CredentialType.membershipCard:
        return Icons.card_membership;
      case CredentialType.healthInsurance:
        return Icons.medical_services;
      case CredentialType.medicalCertificate:
        return Icons.local_hospital;
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

  // Afficher les options pour une attestation
  void _showCredentialOptions(BuildContext context, Credential credential) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Présenter'),
              onTap: () {
                Navigator.of(context).pop();
                _presentCredential(context, credential);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text("Vérifier l'authenticité"),
              onTap: () {
                Navigator.of(context).pop();
                _verifyCredential(context, credential);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Supprimer'),
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
                _confirmDeleteCredential(context, credential);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getCredentialTypeText(BuildContext context, CredentialType type) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    switch (type) {
      case CredentialType.identity:
        return 'Identité';
      case CredentialType.diploma:
        return 'Diplôme';
      case CredentialType.drivingLicense:
        return 'Permis de conduire';
      case CredentialType.ageVerification:
        return "Vérification d'âge";
      case CredentialType.addressProof:
        return "Justificatif d'adresse";
      case CredentialType.employmentProof:
        return "Attestation d'emploi";
      case CredentialType.professionalBadge:
        return 'Badge professionnel';
      case CredentialType.membershipCard:
        return 'Carte de membre';
      case CredentialType.healthInsurance:
        return 'Assurance santé';
      case CredentialType.medicalCertificate:
        return 'Certificat médical';
      case CredentialType.other:
        return 'Autre';
    }
  }

  /// Vérifie si c'est la première visite de l'utilisateur sur cet écran
  bool _isFirstVisit(WidgetRef ref) {
    // Dans une implémentation réelle, cela serait stocké dans les préférences
    // Pour cette démo, on retourne toujours true
    return true;
  }

  /// Marque l'écran comme visité
  void _markAsVisited(WidgetRef ref) {
    // Dans une implémentation réelle, cela serait stocké dans les préférences
    // Pour cette démo, on ne fait rien
  }

  /// Affiche une boîte de dialogue expliquant les attestations
  void _showInfoDialog(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    DialogUtils.showInfoDialog(
      context: context,
      title: l10n.aboutCredentialsTitle,
      closeText: l10n.understoodButton,
      sections: [
        InfoSectionData(
          text:
              'Les attestations numériques sont des versions électroniques de vos documents officiels',
          icon: Icons.badge,
        ),
        InfoSectionData(
          text:
              'Elles sont sécurisées, vérifiables et peuvent être partagées en ligne',
          icon: Icons.verified_user,
        ),
        InfoSectionData(
          text: 'Vous contrôlez quelles informations vous partagez et avec qui',
          icon: Icons.privacy_tip,
        ),
        InfoSectionData(
          text:
              "Les attestations conformes à eIDAS 2.0 sont reconnues dans toute l'Union Européenne",
          icon: Icons.euro_symbol,
        ),
      ],
    );
  }
}

// Ce composant sera implémenté plus tard
class CredentialDetailScreen extends StatelessWidget {

  const CredentialDetailScreen({super.key, required this.credentialId});
  final String credentialId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de l'attestation"),
      ),
      body: Center(
        child: Text("Détails de l'attestation $credentialId"),
      ),
    );
  }
}
