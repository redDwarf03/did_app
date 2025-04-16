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
            Text(
              l10n.generatedPresentationQrCode,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
            Text(
              l10n.onlySelectedInfoShared,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.green),
            ),
          ],
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

  // Verify a credential's status.
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

  // Scan a QR code to receive a credential or verify a presentation.
  Future<void> _scanQRCode(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.scanQrCodeTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code_scanner, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              l10n.scanQrCodeDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(l10n.receiveNewCredential),
            Text(l10n.verifyCredential),
            Text(l10n.respondToPresentationRequest),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _simulateCredentialReceived(context);
            },
            child: Text(l10n.simulateReception),
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
              Text(l10n.credentialReceivedType(l10n.ageAttestationType)),
              Text(l10n.credentialReceivedIssuer(l10n.nationalAuthorityIssuer)),
              Text(l10n.credentialReceivedValidity(l10n.oneYearValidity)),
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

  // Show dialog to request a new credential.
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

  // Handle credential request type selection.
  Future<void> _requestCredential(BuildContext context, String type) async {
    // Here, we would launch the credential request process.
    // By contacting an issuer, or redirecting to their site.
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    // For the prototype, we simulate the process.
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.requestProcessTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.requestProcessDescription,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(l10n.generateSignedRequest),
            Text(l10n.redirectToIssuer),
            Text(l10n.guideVerificationProcess),
            Text(l10n.receiveAndStoreCredential),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.understoodButton),
          ),
        ],
      ),
    );
  }

  // Show dialog to select credentials for presentation.
  Future<void> _showPresentCredentialDialog(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final credentials = ref.read(credentialNotifierProvider).credentials;

    if (credentials.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.noCredentialsToPresent),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.chooseCredentialToPresent),
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
                title: Text(credential.name ?? l10n.defaultCredentialName),
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
            child: Text(l10n.cancelButton),
          ),
        ],
      ),
    );
  }

  // Ask for confirmation before deleting a credential.
  Future<void> _confirmDeleteCredential(
    BuildContext context,
    Credential credential,
  ) async {
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

  // Delete the credential.
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
                  ? l10n.credentialDeletedSuccess
                  : l10n.credentialDeletedFailure,
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

  // Show informational dialog about credentials.
  Future<void> _showInfoDialog(BuildContext context) async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    DialogUtils.showInfoDialog(
      context: context,
      title: l10n.aboutCredentialsTitle,
      closeText: l10n.understoodButton,
      sections: [
        InfoSectionData(
          text: l10n.digitalCredentialsDescription,
          icon: Icons.badge,
        ),
        InfoSectionData(
          text: l10n.credentialsSecurityDescription,
          icon: Icons.verified_user,
        ),
        InfoSectionData(
          text: l10n.credentialsPrivacyDescription,
          icon: Icons.privacy_tip,
        ),
        InfoSectionData(
          text: l10n.eidasComplianceDescription,
          icon: Icons.euro_symbol,
        ),
      ],
    );
  }

  // Logic to check if it's the user's first visit to this screen.
  bool _isFirstVisit(WidgetRef ref) {
    // In a real app, this would check a persistent flag.
    return true;
  }

  // Logic to mark the screen as visited.
  void _markAsVisited(WidgetRef ref) {
    // In a real app, this would set a persistent flag.
    ref.read(dummyFirstVisitProvider.notifier).state = false;
  }
}

// Temporary provider for demo purposes.
final dummyFirstVisitProvider = StateProvider<bool>((ref) => true);

// This component will be implemented later.
class CredentialDetailScreen extends StatelessWidget {
  const CredentialDetailScreen({super.key, required this.credentialId});
  final String credentialId;

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialDetailsScreenTitle),
      ),
      body: Center(
        child: Text(l10n.credentialDetailsDescription(credentialId)),
      ),
    );
  }
}
