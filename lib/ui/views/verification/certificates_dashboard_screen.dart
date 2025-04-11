import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Screen that displays all certificates of the user
class CertificatesDashboardScreen extends ConsumerWidget {
  const CertificatesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the verification state
    final verificationState = ref.watch(verificationNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialsMenuTitle),
      ),
      body: verificationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCertificatesList(context, verificationState),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to start a new verification
          Navigator.of(context).pushNamed('/verification/start');
        },
        tooltip: l10n.verifyStatusButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCertificatesList(BuildContext context, VerificationState state) {
    final l10n = AppLocalizations.of(context)!;
    // Mock certificates for UI development
    // In a real app, these would come from the blockchain
    final certificates = [
      _createMockCertificate(
        id: '1234567890',
        issuedAt: DateTime.now().subtract(const Duration(days: 30)),
        expiresAt: DateTime.now().add(const Duration(days: 335)),
        eidasLevel: EidasLevel.substantial,
      ),
      _createMockCertificate(
        id: '0987654321',
        issuedAt: DateTime.now().subtract(const Duration(days: 180)),
        expiresAt: DateTime.now().add(const Duration(days: 185)),
        eidasLevel: EidasLevel.high,
      ),
      _createMockCertificate(
        id: '5678901234',
        issuedAt: DateTime.now().subtract(const Duration(days: 400)),
        expiresAt: DateTime.now().subtract(const Duration(days: 35)),
        eidasLevel: EidasLevel.low,
      ),
    ];

    if (certificates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noEidasCompatibleCredentials,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.aboutDigitalCredentialsInfo1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/verification/start');
              },
              icon: const Icon(Icons.add_circle_outline),
              label: Text(l10n.verifyStatusButton),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        final certificate = certificates[index];
        final isExpired = certificate.expiresAt.isBefore(DateTime.now());
        final isExpiringSoon = !isExpired &&
            certificate.expiresAt.difference(DateTime.now()).inDays < 30;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: InkWell(
            onTap: () => _showCertificateDetails(context, certificate),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Certificate header with status
                Container(
                  color: _getCertificateHeaderColor(isExpired, isExpiringSoon),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getCertificateIcon(isExpired, isExpiringSoon),
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getCertificateStatus(
                              isExpired, isExpiringSoon, l10n),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        _getEidasLevelText(certificate.eidasLevel, l10n),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Certificate content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            l10n.documentTypeCertificate,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                          l10n.identifierLabel, _truncateId(certificate.id)),
                      _buildInfoRow(
                        l10n.issuanceDateLabel,
                        _formatDate(certificate.issuedAt),
                      ),
                      _buildInfoRow(
                        l10n.expirationDateLabel,
                        _formatDate(certificate.expiresAt),
                      ),
                    ],
                  ),
                ),
                // Actions buttons
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () =>
                            _shareCertificate(context, certificate, l10n),
                        icon: const Icon(Icons.share, size: 18),
                        label: Text(l10n.shareButtonLabel),
                      ),
                      if (isExpired || isExpiringSoon)
                        TextButton.icon(
                          onPressed: () =>
                              _renewCertificate(context, certificate, l10n),
                          icon: const Icon(Icons.refresh, size: 18),
                          label: Text(l10n.requestButton ?? "Renew"),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  // Helper to create a mock certificate for UI development
  VerificationCertificate _createMockCertificate({
    required String id,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required EidasLevel eidasLevel,
  }) {
    return VerificationCertificate(
      id: id,
      issuedAt: issuedAt,
      expiresAt: expiresAt,
      issuer: 'Archethic Identity Authority',
      signature: 'mock_digital_signature_$id',
      eidasLevel: eidasLevel,
    );
  }

  // Helper methods
  Color _getCertificateHeaderColor(bool isExpired, bool isExpiringSoon) {
    if (isExpired) return Colors.red;
    if (isExpiringSoon) return Colors.orange;
    return Colors.green;
  }

  IconData _getCertificateIcon(bool isExpired, bool isExpiringSoon) {
    if (isExpired) return Icons.warning_rounded;
    if (isExpiringSoon) return Icons.access_time;
    return Icons.check_circle;
  }

  String _getCertificateStatus(
      bool isExpired, bool isExpiringSoon, AppLocalizations l10n) {
    if (isExpired) return l10n.expiredStatus;
    if (isExpiringSoon) return l10n.notVerifiedStatus;
    return l10n.verifiedStatus;
  }

  String _truncateId(String id) {
    if (id.length <= 10) return id;
    return '${id.substring(0, 6)}...${id.substring(id.length - 4)}';
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    return '$day/$month/$year';
  }

  String _getEidasLevelText(EidasLevel level, AppLocalizations l10n) {
    switch (level) {
      case EidasLevel.low:
        return "eIDAS Low";
      case EidasLevel.substantial:
        return "eIDAS Substantial";
      case EidasLevel.high:
        return "eIDAS High";
    }
  }

  // Certificate actions
  void _showCertificateDetails(
    BuildContext context,
    VerificationCertificate certificate,
  ) {
    Navigator.of(context).pushNamed(
      '/verification/certificate/details',
      arguments: certificate,
    );
  }

  void _shareCertificate(
    BuildContext context,
    VerificationCertificate certificate,
    AppLocalizations l10n,
  ) {
    // Show share options dialog
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
                // Show QR code dialog
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: Text("Export as PDF"),
              onTap: () {
                Navigator.pop(context);
                // Export as PDF
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: Text("Generate Link"),
              onTap: () {
                Navigator.pop(context);
                // Generate and copy link
              },
            ),
          ],
        ),
      ),
    );
  }

  void _renewCertificate(
    BuildContext context,
    VerificationCertificate certificate,
    AppLocalizations l10n,
  ) {
    // Navigate to renewal process with the certificate as argument
    Navigator.of(context).pushNamed(
      '/verification/renew',
      arguments: certificate,
    );
  }
}
