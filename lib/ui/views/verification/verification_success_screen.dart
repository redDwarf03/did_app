import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen displayed when verification is successfully completed
class VerificationSuccessScreen extends ConsumerWidget {
  const VerificationSuccessScreen({
    super.key,
    required this.certificate,
  });

  final VerificationCertificate certificate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Complete'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_user,
                  size: 80,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 24),

              // Success title
              const Text(
                'Verification Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Success description
              const Text(
                'Your identity has been successfully verified and is now compliant with KYC/AML regulations and eIDAS 2.0 standards.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Certificate information
              _buildCertificateCard(context),
              const SizedBox(height: 32),

              // eIDAS compliance badge
              _buildEidasComplianceBadge(context),
              const SizedBox(height: 32),

              // Actions
              ElevatedButton.icon(
                onPressed: () => context.go('/'), // Go to home page
                icon: const Icon(Icons.home),
                label: const Text('Return to Home'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () =>
                    context.go('/identity'), // Go to identity screen
                icon: const Icon(Icons.person),
                label: const Text('View My Identity'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => _shareCertificate(context),
                icon: const Icon(Icons.share),
                label: const Text('Share Certificate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the certificate card with details
  Widget _buildCertificateCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification Certificate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Certificate ID', certificate.id, copyable: true),
            _buildInfoRow(
              'Issued Date',
              _formatDate(certificate.issuedAt),
            ),
            _buildInfoRow(
              'Expiry Date',
              _formatDate(certificate.expiresAt),
            ),
            _buildInfoRow('Issuer', certificate.issuer),
            _buildInfoRow(
              'eIDAS Level',
              _getEidasLevelText(certificate.eidasLevel),
            ),
          ],
        ),
      ),
    );
  }

  /// Build an information row with label and value
  Widget _buildInfoRow(String label, String value, {bool copyable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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
          if (copyable)
            IconButton(
              icon: const Icon(Icons.copy, size: 16),
              onPressed: () => _copyToClipboard(value),
              tooltip: 'Copy to clipboard',
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }

  /// Build the eIDAS compliance badge
  Widget _buildEidasComplianceBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified,
                color: Colors.blue[700],
              ),
              const SizedBox(width: 8),
              Text(
                'eIDAS ${_getEidasLevelText(certificate.eidasLevel)} Compliant',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getEidasLevelDescription(certificate.eidasLevel),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  /// Copy text to clipboard and show a snackbar
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Show share options for the certificate
  void _shareCertificate(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Certificate'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This feature would allow sharing your verification certificate with trusted third parties.',
            ),
            SizedBox(height: 16),
            Text(
              'In a real implementation, this would integrate with the Archethic blockchain to securely share your verification status while maintaining your privacy.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Format a date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Get a user-friendly text for eIDAS level
  String _getEidasLevelText(EidasLevel level) {
    switch (level) {
      case EidasLevel.low:
        return 'Low';
      case EidasLevel.substantial:
        return 'Substantial';
      case EidasLevel.high:
        return 'High';
    }
  }

  /// Get a description for eIDAS level
  String _getEidasLevelDescription(EidasLevel level) {
    switch (level) {
      case EidasLevel.low:
        return 'Basic assurance level sufficient for simple online services';
      case EidasLevel.substantial:
        return 'Substantial assurance level suitable for most financial and public services';
      case EidasLevel.high:
        return 'High assurance level suitable for the most sensitive transactions and services';
    }
  }

  // Global key for accessing scaffold from static methods
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
}
