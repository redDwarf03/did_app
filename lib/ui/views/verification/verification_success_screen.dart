import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verificationCompleteTitle),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
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
              Text(
                l10n.verificationSuccessTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Success description
              Text(
                l10n.verificationSuccessDescription,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Certificate information
              _buildCertificateCard(context, l10n),
              const SizedBox(height: 32),

              // eIDAS compliance badge
              _buildEidasComplianceBadge(context, l10n),
              const SizedBox(height: 32),

              // Actions
              ElevatedButton.icon(
                onPressed: () => context.go('/main'), // Go to home page
                icon: const Icon(Icons.home),
                label: Text(l10n.returnToHomeButton),
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
                    context.go('/main/identity'), // Go to identity screen
                icon: const Icon(Icons.person),
                label: Text(l10n.viewMyIdentityButton),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => _shareCertificate(context, l10n),
                icon: const Icon(Icons.share),
                label: Text(l10n.shareCertificateButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the certificate card with details
  Widget _buildCertificateCard(BuildContext context, AppLocalizations l10n) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.verificationCertificateTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              l10n.certificateIdLabel,
              certificate.id,
              copyable: true,
              l10n: l10n,
            ),
            _buildInfoRow(
              l10n.issuedDateLabel,
              _formatDate(certificate.issuedAt),
              l10n: l10n,
            ),
            _buildInfoRow(
              l10n.expiryDateLabel,
              _formatDate(certificate.expiresAt),
              l10n: l10n,
            ),
            _buildInfoRow(l10n.issuerLabel, certificate.issuer, l10n: l10n),
            _buildInfoRow(
              l10n.eidasLevelLabel,
              _getEidasLevelText(certificate.eidasLevel, l10n),
              l10n: l10n,
            ),
          ],
        ),
      ),
    );
  }

  /// Build an information row with label and value
  Widget _buildInfoRow(
    String label,
    String value, {
    bool copyable = false,
    required AppLocalizations l10n,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
              onPressed: () => _copyToClipboard(value, l10n),
              tooltip: l10n.copyToClipboardTooltip,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }

  /// Build the eIDAS compliance badge
  Widget _buildEidasComplianceBadge(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.5),
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
                '${l10n.eidasCompliantLevelDisplay}: ${_getEidasLevelText(certificate.eidasLevel, l10n)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getEidasLevelDescription(certificate.eidasLevel, l10n),
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
  void _copyToClipboard(String text, AppLocalizations l10n) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(l10n.copiedToClipboardMessage(text)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show share options for the certificate
  void _shareCertificate(BuildContext context, AppLocalizations l10n) {
    // TODO: Implement real certificate sharing functionality
    // This should:
    // - Generate a shareable verifiable credential
    // - Support selective disclosure of certificate details
    // - Provide options for digital sharing (QR code, deep link, etc.)
    // - Log sharing activity for audit purposes

    // For now, just show a dialog

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shareCertificateDialogTitle),
        content: Text(
          l10n.shareCertificateDialogContent,
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

  /// Format a date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Get a user-friendly text for eIDAS level
  String _getEidasLevelText(EidasLevel level, AppLocalizations l10n) {
    switch (level) {
      case EidasLevel.low:
        return l10n.low;
      case EidasLevel.substantial:
        return l10n.substantial;
      case EidasLevel.high:
        return l10n.high;
    }
  }

  /// Get a description for eIDAS level
  String _getEidasLevelDescription(EidasLevel level, AppLocalizations l10n) {
    switch (level) {
      case EidasLevel.low:
        return l10n.eidasLevelLowDescription;
      case EidasLevel.substantial:
        return l10n.eidasLevelSubstantialDescription;
      case EidasLevel.high:
        return l10n.eidasLevelHighDescription;
    }
  }

  // Global key for accessing scaffold from static methods
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
}
