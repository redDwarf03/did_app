import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen to display and manage details of a digital identity
class IdentityDetailsScreen extends ConsumerWidget {
  const IdentityDetailsScreen({
    super.key,
    this.identity,
    this.address,
  }) : assert(
          identity != null || address != null,
          'Either identity or address must be provided',
        );

  final DigitalIdentity? identity;
  final String? address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If identity is null, fetch it using the address
    final identityState = ref.watch(identityNotifierProvider);
    final currentIdentity = identity ??
        (identityState.identity?.identityAddress == address
            ? identityState.identity!
            : throw Exception('Identity not found for address: $address'));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.identityDetailsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit screen
              // Will be implemented later
            },
            tooltip: l10n.editIdentityTooltip,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIdentityHeader(context, currentIdentity, l10n),
            const SizedBox(height: 24),
            _buildStatusCard(context, currentIdentity, l10n),
            const SizedBox(height: 24),
            _buildPersonalInfoSection(context, currentIdentity, l10n),
            const SizedBox(height: 24),
            if (currentIdentity.personalInfo.address != null)
              _buildAddressSection(context, currentIdentity, l10n),
            const SizedBox(height: 32),
            _buildBlockchainInfoCard(context, currentIdentity, l10n),
          ],
        ),
      ),
    );
  }

  /// Header with identity name and verification badge
  Widget _buildIdentityHeader(
    BuildContext context,
    DigitalIdentity currentIdentity,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            currentIdentity.displayName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getVerificationIcon(currentIdentity.verificationStatus),
                color:
                    _getVerificationColor(currentIdentity.verificationStatus),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                _getVerificationLabel(currentIdentity.verificationStatus, l10n),
                style: TextStyle(
                  color:
                      _getVerificationColor(currentIdentity.verificationStatus),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Card showing verification status with actions
  Widget _buildStatusCard(
    BuildContext context,
    DigitalIdentity currentIdentity,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.verificationStatusSectionTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value:
                  _getVerificationProgress(currentIdentity.verificationStatus),
              backgroundColor: Colors.grey[300],
              color: _getVerificationColor(currentIdentity.verificationStatus),
            ),
            const SizedBox(height: 16),
            Text(
              _getVerificationMessage(currentIdentity.verificationStatus, l10n),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            if (currentIdentity.verificationStatus ==
                IdentityVerificationStatus.unverified)
              ElevatedButton(
                onPressed: () {
                  // Start verification process
                  // Will be implemented in the verification feature
                },
                child: Text(l10n.startVerificationButtonDetails),
              ),
          ],
        ),
      ),
    );
  }

  /// Section showing personal information
  Widget _buildPersonalInfoSection(
    BuildContext context,
    DigitalIdentity currentIdentity,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.personalInfoSectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          context,
          Icons.person_outline,
          l10n.fullNameLabelDetails,
          currentIdentity.personalInfo.fullName,
        ),
        _buildInfoRow(
          context,
          Icons.email_outlined,
          l10n.emailLabelDetails,
          currentIdentity.personalInfo.email,
        ),
        if (currentIdentity.personalInfo.phoneNumber != null)
          _buildInfoRow(
            context,
            Icons.phone_outlined,
            l10n.phoneLabelDetails,
            currentIdentity.personalInfo.phoneNumber!,
          ),
        if (currentIdentity.personalInfo.dateOfBirth != null)
          _buildInfoRow(
            context,
            Icons.cake_outlined,
            l10n.dobLabelDetails,
            _formatDate(currentIdentity.personalInfo.dateOfBirth!),
          ),
        if (currentIdentity.personalInfo.nationality != null)
          _buildInfoRow(
            context,
            Icons.flag_outlined,
            l10n.nationalityLabelDetails,
            currentIdentity.personalInfo.nationality!,
          ),
      ],
    );
  }

  /// Section showing address information if available
  Widget _buildAddressSection(
    BuildContext context,
    DigitalIdentity currentIdentity,
    AppLocalizations l10n,
  ) {
    final address = currentIdentity.personalInfo.address!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.addressSectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          context,
          Icons.location_on_outlined,
          l10n.streetLabel,
          address.street,
        ),
        _buildInfoRow(
          context,
          Icons.location_city_outlined,
          l10n.cityLabel,
          address.city,
        ),
        if (address.state != null)
          _buildInfoRow(
            context,
            Icons.map_outlined,
            l10n.stateRegionLabel,
            address.state!,
          ),
        _buildInfoRow(
          context,
          Icons.markunread_mailbox_outlined,
          l10n.postalCodeLabel,
          address.postalCode,
        ),
        _buildInfoRow(
          context,
          Icons.public_outlined,
          l10n.countryLabel,
          address.country,
        ),
      ],
    );
  }

  /// Card showing blockchain information
  Widget _buildBlockchainInfoCard(
    BuildContext context,
    DigitalIdentity currentIdentity,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.blockchainInfoSectionTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.fingerprint,
              l10n.identityAddressLabel,
              currentIdentity.identityAddress,
              truncate: true,
            ),
            _buildInfoRow(
              context,
              Icons.calendar_today_outlined,
              l10n.createdLabel,
              _formatDate(currentIdentity.createdAt),
            ),
            _buildInfoRow(
              context,
              Icons.update_outlined,
              l10n.lastUpdatedLabelDetails,
              _formatDate(currentIdentity.updatedAt),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build consistent info rows
  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool truncate = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.blueGrey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  truncate ? '${value.substring(0, 16)}...' : value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          if (truncate)
            IconButton(
              icon: const Icon(Icons.copy, size: 16),
              onPressed: () {
                // Copy to clipboard feature
                // Will be implemented later
              },
              tooltip: l10n.copyToClipboardTooltip,
            ),
        ],
      ),
    );
  }

  // Helper methods for verification status

  IconData _getVerificationIcon(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return Icons.verified;
      case IdentityVerificationStatus.basicVerified:
        return Icons.check_circle;
      case IdentityVerificationStatus.pending:
        return Icons.hourglass_top;
      case IdentityVerificationStatus.rejected:
        return Icons.cancel;
      case IdentityVerificationStatus.unverified:
        return Icons.help_outline;
    }
  }

  Color _getVerificationColor(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return Colors.green;
      case IdentityVerificationStatus.basicVerified:
        return Colors.blue;
      case IdentityVerificationStatus.pending:
        return Colors.orange;
      case IdentityVerificationStatus.rejected:
        return Colors.red;
      case IdentityVerificationStatus.unverified:
        return Colors.grey;
    }
  }

  String _getVerificationLabel(
      IdentityVerificationStatus status, AppLocalizations l10n,) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return l10n.identityVerificationStatusFullyVerified;
      case IdentityVerificationStatus.basicVerified:
        return l10n.identityVerificationStatusBasicVerified;
      case IdentityVerificationStatus.pending:
        return l10n.identityVerificationStatusPending;
      case IdentityVerificationStatus.rejected:
        return l10n.identityVerificationStatusRejected;
      case IdentityVerificationStatus.unverified:
        return l10n.identityVerificationStatusNotVerified;
    }
  }

  double _getVerificationProgress(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return 1;
      case IdentityVerificationStatus.basicVerified:
        return 0.6;
      case IdentityVerificationStatus.pending:
        return 0.4;
      case IdentityVerificationStatus.rejected:
        return 0.2;
      case IdentityVerificationStatus.unverified:
        return 0;
    }
  }

  String _getVerificationMessage(
      IdentityVerificationStatus status, AppLocalizations l10n,) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return l10n.verificationMessageFullyVerified;
      case IdentityVerificationStatus.basicVerified:
        return l10n.verificationMessageBasicVerified;
      case IdentityVerificationStatus.pending:
        return l10n.verificationMessagePending;
      case IdentityVerificationStatus.rejected:
        return l10n.verificationMessageRejected;
      case IdentityVerificationStatus.unverified:
        return l10n.verificationMessageUnverified;
    }
  }

  // Date formatting helper
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
