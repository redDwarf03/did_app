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

/// Screen displaying the user's Verifiable Credentials.
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
    // Load credentials AFTER the initial widget build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if the widget is still mounted before accessing ref.
      if (mounted) {
        _loadCredentials();
      }
    });
  }

  Future<void> _loadCredentials() async {
    // We can use ref.read here as we are outside the build phase.
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity != null) {
      // Use .notifier to call the method.
      await ref.read(credentialNotifierProvider.notifier).loadCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    final credentialState = ref.watch(credentialNotifierProvider);
    final identityState = ref.watch(identityNotifierProvider);
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
          // Beginner information banner.
          if (_isFirstVisit(ref))
            BeginnerInfoBanner(
              onDismiss: () => _markAsVisited(ref),
            ),

          // Credential list section - Wrap with Expanded
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: credentialState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildCredentialList(context, credentialState),
            ),
          ),
        ],
      ),
      // Button to request a new credential.
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

  // Open credential details.
  void _openCredentialDetails(BuildContext context, Credential credential) {
    // Navigate to credential details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CredentialDetailScreen(credentialId: credential.id),
      ),
    );
  }

  // Present a credential.
  Future<void> _presentCredential(
    BuildContext context,
    Credential credential,
  ) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    // Here, we would display an interface to create a selective presentation
    // then generate a QR code or link to share this presentation.

    // For the prototype, we simply show a dialog with a dummy QR code.
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.credentialPresentationTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'QR Code de présentation générée', // Keep UI text, will be localized
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
              'Seules les informations sélectionnées seront partagées', // Keep UI text
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'), // Keep UI text
          ),
        ],
      ),
    );
  }

  // Verify a credential.
  Future<void> _verifyCredential(
    BuildContext context,
    Credential credential,
  ) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    // Show a loading indicator.
    await DialogUtils.showLoadingDialog(context, l10n.verifyingMessage);

    try {
      // Verify authenticity
      final isValid = await ref
          .read(credentialNotifierProvider.notifier)
          .verifyCredential(credential.id);

      // Close the loading dialog.
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Display the result.
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
      // Close the loading dialog.
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Display the error.
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

  // Scan a QR code.
  Future<void> _scanQRCode(BuildContext context) async {
    // In a real implementation, we would use a QR code scanner.
    // For the prototype, we simply simulate receiving a credential.

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scanner un QR code'), // Keep UI text
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Cette fonctionnalité permettrait de scanner un QR code pour:', // Keep UI text
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text('- Recevoir une nouvelle attestation'), // Keep UI text
            Text('- Vérifier une attestation'), // Keep UI text
            Text('- Répondre à une demande de présentation'), // Keep UI text
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'), // Keep UI text
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _simulateCredentialReceived(context);
            },
            child: const Text('Simuler réception'), // Keep UI text
          ),
        ],
      ),
    );
  }

  // Simulate receiving a credential.
  Future<void> _simulateCredentialReceived(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    await DialogUtils.showLoadingDialog(context, l10n.receivingMessage);

    // Simulate network delay.
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
              Text(l10n
                  .credentialReceivedType("Attestation d'âge")), // Keep UI text
              Text(l10n.credentialReceivedIssuer(
                  'Autorité nationale')), // Keep UI text
              Text(l10n.credentialReceivedValidity('Un an')), // Keep UI text
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadCredentials(); // Reload the list.
              },
              child: Text(l10n.okButton),
            ),
          ],
        ),
      );
    }
  }

  // Show the request credential dialog.
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

  // Request a credential.
  Future<void> _requestCredential(BuildContext context, String type) async {
    // Here, we would launch the credential request process.
    // By contacting an issuer, or redirecting to their site.

    // For the prototype, we simulate the process.
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Processus de demande'), // Keep UI text
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dans une implémentation réelle, cette action:', // Keep UI text
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('1. Générerait une demande signée'), // Keep UI text
            Text("2. Vous redirigerait vers l'émetteur"), // Keep UI text
            Text(
                '3. Vous guiderait dans le processus de vérification'), // Keep UI text
            Text(
              "4. Recevrait et stockerait l'attestation une fois approuvée", // Keep UI text
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Compris'), // Keep UI text
          ),
        ],
      ),
    );
  }

  // Present a credential (selection dialog).
  Future<void> _showPresentCredentialDialog(BuildContext context) async {
    final credentials = ref.read(credentialNotifierProvider).credentials;

    if (credentials.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Vous n'avez pas encore d'attestations à présenter"), // Keep UI text
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text('Choisir une attestation à présenter'), // Keep UI text
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              final credential = credentials[index];
              return ListTile(
                leading: Icon(
                  _getCredentialTypeIcon(
                    _getCredentialTypeFromList(credential.type),
                  ),
                ),
                title: Text(credential.name ?? 'Attestation'), // Keep UI text
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
            child: const Text('Annuler'), // Keep UI text
          ),
        ],
      ),
    );
  }

  // Confirm credential deletion.
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

  // Delete a credential.
  Future<void> _deleteCredential(
    BuildContext context,
    Credential credential,
  ) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    // Show a loading indicator.
    await DialogUtils.showLoadingDialog(context, l10n.deletingMessage);

    try {
      // Delete the credential
      final success = await ref
          .read(credentialNotifierProvider.notifier)
          .deleteCredential(credential.id);

      // Close the loading dialog.
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Display the result.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Attestation supprimée avec succès' // Keep UI text
                  : 'Échec de la suppression', // Keep UI text
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Close the loading dialog.
      if (context.mounted) {
        DialogUtils.hideDialog(context);
      }

      // Display the error.
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

  // Utilities.
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

  /// Checks if this is the user's first visit to this screen.
  bool _isFirstVisit(WidgetRef ref) {
    // In a real implementation, this would be stored in preferences.
    // For this demo, always return true.
    return true;
  }

  /// Marks the screen as visited.
  void _markAsVisited(WidgetRef ref) {
    // In a real implementation, this would be stored in preferences.
    // For this demo, do nothing.
  }

  /// Displays a dialog explaining credentials.
  void _showInfoDialog(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    DialogUtils.showInfoDialog(
      context: context,
      title: l10n.aboutCredentialsTitle,
      closeText: l10n.understoodButton,
      sections: [
        InfoSectionData(
          text:
              'Les attestations numériques sont des versions électroniques de vos documents officiels', // Keep UI text
          icon: Icons.badge,
        ),
        InfoSectionData(
          text:
              'Elles sont sécurisées, vérifiables et peuvent être partagées en ligne', // Keep UI text
          icon: Icons.verified_user,
        ),
        InfoSectionData(
          text:
              'Vous contrôlez quelles informations vous partagez et avec qui', // Keep UI text
          icon: Icons.privacy_tip,
        ),
        InfoSectionData(
          text:
              "Les attestations conformes à eIDAS 2.0 sont reconnues dans toute l'Union Européenne", // Keep UI text
          icon: Icons.euro_symbol,
        ),
      ],
    );
  }
}

// This component will be implemented later.
class CredentialDetailScreen extends StatelessWidget {
  const CredentialDetailScreen({super.key, required this.credentialId});
  final String credentialId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de l'attestation"), // Keep UI text
      ),
      body: Center(
        child: Text("Détails de l'attestation $credentialId"), // Keep UI text
      ),
    );
  }
}
