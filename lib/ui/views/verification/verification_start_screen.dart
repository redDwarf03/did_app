import 'package:did_app/application/verification/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen to start a new identity verification process
class VerificationStartScreen extends ConsumerStatefulWidget {
  const VerificationStartScreen({super.key});

  @override
  ConsumerState<VerificationStartScreen> createState() =>
      _VerificationStartScreenState();
}

class _VerificationStartScreenState
    extends ConsumerState<VerificationStartScreen> {
  // Form key to validate inputs
  final _formKey = GlobalKey<FormState>();

  // Step state
  bool _acceptedTerms = false;
  bool _isLoading = false;
  VerificationLevel _selectedLevel = VerificationLevel.standard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Verification'),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Initializing verification process...'),
                ],
              ),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Intro section
                    _buildIntro(),
                    const SizedBox(height: 24),

                    // Verification level selection
                    _buildVerificationLevelSelection(),
                    const SizedBox(height: 32),

                    // Required documents
                    _buildRequiredDocumentsSection(),
                    const SizedBox(height: 32),

                    // Terms and conditions checkbox
                    _buildTermsAndConditions(),
                    const SizedBox(height: 32),

                    // Start button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _acceptedTerms ? _startVerification : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Start Verification Process'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Introduction and description
  Widget _buildIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Identity Verification',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Complete the verification process to prove your identity on the Archethic blockchain. '
          'This verification complies with KYC/AML regulations and eIDAS 2.0 standards.',
          style: TextStyle(fontSize: 16),
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
                    'Your data is encrypted and securely stored on the blockchain. '
                    'You maintain full control over your information.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Verification level selection
  Widget _buildVerificationLevelSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Verification Level',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                _buildLevelOption(
                  title: 'Basic Verification',
                  subtitle: 'Email and phone verification only',
                  level: VerificationLevel.basic,
                  eidasLevel: 'eIDAS Low',
                ),
                const Divider(),
                _buildLevelOption(
                  title: 'Standard Verification',
                  subtitle: 'ID document and address verification',
                  level: VerificationLevel.standard,
                  eidasLevel: 'eIDAS Substantial',
                ),
                const Divider(),
                _buildLevelOption(
                  title: 'Advanced Verification',
                  subtitle: 'Includes biometric verification',
                  level: VerificationLevel.advanced,
                  eidasLevel: 'eIDAS High',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Single verification level option
  Widget _buildLevelOption({
    required String title,
    required String subtitle,
    required VerificationLevel level,
    required String eidasLevel,
  }) {
    final isSelected = _selectedLevel == level;

    return RadioListTile<VerificationLevel>(
      value: level,
      groupValue: _selectedLevel,
      onChanged: (VerificationLevel? value) {
        if (value != null) {
          setState(() {
            _selectedLevel = value;
          });
        }
      },
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              eidasLevel,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade300,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(subtitle),
      secondary: Icon(
        _getLevelIcon(level),
        color: isSelected ? Colors.blue : Colors.grey,
      ),
      activeColor: Colors.blue,
      selected: isSelected,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    );
  }

  // Required documents section
  Widget _buildRequiredDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required Documents',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Documents list based on selected level
        ..._getRequiredDocuments().map(
          (document) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(document)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Terms and conditions
  Widget _buildTermsAndConditions() {
    return CheckboxListTile(
      value: _acceptedTerms,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _acceptedTerms = value;
          });
        }
      },
      title: const Text(
        'I agree to the terms and conditions of the verification process',
      ),
      subtitle: GestureDetector(
        onTap: _showTermsAndConditions,
        child: const Text(
          'View terms and privacy policy',
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  // Get icon for verification level
  IconData _getLevelIcon(VerificationLevel level) {
    switch (level) {
      case VerificationLevel.basic:
        return Icons.verified_user;
      case VerificationLevel.standard:
        return Icons.shield;
      case VerificationLevel.advanced:
        return Icons.security;
    }
  }

  // Get required documents based on selected level
  List<String> _getRequiredDocuments() {
    switch (_selectedLevel) {
      case VerificationLevel.basic:
        return [
          'Valid email address',
          'Mobile phone for SMS verification',
        ];
      case VerificationLevel.standard:
        return [
          'Valid email address',
          'Mobile phone for SMS verification',
          "Government-issued ID (passport, driver's license, or national ID)",
          'Proof of address (utility bill, bank statement, etc.)',
        ];
      case VerificationLevel.advanced:
        return [
          'Valid email address',
          'Mobile phone for SMS verification',
          "Government-issued ID (passport, driver's license, or national ID)",
          'Proof of address (utility bill, bank statement, etc.)',
          'Selfie or video for biometric verification',
        ];
    }
  }

  // Show terms and conditions dialog
  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Privacy Policy'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'By using this verification service, you agree to provide accurate and truthful information. '
                'False information may result in rejection of your verification.',
              ),
              SizedBox(height: 16),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your information is securely stored on the Archethic blockchain using encryption. '
                'You retain control over your data and can revoke access at any time. '
                'We collect only the information necessary for identity verification purposes.',
              ),
              SizedBox(height: 16),
              Text(
                'Data Sharing',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your data will only be shared with authorized verifiers when you explicitly consent. '
                'All data sharing is recorded on the blockchain for transparency.',
              ),
            ],
          ),
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

  // Start verification process
  Future<void> _startVerification() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Start the verification process
      await ref
          .read(verificationNotifierProvider.notifier)
          .startVerificationWithLevel(_selectedLevel);

      // Navigate to verification process screen
      if (mounted) {
        await context.pushNamed(
          'verificationProcess',
          pathParameters: {'processIdentifier': 'latest'},
          queryParameters: ref
                  .read(verificationNotifierProvider)
                  .verificationProcess
                  ?.toJson() ??
              {},
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start verification: $e'),
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

/// Verification level enum
enum VerificationLevel {
  basic,
  standard,
  advanced,
}
