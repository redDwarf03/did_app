import 'package:did_app/application/credential/eidas_provider.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/eidas_trust_registry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran de vérification des attestations eIDAS
class EidasVerificationScreen extends ConsumerStatefulWidget {
  const EidasVerificationScreen({
    super.key,
    required this.credential,
  });

  final Credential credential;

  @override
  ConsumerState<EidasVerificationScreen> createState() =>
      _EidasVerificationScreenState();
}

class _EidasVerificationScreenState
    extends ConsumerState<EidasVerificationScreen> {
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    // Vérifier l'attestation automatiquement au chargement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyCredential();
    });
  }

  Future<void> _verifyCredential() async {
    if (widget.credential is! EidasCredential) {
      setState(() {
        _isVerifying = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Cannot verify: Not an eIDAS credential type.'),
            backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    await ref
        .read(eidasNotifierProvider.notifier)
        .verifyEidasCredential(widget.credential as EidasCredential);

    setState(() {
      _isVerifying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eidasState = ref.watch(eidasNotifierProvider);
    final verificationResult = eidasState.verificationResult;
    final revocationStatus = eidasState.revocationStatus;
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verificationResult),
      ),
      body: _isVerifying || eidasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCredentialInfoCard(l10n),
                  const SizedBox(height: 24),
                  if (verificationResult != null)
                    _buildVerificationResultCard(verificationResult, l10n),
                  if (verificationResult != null) const SizedBox(height: 24),
                  if (revocationStatus != null)
                    _buildRevocationStatusCard(revocationStatus, l10n),
                  if (revocationStatus != null) const SizedBox(height: 24),
                  _buildCryptographicDetailsCard(l10n),
                  const SizedBox(height: 24),
                  _buildEidasComplianceCard(l10n),
                  const SizedBox(height: 24),
                  _buildActionButtons(l10n),
                ],
              ),
            ),
    );
  }

  Widget _buildCredentialInfoCard(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.credentialDetailTitle),
        AppCard(
          child: ListTile(
            leading: const Icon(Icons.badge, size: 40),
            title: Text(widget.credential.name ?? l10n.defaultCredentialName),
            subtitle: Text(
              '${l10n.issuerLabel}: ${widget.credential.issuer}\n'
              '${l10n.credentialTypeLabel}: ${widget.credential.type.join(', ')}',
            ),
            isThreeLine: true,
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationResultCard(
    dynamic verificationResult,
    AppLocalizations l10n,
  ) {
    final isValid = verificationResult.isValid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.verificationResultTitle),
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: isValid
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isValid ? Icons.verified_user : Icons.gpp_bad,
                    color: isValid ? Colors.green : Colors.red,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isValid ? l10n.verifiedStatus : l10n.notVerifiedStatus,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isValid ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(verificationResult.message),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRevocationStatusCard(
    dynamic revocationStatus,
    AppLocalizations l10n,
  ) {
    final isRevoked = revocationStatus.isRevoked;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.status),
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: !isRevoked
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    !isRevoked ? Icons.verified : Icons.block,
                    color: !isRevoked ? Colors.green : Colors.red,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        !isRevoked ? l10n.verifiedStatus : l10n.revokedStatus,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: !isRevoked ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(revocationStatus.message),
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.lastUpdatedLabel}: ${_formatDateTime(revocationStatus.lastChecked)}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCryptographicDetailsCard(AppLocalizations l10n) {
    final proof = widget.credential.proof;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.cryptographicProofSection),
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  l10n,
                  l10n.issuerLabel,
                  widget.credential.issuer,
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  l10n,
                  l10n.issuanceDateLabel,
                  widget.credential.issuanceDate != null
                      ? _formatDateTime(widget.credential.issuanceDate!)
                      : 'N/A',
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  l10n,
                  l10n.proofMethodLabel,
                  proof['verificationMethod']?.toString() ?? 'N/A',
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  l10n,
                  l10n.proofTypeLabel,
                  proof['type']?.toString() ?? 'N/A',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEidasComplianceCard(AppLocalizations l10n) {
    final eidasState = ref.watch(eidasNotifierProvider);
    final verificationResult = eidasState.verificationResult;
    final trustListReport = eidasState.trustListReport;

    final issuerTrustedFuture =
        EidasTrustList.instance.isIssuerTrusted(widget.credential.issuer);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.eidasInteropHeader),
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.eidasInteropTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.eidasInteropDescription,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.requirementsLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildComplianceCheck(
                  'W3C Verifiable Credentials Format',
                  true,
                ),
                _buildComplianceCheck(
                  l10n.proofSignatureLabel,
                  verificationResult?.isValid ?? false,
                ),
                _buildComplianceCheck('eIDAS Context', true),
                _buildComplianceCheck(
                  l10n.eudiWalletTitle,
                  eidasState.isEudiWalletAvailable,
                ),
                FutureBuilder<bool>(
                  future: issuerTrustedFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2)),
                            SizedBox(width: 8),
                            Text('Checking issuer trust...'),
                          ],
                        ),
                      );
                    }
                    final isTrusted = snapshot.data ?? false;
                    return _buildComplianceCheck(
                        l10n.verifiedIssuer, isTrusted);
                  },
                ),

                // Section registre de confiance
                if (trustListReport != null ||
                    eidasState.lastSyncDate != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    l10n.trustRegistryTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (eidasState.lastSyncDate != null)
                    Text(
                      '${l10n.lastSynchronization}: ${_formatDateTime(eidasState.lastSyncDate!)}',
                    ),
                  if (trustListReport != null)
                    Text(
                      '${l10n.trustedIssuers}: ${trustListReport['totalIssuers']}',
                    ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _openTrustRegistry,
                    icon: const Icon(Icons.open_in_new),
                    label: Text(l10n.shareButtonLabel),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openTrustRegistry() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EidasTrustRegistryScreen(),
      ),
    );
  }

  Widget _buildActionButtons(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _generateQrCode,
          icon: const Icon(Icons.qr_code),
          label: Text(l10n.shareButtonLabel),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          label: Text(l10n.closeButton),
        ),
      ],
    );
  }

  Widget _buildDetailRow(AppLocalizations l10n, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceCheck(String label, bool isCompliant) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isCompliant ? Icons.check_circle : Icons.cancel,
            color: isCompliant ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Future<void> _generateQrCode() async {
    final qrCodeData = await ref
        .read(eidasNotifierProvider.notifier)
        .exportToJson(widget.credential);

    if (qrCodeData != null && mounted) {
      _showQrCodeDialog(qrCodeData);
    }
  }

  void _showQrCodeDialog([String? qrCodeData]) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shareButtonLabel),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.credentialPresentationTitle),
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey.shade300,
              child: qrCodeData != null
                  ? const Center(
                      child:
                          Icon(Icons.qr_code, size: 150, color: Colors.black87),
                    )
                  : Center(
                      child: Text(l10n.errorOccurredMessage('QR Code')),
                    ),
            ),
            if (qrCodeData != null) ...[
              const SizedBox(height: 8),
              Text(
                l10n.shareButtonLabel,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
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

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }
}
