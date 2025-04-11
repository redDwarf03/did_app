import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/credential_certificate_screen.dart';

/// Écran affichant les détails d'une attestation vérifiable
class CredentialDetailScreen extends ConsumerWidget {
  const CredentialDetailScreen({
    super.key,
    required this.credentialId,
  });

  final String credentialId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentialAsync = ref.watch(credentialByIdProvider(credentialId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'attestation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité de partage à venir'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.description),
            tooltip: 'Voir le certificat',
            onPressed: () {
              credentialAsync.whenData((credential) {
                if (credential != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CredentialCertificateScreen(
                        credential: credential,
                      ),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: credentialAsync.when(
        data: (credential) {
          if (credential == null) {
            return const Center(
              child: Text('Attestation non trouvée'),
            );
          }
          return _buildCredentialDetails(context, credential);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Erreur: $error'),
        ),
      ),
      bottomNavigationBar: credentialAsync.maybeWhen(
        data: (credential) {
          if (credential == null) return null;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to presentation screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Écran de présentation à venir'),
                        ),
                      );
                    },
                    child: const Text('Créer une présentation'),
                  ),
                ),
              ],
            ),
          );
        },
        orElse: () => null,
      ),
    );
  }

  Widget _buildCredentialDetails(BuildContext context, Credential credential) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(context, credential),
          const SizedBox(height: 24),
          _buildGeneralInfoSection(context, credential),
          const SizedBox(height: 24),
          _buildCredentialSubjectSection(context, credential),
          const SizedBox(height: 24),
          if (credential.proof != null)
            _buildProofSection(context, credential.proof!),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, Credential credential) {
    final theme = Theme.of(context);

    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (credential.isRevoked) {
      statusColor = Colors.red;
      statusText = 'Révoquée';
      statusIcon = Icons.gpp_bad;
    } else if (!credential.isValid) {
      statusColor = Colors.orange;
      statusText = 'Expirée';
      statusIcon = Icons.warning;
    } else if (credential.isVerified) {
      statusColor = Colors.green;
      statusText = 'Vérifiée';
      statusIcon = Icons.verified;
    } else {
      statusColor = Colors.grey;
      statusText = 'Non vérifiée';
      statusIcon = Icons.gpp_maybe;
    }

    return AppCard(
      child: ListTile(
        leading: Icon(
          statusIcon,
          color: statusColor,
          size: 48,
        ),
        title: Text(
          statusText,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          credential.type.join(', '),
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildGeneralInfoSection(BuildContext context, Credential credential) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Informations générales'),
        AppCard(
          child: Column(
            children: [
              _buildInfoRow(
                context,
                'Émetteur',
                credential.issuer,
                Icons.business,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                'Date d\'émission',
                dateFormat.format(credential.issuanceDate),
                Icons.calendar_today,
              ),
              if (credential.expirationDate != null) ...[
                const Divider(),
                _buildInfoRow(
                  context,
                  'Date d\'expiration',
                  dateFormat.format(credential.expirationDate!),
                  Icons.event_busy,
                ),
              ],
              const Divider(),
              _buildInfoRow(
                context,
                'Identifiant',
                credential.id,
                Icons.fingerprint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialSubjectSection(
      BuildContext context, Credential credential) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Données de l\'attestation'),
        AppCard(
          child: Column(
            children: credential.credentialSubject.entries.map((entry) {
              // Skip the id field as it's already displayed
              if (entry.key == 'id') return const SizedBox.shrink();

              return Column(
                children: [
                  _buildInfoRow(
                    context,
                    _formatKey(entry.key),
                    _formatValue(entry.value),
                    Icons.assignment,
                  ),
                  if (entry.key != credential.credentialSubject.keys.last)
                    const Divider(),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProofSection(BuildContext context, CredentialProof proof) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Preuve cryptographique'),
        AppCard(
          child: Column(
            children: [
              _buildInfoRow(
                context,
                'Type',
                proof.type,
                Icons.security,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                'Créée le',
                dateFormat.format(proof.created),
                Icons.access_time,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                'Objectif',
                proof.proofPurpose,
                Icons.check_circle,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                'Méthode',
                proof.verificationMethod,
                Icons.vpn_key,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                'Signature',
                proof.proofValue,
                Icons.fingerprint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium,
                  maxLines: maxLines,
                  overflow: overflow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    // Convert camelCase to words with spaces and capitalize first letter
    final result = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'Non spécifié';
    if (value is DateTime) {
      return DateFormat('dd/MM/yyyy').format(value);
    }
    if (value is bool) {
      return value ? 'Oui' : 'Non';
    }
    if (value is Map || value is List) {
      return value.toString();
    }
    return value.toString();
  }
}
