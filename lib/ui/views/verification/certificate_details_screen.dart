import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart'; // Import l10n

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialDetailTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: l10n.shareButtonLabel,
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
            _buildStatusCard(
              context,
              isExpired,
              isExpiringSoon,
              daysRemaining,
            ),
            const SizedBox(height: 24),

            // Certificate details
            Text(
              l10n.credentialDataSection,
              style: const TextStyle(
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
                    _buildDetailRow(
                      context,
                      l10n.identifierLabel,
                      certificate.id,
                      true,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      l10n.issuanceDateLabel,
                      _formatDate(certificate.issuedAt),
                      false,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      l10n.expirationDateLabel,
                      _formatDate(certificate.expiresAt),
                      false,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      l10n.issuerLabel,
                      certificate.issuer,
                      false,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      l10n.eidasAssuranceLevelTitle,
                      _getEidasLevelText(certificate.eidasLevel, context),
                      false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Signature section
            Text(
              l10n.proofSignatureLabel,
              style: const TextStyle(
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
                    Text(
                      l10n.containedInformationContent,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                            l10n.proofSignatureLabel,
                          ),
                          tooltip:
                              l10n.copySignatureTooltip ?? "Copy Signature",
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
            Text(
              l10n.verificationSectionTitle,
              style: const TextStyle(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.verifiedStatus,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.credentialValidMessage,
                                style: const TextStyle(
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
                      label: Text(l10n.blockchainTxLabel),
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
                  label: Text(
                    isExpired ? l10n.requestButton : l10n.requestButton,
                  ),
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
    final l10n = AppLocalizations.of(context)!;
    Color statusColor;
    String statusText;
    String statusDescription;
    IconData statusIcon;

    if (isExpired) {
      statusColor = Colors.red;
      statusText = l10n.expiredStatus;
      statusDescription = l10n.expirationDateContent;
      statusIcon = Icons.warning_rounded;
    } else if (isExpiringSoon) {
      statusColor = Colors.orange;
      statusText = l10n.notVerifiedStatus;
      statusDescription = "Expires in $daysRemaining days";
      statusIcon = Icons.access_time;
    } else {
      statusColor = Colors.green;
      statusText = l10n.verifiedStatus;
      statusDescription = "Valid for $daysRemaining days";
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
  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    bool copyable,
  ) {
    final l10n = AppLocalizations.of(context)!;
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
                context,
                value,
                l10n.identifierLabel,
              ),
              tooltip: "Copy ID",
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }

  // Helper methods
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    return '$day/$month/$year';
  }

  String _getEidasLevelText(EidasLevel level, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (level) {
      case EidasLevel.low:
        return l10n.eidasLevelLow;
      case EidasLevel.substantial:
        return l10n.eidasLevelSubstantial;
      case EidasLevel.high:
        return l10n.eidasLevelHigh;
    }
  }

  String _truncateSignature(String signature) {
    if (signature.length <= 20) return signature;
    return '${signature.substring(0, 10)}...${signature.substring(signature.length - 10)}';
  }

  // Action methods
  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$message copied to clipboard")),
    );
  }

  void _shareCertificate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.shareButtonLabel,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: Text(l10n.scanQrCodeTooltip),
              onTap: () {
                Navigator.pop(context);
                _showQRCode(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: Text("Export as PDF"),
              onTap: () {
                Navigator.pop(context);
                // TODO: Export as PDF
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: Text("Generate Link"),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.verificationResultTitle),
        content: Text(
          l10n.credentialValidMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  void _renewCertificate(BuildContext context) {
    Navigator.of(context).pushNamed('/verification/renew');
  }

  void _showQRCode(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.scanQrCodeTooltip),
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
              child: Center(
                child: Text(
                  "QR Code Placeholder",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.scanQrCodeTooltip,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }
}
