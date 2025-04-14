import 'package:did_app/application/credential/credential_status_provider.dart';
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/credential_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Screen for credential renewal
class CredentialRenewalScreen extends ConsumerStatefulWidget {
  const CredentialRenewalScreen({super.key});

  @override
  ConsumerState<CredentialRenewalScreen> createState() =>
      _CredentialRenewalScreenState();
}

class _CredentialRenewalScreenState
    extends ConsumerState<CredentialRenewalScreen> {
  final List<Credential> _renewalCandidates = [];
  final List<Credential> _inProgress = [];
  final List<Credential> _completed = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRenewalCandidates();
  }

  Future<void> _loadRenewalCandidates() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get all credentials
      final credentialNotifier = ref.read(credentialNotifierProvider.notifier);
      final credentials = await credentialNotifier.getCredentials();

      // Check which ones need renewal
      final statusNotifier =
          ref.read(credentialStatusNotifierProvider.notifier);
      final renewalNeeded = await statusNotifier.checkForRenewalNeeded(
        credentials,
        const Duration(
          days: 30,
        ), // Renew if expiration in less than 30 days
      );

      setState(() {
        _renewalCandidates.clear();
        _renewalCandidates.addAll(renewalNeeded);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorOccurredMessage(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadRenewalCandidates,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(l10n),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_renewalCandidates.isEmpty &&
        _inProgress.isEmpty &&
        _completed.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              l10n.noCredentials,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noCredentialsMessage,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_renewalCandidates.isNotEmpty) ...[
            SectionTitle(title: l10n.credentialDataSection),
            ..._renewalCandidates
                .map((credential) => _buildRenewalCard(credential, l10n)),
            const SizedBox(height: 24),
          ],
          if (_inProgress.isNotEmpty) ...[
            SectionTitle(title: l10n.verificationSectionTitle),
            ..._inProgress
                .map((credential) => _buildInProgressCard(credential, l10n)),
            const SizedBox(height: 24),
          ],
          if (_completed.isNotEmpty) ...[
            SectionTitle(title: l10n.credentialListTitle),
            ..._completed
                .map((credential) => _buildCompletedCard(credential, l10n)),
          ],
        ],
      ),
    );
  }

  Widget _buildRenewalCard(Credential credential, AppLocalizations l10n) {
    final isExpired = credential.expirationDate != null &&
        credential.expirationDate!.isBefore(DateTime.now());
    final isRevoked = ref
            .read(credentialStatusNotifierProvider)
            .checkResults[credential.id]
            ?.status ==
        CredentialStatusType.revoked;

    final expiryMessage = credential.expirationDate != null
        ? isExpired
            ? l10n.expiredStatus
            : '${l10n.expirationDateLabel}: ${DateFormat('dd/MM/yyyy').format(credential.expirationDate!)}'
        : '';

    final credentialType = _getCredentialTypeFromList(credential.type);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: isRevoked
                ? const Icon(Icons.gpp_bad, color: Colors.red, size: 36)
                : isExpired
                    ? const Icon(Icons.warning, color: Colors.orange, size: 36)
                    : Icon(
                        _getCredentialTypeIcon(credentialType),
                        color: Colors.amber,
                        size: 36,
                      ),
            title: Text(_getCredentialName(credential)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  isRevoked ? l10n.revokedStatus : expiryMessage,
                  style: TextStyle(
                    color: isRevoked
                        ? Colors.red
                        : isExpired
                            ? Colors.orange
                            : Colors.amber,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CredentialDetailScreen(
                      credentialId: credential.id,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _initiateRenewal(credential, l10n),
                    child: Text(l10n.requestButton),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInProgressCard(Credential credential, AppLocalizations l10n) {
    return AppCard(
      child: ListTile(
        leading: const SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(),
        ),
        title: Text(_getCredentialName(credential)),
        subtitle: Text(l10n.verificationInProgress),
      ),
    );
  }

  Widget _buildCompletedCard(Credential credential, AppLocalizations l10n) {
    return AppCard(
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green, size: 36),
        title: Text(_getCredentialName(credential)),
        subtitle: Text(l10n.verifiedStatus),
      ),
    );
  }

  Future<void> _initiateRenewal(
    Credential credential,
    AppLocalizations l10n,
  ) async {
    // Move the credential to "in progress"
    setState(() {
      _renewalCandidates.remove(credential);
      _inProgress.add(credential);
    });

    // Initiate renewal
    final statusNotifier = ref.read(credentialStatusNotifierProvider.notifier);
    final success = await statusNotifier.initiateRenewal(credential);

    // Update the UI
    setState(() {
      _inProgress.remove(credential);
      if (success) {
        _completed.add(credential);
      } else {
        _renewalCandidates.add(credential); // Put back in the list to renew
      }
    });

    // Show result message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? l10n.credentialImportedSuccessfully : l10n.renewalFailed,
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  String _getCredentialName(Credential credential) {
    final type =
        credential.type.isNotEmpty ? credential.type.first : 'Credential';
    final subject = credential.credentialSubject;

    if (subject.containsKey('name')) {
      return subject['name'].toString();
    }

    if (subject.containsKey('givenName') && subject.containsKey('familyName')) {
      return '${subject['givenName']} ${subject['familyName']}';
    }

    return type;
  }

  // Utility methods
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
}
