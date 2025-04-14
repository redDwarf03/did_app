import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

    // Fetch credentials for this identity
    final credentialState = ref.watch(credentialNotifierProvider);
    final credentials = credentialState.credentials;

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

            // Loading state for credentials
            if (credentialState.isLoading)
              const Center(child: CircularProgressIndicator()),

            // Personal info based on credentials
            if (!credentialState.isLoading)
              _buildPersonalInfoFromCredentials(
                context,
                credentials,
                currentIdentity.identityAddress,
                l10n,
              ),

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

  /// Section showing personal information from credentials
  Widget _buildPersonalInfoFromCredentials(
    BuildContext context,
    List<Credential> credentials,
    String subjectId,
    AppLocalizations l10n,
  ) {
    // Filter credentials related to this identity
    final identityCredentials = credentials
        .where((cred) => cred.credentialSubject['id'] == subjectId)
        .toList();

    if (identityCredentials.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              l10n.noCredentials,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    // Extract personal data from credentials
    String? fullName, email, phoneNumber, nationality, dateOfBirth;
    Map<String, dynamic>? address;

    for (final credential in identityCredentials) {
      final subject = credential.credentialSubject;
      if (credential.type.contains('FullNameCredential')) {
        fullName = subject['fullName'] as String?;
      } else if (credential.type.contains('EmailCredential')) {
        email = subject['email'] as String?;
      } else if (credential.type.contains('PhoneNumberCredential')) {
        phoneNumber = subject['phoneNumber'] as String?;
      } else if (credential.type.contains('NationalityCredential')) {
        nationality = subject['nationality'] as String?;
      } else if (credential.type.contains('DateOfBirthCredential')) {
        dateOfBirth = subject['dateOfBirth'] as String?;
      } else if (credential.type.contains('AddressCredential')) {
        address = subject['address'] as Map<String, dynamic>?;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info Section
        Text(
          l10n.personalInfoSectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (fullName != null)
          _buildInfoRow(
            context,
            Icons.person_outline,
            l10n.fullNameLabelDetails,
            fullName,
          ),
        if (email != null)
          _buildInfoRow(
            context,
            Icons.email_outlined,
            l10n.emailLabelDetails,
            email,
          ),
        if (phoneNumber != null)
          _buildInfoRow(
            context,
            Icons.phone_outlined,
            l10n.phoneLabelDetails,
            phoneNumber,
          ),
        if (dateOfBirth != null)
          _buildInfoRow(
            context,
            Icons.cake_outlined,
            l10n.dobLabelDetails,
            dateOfBirth,
          ),
        if (nationality != null)
          _buildInfoRow(
            context,
            Icons.flag_outlined,
            l10n.nationalityLabelDetails,
            nationality,
          ),

        // Address Section (if available)
        if (address != null) ...[
          const SizedBox(height: 24),
          Text(
            l10n.addressSectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (address['street'] != null)
            _buildInfoRow(
              context,
              Icons.location_on_outlined,
              l10n.streetLabel,
              address['street'] as String,
            ),
          if (address['city'] != null)
            _buildInfoRow(
              context,
              Icons.location_city_outlined,
              l10n.cityLabel,
              address['city'] as String,
            ),
          if (address['state'] != null)
            _buildInfoRow(
              context,
              Icons.map_outlined,
              l10n.stateRegionLabel,
              address['state'] as String,
            ),
          if (address['postalCode'] != null)
            _buildInfoRow(
              context,
              Icons.markunread_mailbox_outlined,
              l10n.postalCodeLabel,
              address['postalCode'] as String,
            ),
          if (address['country'] != null)
            _buildInfoRow(
              context,
              Icons.public,
              l10n.countryLabel,
              address['country'] as String,
            ),
        ],
      ],
    );
  }

  /// Card showing blockchain/DID information about the identity
  Widget _buildBlockchainInfoCard(
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
              isSelectable: true,
            ),
            _buildInfoRow(
              context,
              Icons.calendar_today_outlined,
              l10n.createdLabel,
              _formatDateTime(currentIdentity.createdAt),
            ),
            _buildInfoRow(
              context,
              Icons.update,
              l10n.lastUpdatedLabelDetails,
              _formatDateTime(currentIdentity.updatedAt),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build a consistent info row with an icon and label
  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isSelectable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                if (isSelectable)
                  SelectableText(
                    value,
                    style: const TextStyle(fontSize: 16),
                  )
                else
                  Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Format date and time using the user's locale
  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat.yMMMd().add_Hm();
    return formatter.format(dateTime);
  }

  // Helper methods for verification status UI
  IconData _getVerificationIcon(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return Icons.unpublished_outlined;
      case IdentityVerificationStatus.basicVerified:
        return Icons.check_circle_outline;
      case IdentityVerificationStatus.fullyVerified:
        return Icons.verified_user;
      case IdentityVerificationStatus.pending:
        return Icons.pending_outlined;
      case IdentityVerificationStatus.rejected:
        return Icons.dangerous_outlined;
    }
  }

  Color _getVerificationColor(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return Colors.grey;
      case IdentityVerificationStatus.basicVerified:
        return Colors.blue;
      case IdentityVerificationStatus.fullyVerified:
        return Colors.green;
      case IdentityVerificationStatus.pending:
        return Colors.orange;
      case IdentityVerificationStatus.rejected:
        return Colors.red;
    }
  }

  double _getVerificationProgress(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return 0;
      case IdentityVerificationStatus.basicVerified:
        return 0.5;
      case IdentityVerificationStatus.fullyVerified:
        return 1;
      case IdentityVerificationStatus.pending:
        return 0.75;
      case IdentityVerificationStatus.rejected:
        return 0;
    }
  }

  String _getVerificationLabel(
    IdentityVerificationStatus status,
    AppLocalizations l10n,
  ) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return l10n.identityVerificationStatusNotVerified;
      case IdentityVerificationStatus.basicVerified:
        return l10n.identityVerificationStatusBasicVerified;
      case IdentityVerificationStatus.fullyVerified:
        return l10n.identityVerificationStatusFullyVerified;
      case IdentityVerificationStatus.pending:
        return l10n.verificationStatusPending;
      case IdentityVerificationStatus.rejected:
        return l10n.verificationStatusRejected;
    }
  }

  String _getVerificationMessage(
    IdentityVerificationStatus status,
    AppLocalizations l10n,
  ) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return l10n.verificationMessageUnverified;
      case IdentityVerificationStatus.basicVerified:
        return l10n.verificationMessageBasicVerified;
      case IdentityVerificationStatus.fullyVerified:
        return l10n.verificationMessageFullyVerified;
      case IdentityVerificationStatus.pending:
        return l10n.verificationMessagePending;
      case IdentityVerificationStatus.rejected:
        return l10n.verificationMessageRejected;
    }
  }
}
