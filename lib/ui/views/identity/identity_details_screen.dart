import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen to display and manage details of a digital identity
class IdentityDetailsScreen extends ConsumerWidget {
  const IdentityDetailsScreen({
    super.key,
    this.identity,
    this.address,
  }) : assert(identity != null || address != null,
            'Either identity or address must be provided');

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit screen
              // Will be implemented later
            },
            tooltip: 'Edit Identity',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIdentityHeader(context, currentIdentity),
            const SizedBox(height: 24),
            _buildStatusCard(context, currentIdentity),
            const SizedBox(height: 24),
            _buildPersonalInfoSection(context, currentIdentity),
            const SizedBox(height: 24),
            if (currentIdentity.personalInfo.address != null)
              _buildAddressSection(context, currentIdentity),
            const SizedBox(height: 32),
            _buildBlockchainInfoCard(context, currentIdentity),
          ],
        ),
      ),
    );
  }

  /// Header with identity name and verification badge
  Widget _buildIdentityHeader(
      BuildContext context, DigitalIdentity currentIdentity) {
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
                _getVerificationLabel(currentIdentity.verificationStatus),
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
      BuildContext context, DigitalIdentity currentIdentity) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification Status',
              style: TextStyle(
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
              _getVerificationMessage(currentIdentity.verificationStatus),
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
                child: const Text('Start Verification'),
              ),
          ],
        ),
      ),
    );
  }

  /// Section showing personal information
  Widget _buildPersonalInfoSection(
      BuildContext context, DigitalIdentity currentIdentity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          Icons.person_outline,
          'Full Name',
          currentIdentity.personalInfo.fullName,
        ),
        _buildInfoRow(
          Icons.email_outlined,
          'Email',
          currentIdentity.personalInfo.email,
        ),
        if (currentIdentity.personalInfo.phoneNumber != null)
          _buildInfoRow(
            Icons.phone_outlined,
            'Phone',
            currentIdentity.personalInfo.phoneNumber!,
          ),
        if (currentIdentity.personalInfo.dateOfBirth != null)
          _buildInfoRow(
            Icons.cake_outlined,
            'Date of Birth',
            _formatDate(currentIdentity.personalInfo.dateOfBirth!),
          ),
        if (currentIdentity.personalInfo.nationality != null)
          _buildInfoRow(
            Icons.flag_outlined,
            'Nationality',
            currentIdentity.personalInfo.nationality!,
          ),
      ],
    );
  }

  /// Section showing address information if available
  Widget _buildAddressSection(
      BuildContext context, DigitalIdentity currentIdentity) {
    final address = currentIdentity.personalInfo.address!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          Icons.location_on_outlined,
          'Street',
          address.street,
        ),
        _buildInfoRow(
          Icons.location_city_outlined,
          'City',
          address.city,
        ),
        if (address.state != null)
          _buildInfoRow(
            Icons.map_outlined,
            'State/Region',
            address.state!,
          ),
        _buildInfoRow(
          Icons.markunread_mailbox_outlined,
          'Postal Code',
          address.postalCode,
        ),
        _buildInfoRow(
          Icons.public_outlined,
          'Country',
          address.country,
        ),
      ],
    );
  }

  /// Card showing blockchain information
  Widget _buildBlockchainInfoCard(
      BuildContext context, DigitalIdentity currentIdentity) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blockchain Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.fingerprint,
              'Identity Address',
              currentIdentity.identityAddress,
              truncate: true,
            ),
            _buildInfoRow(
              Icons.calendar_today_outlined,
              'Created',
              _formatDate(currentIdentity.createdAt),
            ),
            _buildInfoRow(
              Icons.update_outlined,
              'Last Updated',
              _formatDate(currentIdentity.updatedAt),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build consistent info rows
  Widget _buildInfoRow(IconData icon, String label, String value,
      {bool truncate = false}) {
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
              tooltip: 'Copy to clipboard',
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

  String _getVerificationLabel(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return 'Fully Verified';
      case IdentityVerificationStatus.basicVerified:
        return 'Basic Verification';
      case IdentityVerificationStatus.pending:
        return 'Verification Pending';
      case IdentityVerificationStatus.rejected:
        return 'Verification Rejected';
      case IdentityVerificationStatus.unverified:
        return 'Not Verified';
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

  String _getVerificationMessage(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.fullyVerified:
        return 'Your identity is fully verified and compliant with KYC/AML regulations.';
      case IdentityVerificationStatus.basicVerified:
        return 'Basic verification complete. Additional verification needed for full compliance.';
      case IdentityVerificationStatus.pending:
        return 'Your verification is being processed. This may take 24-48 hours.';
      case IdentityVerificationStatus.rejected:
        return 'Your verification was rejected. Please check your information and try again.';
      case IdentityVerificationStatus.unverified:
        return 'Your identity has not been verified. Verification is required for certain services.';
    }
  }

  // Date formatting helper
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
