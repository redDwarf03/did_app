import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:did_app/application/credential/credential_status_provider.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/credential_renewal_screen.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Écran de gestion des statuts de révocation des attestations
class CredentialStatusScreen extends ConsumerWidget {
  const CredentialStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(credentialStatusNotifierProvider);
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verificationResult),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(credentialStatusNotifierProvider.notifier)
                  .refreshAllStatusLists();
            },
          ),
        ],
      ),
      body: _buildBody(context, statusState, l10n, ref),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CredentialStatusState state,
    AppLocalizations l10n,
    WidgetRef ref,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.error!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Réessayer la vérification
                ref
                    .read(credentialStatusNotifierProvider.notifier)
                    .refreshAllStatusLists();
              },
              child: Text(l10n.retryButton),
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
          _buildStatusSummary(context, state, l10n, ref),
          const SizedBox(height: 24),
          _buildStatusList(context, state, l10n),
        ],
      ),
    );
  }

  Widget _buildStatusSummary(
    BuildContext context,
    CredentialStatusState state,
    AppLocalizations l10n,
    WidgetRef ref,
  ) {
    final totalCount = state.checkResults.length;
    final validCount = state.checkResults.values
        .where((r) => r.status == CredentialStatusType.valid)
        .length;
    final revokedCount = state.checkResults.values
        .where((r) => r.status == CredentialStatusType.revoked)
        .length;

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: l10n.verificationResultTitle),
            const SizedBox(height: 16),
            _buildStatusRow(l10n.credentialsStatsLabel, totalCount),
            _buildStatusRow(l10n.verifiedLabel, validCount,
                color: Colors.green),
            _buildStatusRow(l10n.revokedStatus, revokedCount,
                color: Colors.red),
            if (state.lastCheck != null) ...[
              const Divider(),
              Text(
                '${l10n.lastUpdatedLabel}: ${_formatDate(state.lastCheck!)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (revokedCount > 0) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CredentialRenewalScreen(),
                    ),
                  );
                },
                child: Text(l10n.requestButton),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusList(BuildContext context, CredentialStatusState state,
      AppLocalizations l10n) {
    if (state.checkResults.isEmpty) {
      return Center(
        child: Text(l10n.noCredentials),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.credentialDetailTitle),
        const SizedBox(height: 16),
        ...state.checkResults.entries.map(
          (entry) => _buildStatusCard(context, entry.value, l10n),
        ),
      ],
    );
  }

  Widget _buildStatusCard(
      BuildContext context, StatusCheckResult result, AppLocalizations l10n) {
    final isRevoked = result.status == CredentialStatusType.revoked;
    final color = isRevoked ? Colors.red : Colors.green;

    // Determine credential type based on credential ID format
    // This is a simplistic approach for demo purposes
    final credentialType = _getCredentialTypeFromId(result.credentialId);
    final credentialName = _getDisplayNameFromId(result.credentialId, l10n);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(
              isRevoked ? Icons.cancel : _getCredentialTypeIcon(credentialType),
              color: isRevoked ? Colors.red : Colors.green,
              size: 36,
            ),
            title: Text(
              credentialName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  isRevoked ? l10n.revokedStatus : l10n.verifiedStatus,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (result.details != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    result.details!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatDate(result.checkedAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.verificationStatus,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${l10n.identifierLabel}: ',
                    style: Theme.of(context).textTheme.bodySmall),
                Flexible(
                  child: Text(
                    result.credentialId.length > 20
                        ? '${result.credentialId.substring(0, 10)}...${result.credentialId.substring(result.credentialId.length - 10)}'
                        : result.credentialId,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, int count, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            count.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Utility method to get credential type icon
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

  // Simplified method to determine credential type from ID
  // In a real app, you would get this from the actual credential data
  CredentialType _getCredentialTypeFromId(String credentialId) {
    if (credentialId.contains('identity')) {
      return CredentialType.identity;
    } else if (credentialId.contains('diploma') ||
        credentialId.contains('degree')) {
      return CredentialType.diploma;
    } else if (credentialId.contains('driving') ||
        credentialId.contains('license')) {
      return CredentialType.drivingLicense;
    } else if (credentialId.contains('age')) {
      return CredentialType.ageVerification;
    } else if (credentialId.contains('address')) {
      return CredentialType.addressProof;
    } else if (credentialId.contains('employ')) {
      return CredentialType.employmentProof;
    } else if (credentialId.contains('member')) {
      return CredentialType.membershipCard;
    } else if (credentialId.contains('health') ||
        credentialId.contains('insurance')) {
      return CredentialType.healthInsurance;
    } else if (credentialId.contains('medical')) {
      return CredentialType.medicalCertificate;
    } else if (credentialId.contains('professional') ||
        credentialId.contains('badge')) {
      return CredentialType.professionalBadge;
    } else {
      return CredentialType.other;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }

  // Helper method to generate a readable display name from credential ID
  String _getDisplayNameFromId(String credentialId, AppLocalizations l10n) {
    final credentialType = _getCredentialTypeFromId(credentialId);

    switch (credentialType) {
      case CredentialType.identity:
        return l10n.identityBottomNavLabel;
      case CredentialType.diploma:
        return 'Diploma';
      case CredentialType.drivingLicense:
        return 'Driving License';
      case CredentialType.ageVerification:
        return l10n.credentialAgeVerificationType;
      case CredentialType.addressProof:
        return 'Address Proof';
      case CredentialType.employmentProof:
        return 'Employment Proof';
      case CredentialType.membershipCard:
        return 'Membership Card';
      case CredentialType.healthInsurance:
        return 'Health Insurance';
      case CredentialType.medicalCertificate:
        return 'Medical Certificate';
      case CredentialType.professionalBadge:
        return 'Professional Badge';
      default:
        return credentialId.split('/').last;
    }
  }
}
