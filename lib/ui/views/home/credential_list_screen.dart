import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/ui/views/credential/add_credential_screen.dart';
import 'package:did_app/ui/views/credential/credential_detail_screen.dart';
import 'package:did_app/ui/views/credential/credential_status_screen.dart';
import 'package:did_app/ui/views/credential/widgets/credential_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CredentialListScreen extends ConsumerWidget {
  const CredentialListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentialsAsync = ref.watch(credentialsProvider);
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refreshTooltip,
            onPressed: () {
              ref.refresh(credentialsProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: l10n.aboutCredentialsTooltip,
            onPressed: () {
              _showCredentialInfo(context, l10n);
            },
          ),
        ],
      ),
      body: credentialsAsync.when(
        data: (credentials) {
          if (credentials.isEmpty) {
            return _buildEmptyState(context, l10n);
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: credentials.length,
              itemBuilder: (context, index) {
                final credential = credentials[index];
                return CredentialCard(
                  credential: credential,
                  compact: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CredentialDetailScreen(
                          credentialId: credential.id,
                        ),
                      ),
                    );
                  },
                  onVerify: () {
                    ref
                        .read(credentialNotifierProvider.notifier)
                        .verifyCredential(credential.id);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                l10n.errorOccurredMessage(error.toString()),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(credentialsProvider);
                },
                child: Text(l10n.retryButton),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'status_button',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CredentialStatusScreen(),
                ),
              );
            },
            tooltip: l10n.verifyStatusButton,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: const Icon(Icons.verified_user),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'add_button',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCredentialScreen(),
                ),
              );
            },
            tooltip: l10n.addCredentialButton,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.badge_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noCredentials,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noCredentialsMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCredentialScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.requestCredentialButton),
            ),
          ],
        ),
      ),
    );
  }

  void _showCredentialInfo(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.understandCredentialTitle),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoSection(
                l10n.whatIsDigitalCredentialTitle,
                l10n.whatIsDigitalCredentialContent,
              ),
              const SizedBox(height: 16),
              _buildInfoSection(
                l10n.containedInformationTitle,
                l10n.containedInformationContent,
              ),
              const SizedBox(height: 16),
              _buildInfoSection(
                l10n.expirationDateTitle,
                l10n.expirationDateContent,
              ),
              const SizedBox(height: 16),
              _buildInfoSection(
                l10n.howToUseCredentialTitle,
                l10n.howToUseCredentialContent,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(content),
      ],
    );
  }
}
