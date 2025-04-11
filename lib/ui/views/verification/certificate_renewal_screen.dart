import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate Renewal'),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Initializing renewal process...'),
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
                    ),
                  if (widget.certificate != null) const SizedBox(height: 24),

                  // Renewal explanation
                  _buildRenewalInfo(isExpired),
                  const SizedBox(height: 24),

                  // Renewal process steps
                  _buildRenewalSteps(),
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
                      'I understand that this will initiate a new verification process',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),

                  // Renewal button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _acceptTerms ? _startRenewalProcess : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Start Renewal Process'),
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
                    isExpired
                        ? 'Expired Certificate'
                        : 'Certificate Expiring Soon',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isExpired ? Colors.red : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Certificate ID', _truncateId(certificate.id)),
            _buildInfoRow(
              'Issued Date',
              _formatDate(certificate.issuedAt),
            ),
            _buildInfoRow(
              'Expiry Date',
              _formatDate(certificate.expiresAt),
            ),
            _buildInfoRow(
              'eIDAS Level',
              _getEidasLevelText(certificate.eidasLevel),
            ),
          ],
        ),
      ),
    );
  }

  // Renewal explanation
  Widget _buildRenewalInfo(bool isExpired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpired
              ? 'Your Certificate Has Expired'
              : 'Renew Your Certificate Before It Expires',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isExpired
              ? 'Your identity verification certificate has expired. To continue using your digital identity for services that require verification, you need to renew your certificate.'
              : 'Renewing your certificate before it expires ensures continuous access to services that require identity verification.',
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
                const Expanded(
                  child: Text(
                    'The renewal process is streamlined for existing users. '
                    "Some of your information may be pre-filled, but you'll still need to verify your identity.",
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
  Widget _buildRenewalSteps() {
    final steps = [
      'Start the renewal process',
      'Verify your identity',
      'Submit required documents (if needed)',
      'Wait for verification approval',
      'Receive your renewed certificate',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Renewal Process',
          style: TextStyle(
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
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _getEidasLevelText(EidasLevel level) {
    switch (level) {
      case EidasLevel.low:
        return 'Low Assurance';
      case EidasLevel.substantial:
        return 'Substantial Assurance';
      case EidasLevel.high:
        return 'High Assurance';
    }
  }

  // Start the renewal process
  Future<void> _startRenewalProcess() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the verification provider to start a renewal
      // In a real app, this would send the previous certificate ID to the backend
      await ref.read(verificationNotifierProvider.notifier).startRenewal(
            previousCertificateId: widget.certificate?.id,
          );

      // Navigate to the verification process screen
      if (mounted) {
        await context.pushNamed(
          'verificationProcess',
          pathParameters: {'processIdentifier': 'renewal'},
          queryParameters: ref
                  .read(verificationNotifierProvider)
                  .verificationProcess
                  ?.toJson() ??
              {},
        );
      }
    } catch (e) {
      // Show error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start renewal: $e'),
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
