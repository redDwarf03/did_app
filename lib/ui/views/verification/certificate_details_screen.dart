import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen to display detailed information about a verification certificate
class CertificateDetailsScreen extends ConsumerWidget {
  const CertificateDetailsScreen({
    super.key,
    required this.certificate,
  });

  final VerificationCertificate certificate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculate certificate validity
    final isExpired = certificate.expiresAt.isBefore(DateTime.now());
    final daysRemaining =
        certificate.expiresAt.difference(DateTime.now()).inDays;
    final isExpiringSoon = !isExpired && daysRemaining < 30;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share Certificate',
            onPressed: () => _shareCertificate(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _buildStatusCard(context, isExpired, isExpiringSoon, daysRemaining),
            const SizedBox(height: 24),

            // Certificate details
            const Text(
              'Certificate Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow('Certificate ID', certificate.id, true),
                    const Divider(),
                    _buildDetailRow('Issued Date',
                        _formatDate(certificate.issuedAt), false),
                    const Divider(),
                    _buildDetailRow('Expiry Date',
                        _formatDate(certificate.expiresAt), false),
                    const Divider(),
                    _buildDetailRow(
                        'Issuing Authority', certificate.issuer, false),
                    const Divider(),
                    _buildDetailRow('eIDAS Level',
                        _getEidasLevelText(certificate.eidasLevel), false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Signature section
            const Text(
              'Digital Signature',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'This certificate is cryptographically signed by the issuing authority, ensuring its authenticity and integrity.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _truncateSignature(certificate.signature),
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          onPressed: () => _copyToClipboard(
                            context,
                            certificate.signature,
                            'Signature copied to clipboard',
                          ),
                          tooltip: 'Copy signature',
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Verification status
            const Text(
              'Blockchain Verification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Verified on Archethic Blockchain',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'This certificate has been verified on the Archethic blockchain and is cryptographically secure.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => _viewOnBlockchain(context),
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('View on Blockchain Explorer'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons at bottom
            if (isExpired || isExpiringSoon)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _renewCertificate(context),
                  icon: const Icon(Icons.refresh),
                  label: Text(isExpired
                      ? 'Renew Expired Certificate'
                      : 'Renew Certificate'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Status card with validity information
  Widget _buildStatusCard(
    BuildContext context,
    bool isExpired,
    bool isExpiringSoon,
    int daysRemaining,
  ) {
    Color statusColor;
    String statusText;
    String statusDescription;
    IconData statusIcon;

    if (isExpired) {
      statusColor = Colors.red;
      statusText = 'Certificate Expired';
      statusDescription =
          'This certificate has expired and is no longer valid. Please renew it.';
      statusIcon = Icons.warning_rounded;
    } else if (isExpiringSoon) {
      statusColor = Colors.orange;
      statusText = 'Expiring Soon';
      statusDescription =
          'This certificate will expire in $daysRemaining days. Consider renewing it.';
      statusIcon = Icons.access_time;
    } else {
      statusColor = Colors.green;
      statusText = 'Valid Certificate';
      statusDescription =
          'This certificate is valid and will expire in $daysRemaining days.';
      statusIcon = Icons.check_circle;
    }

    return Card(
      elevation: 3,
      color: statusColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: statusColor.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              statusIcon,
              color: statusColor,
              size: 48,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    statusDescription,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Detail row with copy option if needed
  Widget _buildDetailRow(String label, String value, bool copyable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
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
              icon: const Icon(Icons.copy, size: 18),
              onPressed: () => _copyToClipboard(
                null,
                value,
                'ID copied to clipboard',
              ),
              tooltip: 'Copy to clipboard',
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }

  // Helper methods
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _getEidasLevelText(EidasLevel level) {
    switch (level) {
      case EidasLevel.low:
        return 'Low Assurance (eIDAS Low)';
      case EidasLevel.substantial:
        return 'Substantial Assurance (eIDAS Substantial)';
      case EidasLevel.high:
        return 'High Assurance (eIDAS High)';
    }
  }

  String _truncateSignature(String signature) {
    if (signature.length <= 20) return signature;
    return '${signature.substring(0, 10)}...${signature.substring(signature.length - 10)}';
  }

  // Action methods
  void _copyToClipboard(BuildContext? context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _shareCertificate(BuildContext context) {
    // Show share options
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share Certificate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Show QR Code'),
              onTap: () {
                Navigator.pop(context);
                _showQRCode(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Export as PDF
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Generate Verifiable Link'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Generate and copy link
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewOnBlockchain(BuildContext context) {
    // Mock function to open blockchain explorer
    // In a real app, this would open a URL to the blockchain explorer
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('View on Blockchain'),
        content: const Text(
          'This would open the Archethic blockchain explorer to show the certificate transaction.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _renewCertificate(BuildContext context) {
    // Navigate to renewal screen
    Navigator.of(context).pushNamed('/verification/renew');
  }

  void _showQRCode(BuildContext context) {
    // Show QR code dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Certificate QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Placeholder for QR code
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: const Center(
                child: Text(
                  'QR Code Placeholder',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Scan this QR code to verify the certificate.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
