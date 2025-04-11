import 'package:did_app/application/verification/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verificationBottomNavLabel),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.verificationInProgress),
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
                    _buildIntro(l10n),
                    const SizedBox(height: 24),

                    // Verification level selection
                    _buildVerificationLevelSelection(l10n),
                    const SizedBox(height: 32),

                    // Required documents
                    _buildRequiredDocumentsSection(l10n),
                    const SizedBox(height: 32),

                    // Terms and conditions checkbox
                    _buildTermsAndConditions(l10n),
                    const SizedBox(height: 32),

                    // Start button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _acceptedTerms
                            ? () => _startVerification(l10n)
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(l10n.startVerificationButtonMain),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Introduction and description
  Widget _buildIntro(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.digitalIdentityTitle,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.digitalIdentityDescription,
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
                    l10n.securityDescription,
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
  Widget _buildVerificationLevelSelection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.eidasLevelLabel,
          style: const TextStyle(
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
                  title: l10n.eidasLevelLowLabel,
                  subtitle: l10n.eidasLevelLowDescription,
                  level: VerificationLevel.basic,
                  eidasLevel: l10n.eidasLevelLow,
                  l10n: l10n,
                ),
                const Divider(),
                _buildLevelOption(
                  title: l10n.eidasLevelSubstantialLabel,
                  subtitle: l10n.eidasLevelSubstantialDescription,
                  level: VerificationLevel.standard,
                  eidasLevel: l10n.eidasLevelSubstantial,
                  l10n: l10n,
                ),
                const Divider(),
                _buildLevelOption(
                  title: l10n.eidasLevelHighLabel,
                  subtitle: l10n.eidasLevelHighDescription,
                  level: VerificationLevel.advanced,
                  eidasLevel: l10n.eidasLevelHigh,
                  l10n: l10n,
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
    required AppLocalizations l10n,
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
  Widget _buildRequiredDocumentsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.documentsSection,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Documents list based on selected level
        ..._getRequiredDocuments(l10n).map(
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
  Widget _buildTermsAndConditions(AppLocalizations l10n) {
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
        'I agree to the terms and privacy policy',
      ),
      subtitle: GestureDetector(
        onTap: () => _showTermsAndConditions(l10n),
        child: Text(
          l10n.aboutRegistryTitle,
          style: const TextStyle(
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
  List<String> _getRequiredDocuments(AppLocalizations l10n) {
    final documents = <String>[];
    // Common documents for all levels
    documents.add('Email Verification');
    documents.add('Phone Number');

    if (_selectedLevel == VerificationLevel.standard ||
        _selectedLevel == VerificationLevel.advanced) {
      documents.add('Government ID (Passport, National ID)');
      documents.add('Proof of Address');
    }

    if (_selectedLevel == VerificationLevel.advanced) {
      documents.add('Biometric Verification');
    }

    return documents;
  }

  // Show terms and conditions dialog
  void _showTermsAndConditions(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.aboutRegistryTitle),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.aboutEidasTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.eidasInteropDescription,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.trustRegistryTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.eidasTrustRegistryDescription,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.securityDescription,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.reliabilityDescription,
              ),
            ],
          ),
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

  // Start verification process
  Future<void> _startVerification(AppLocalizations l10n) async {
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

      final verificationProcess =
          ref.read(verificationNotifierProvider).verificationProcess;

      // Navigate to verification process screen
      if (mounted && verificationProcess != null) {
        // Convert process to a Map of string key-value pairs for query parameters
        final queryParams = <String, String>{
          'level': _selectedLevel.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };

        await context.pushNamed(
          'verificationProcess',
          pathParameters: {'processIdentifier': 'latest'},
          queryParameters: queryParams,
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorOccurredMessage(e.toString())),
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
