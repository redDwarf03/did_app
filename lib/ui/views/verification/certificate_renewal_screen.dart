import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen to renew an expired or expiring certificate
class CertificateRenewalScreen extends ConsumerStatefulWidget {
  const CertificateRenewalScreen({
    super.key,
    this.certificate,
  });

  final VerificationCertificate? certificate;

  @override
  ConsumerState<CertificateRenewalScreen> createState() =>
      _CertificateRenewalScreenState();
}

class _CertificateRenewalScreenState
    extends ConsumerState<CertificateRenewalScreen> {
  bool _isLoading = false;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    final isExpired = widget.certificate != null &&
        widget.certificate!.expiresAt.isBefore(DateTime.now());
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.certificateRenewal),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.initializingRenewal),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with certificate info if available
                  if (widget.certificate != null)
                    _buildCertificateInfoCard(
                      widget.certificate!,
                      isExpired,
                      l10n,
                    ),
                  if (widget.certificate != null) const SizedBox(height: 24),

                  // Renewal explanation
                  _buildRenewalInfo(isExpired, l10n),
                  const SizedBox(height: 24),

                  // Renewal process steps
                  _buildRenewalSteps(l10n),
                  const SizedBox(height: 24),

                  // Terms checkbox
                  CheckboxListTile(
                    value: _acceptTerms,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _acceptTerms = value;
                        });
                      }
                    },
                    title: const Text(
                      'I understand the renewal process and agree to the terms',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),

                  // Renewal button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _acceptTerms
                          ? () => _startRenewalProcess(l10n)
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(l10n.startRenewal),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Certificate info card (only shown if renewing a specific certificate)
  Widget _buildCertificateInfoCard(
    VerificationCertificate certificate,
    bool isExpired,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      color: isExpired
          ? Colors.red.withValues(alpha: 0.1)
          : Colors.orange.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isExpired
              ? Colors.red.withValues(alpha: 0.3)
              : Colors.orange.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isExpired ? Icons.warning_rounded : Icons.access_time,
                  color: isExpired ? Colors.red : Colors.orange,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isExpired ? l10n.expiredStatus : l10n.expirationDateTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isExpired ? Colors.red : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(l10n.identifierLabel, _truncateId(certificate.id)),
            _buildInfoRow(
              l10n.issuanceDateLabel,
              _formatDate(certificate.issuedAt),
            ),
            _buildInfoRow(
              l10n.expirationDateLabel,
              _formatDate(certificate.expiresAt),
            ),
            _buildInfoRow(
              l10n.eidasAssuranceLevelTitle,
              _getEidasLevelText(certificate.eidasLevel, l10n),
            ),
          ],
        ),
      ),
    );
  }

  // Renewal explanation
  Widget _buildRenewalInfo(bool isExpired, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpired ? l10n.expiredStatus : l10n.expirationDateTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isExpired ? l10n.expirationDateContent : l10n.expirationDateContent,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Colors.blue.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.blue.withValues(alpha: 0.3)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade300,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l10n.eidasAssuranceLevelContent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Renewal process steps
  Widget _buildRenewalSteps(AppLocalizations l10n) {
    final steps = [
      l10n.requestProcessStep1,
      l10n.requestProcessStep2,
      l10n.requestProcessStep3,
      l10n.requestProcessStep4,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.requestProcessTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(steps.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    steps[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // Helper method for displaying certificate info
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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

  // Helper methods
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
        return 'Low Assurance Level';
      case EidasLevel.substantial:
        return 'Substantial Assurance Level';
      case EidasLevel.high:
        return 'High Assurance Level';
    }
  }

  // Start the renewal process
  Future<void> _startRenewalProcess(AppLocalizations l10n) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the verification provider to start a renewal
      await ref.read(verificationNotifierProvider.notifier).startRenewal(
            identityAddress:
                ref.read(identityNotifierProvider).identity!.identityAddress,
            previousCertificateId: widget.certificate?.id,
          );

      // Get the verification process
      final verificationProcess =
          ref.read(verificationNotifierProvider).verificationProcess;

      if (verificationProcess == null) {
        throw Exception('Failed to initialize verification process');
      }

      // Navigate to the verification process screen
      if (mounted) {
        final queryParams = <String, String>{};

        // Convert complex object to simple string parameters

        await context.pushNamed(
          'verificationProcess',
          pathParameters: {'processIdentifier': 'renewal'},
          queryParameters: queryParams,
        );
      }
    } catch (e) {
      // Show error with more descriptive message
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.renewalFailed}($e)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
