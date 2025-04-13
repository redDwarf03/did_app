import 'package:did_app/application/credential/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen for adding a new credential to the wallet
class AddCredentialScreen extends ConsumerStatefulWidget {
  const AddCredentialScreen({super.key});

  @override
  ConsumerState<AddCredentialScreen> createState() =>
      _AddCredentialScreenState();
}

class _AddCredentialScreenState extends ConsumerState<AddCredentialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _issuerUrlController = TextEditingController();
  bool _isLoading = false;
  bool _showHelp = false;

  @override
  void dispose() {
    _issuerUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addCredentialTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: l10n.aboutCredentialsTooltip,
            onPressed: () {
              setState(() {
                _showHelp = !_showHelp;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Help section
              if (_showHelp) _buildHelpSection(l10n),

              // Description
              Text(
                l10n.noCredentialsMessage,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Issuer URL input
              TextFormField(
                controller: _issuerUrlController,
                decoration: InputDecoration(
                  labelText: l10n.issuerLabel,
                  hintText: l10n.credentialIssuerUrl,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.link),
                  helperText: l10n.credentialIssuerUrlHelper,
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.issuerValidationError;
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Request button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _requestCredential,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add),
                  label: Text(
                    _isLoading
                        ? l10n.verificationInProgress
                        : l10n.requestButton,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Example issuers section
              _buildExampleIssuers(l10n),
            ],
          ),
        ),
      ),
    );
  }

  // Help section with information about credentials
  Widget _buildHelpSection(AppLocalizations l10n) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.understandCredentialTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.whatIsDigitalCredentialTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.whatIsDigitalCredentialContent),
            const SizedBox(height: 16),
            Text(
              l10n.containedInformationTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.containedInformationContent),
          ],
        ),
      ),
    );
  }

  // Example issuers section
  Widget _buildExampleIssuers(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.trustedIssuersTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.school, color: Colors.white),
            ),
            title: Text(l10n.universityDiploma),
            subtitle: Text(l10n.universityDiplomaUrl),
            onTap: () {
              _issuerUrlController.text =
                  'https://example.university.edu/credentials';
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.business, color: Colors.white),
            ),
            title: Text(l10n.employmentCertificate),
            subtitle: Text(l10n.employmentCertificateUrl),
            onTap: () {
              _issuerUrlController.text =
                  'https://example.employer.com/credentials';
            },
          ),
        ),
      ],
    );
  }

  /// Request a credential from the issuer
  Future<void> _requestCredential() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Show success message
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.credentialReceivedMessage),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () {
                  // Navigate to the credential details in a real app
                },
              ),
            ),
          );

          // Navigate back to credentials list
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorMessage(e.toString())),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
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
}
