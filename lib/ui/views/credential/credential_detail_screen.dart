import 'package:did_app/application/credential/eidas_provider.dart';
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/credential_certificate_screen.dart';
import 'package:did_app/ui/views/credential/credential_presentation_screen.dart';
import 'package:did_app/ui/views/credential/credential_status_verification_screen.dart';
import 'package:did_app/ui/views/credential/eidas_interop_screen.dart';
import 'package:did_app/ui/views/credential/revocation_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Extensions to add useful methods to Credential
extension CredentialExtension on Credential {
  /// Checks if the credential is revoked
  bool get isRevoked => false; // To be implemented with revocation data

  /// Checks if the credential is valid (not expired)
  bool get isValid =>
      expirationDate == null || expirationDate!.isAfter(DateTime.now());

  /// Checks if the credential is verified
  bool get isVerified => proof.isNotEmpty;
}

/// Screen displaying the details of a verifiable credential
class CredentialDetailScreen extends ConsumerWidget {
  const CredentialDetailScreen({
    super.key,
    required this.credentialId,
  });

  final String credentialId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentialAsync = ref.watch(credentialByIdProvider(credentialId));
    final eidasNotifier = ref.watch(eidasNotifierProvider.notifier);
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialDetailTitle),
        actions: [
          // Action to convert to eIDAS format
          credentialAsync.maybeWhen(
            data: (credential) {
              if (credential != null) {
                // If the credential is already eIDAS compatible, display a badge
                if (eidasNotifier.isEidasCompatible(credential)) {
                  return Tooltip(
                    message: l10n.eidasCompatibleTooltip,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.euro_symbol,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                } else {
                  // Otherwise, display a button to convert
                  return IconButton(
                    icon: const Icon(Icons.euro_symbol),
                    tooltip: l10n.convertToEidasTooltip,
                    onPressed: () =>
                        _convertToEidas(context, ref, credential, l10n),
                  );
                }
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: l10n.shareButtonLabel,
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.shareFunctionalityMessage),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.description),
            tooltip: l10n.viewCertificateTooltip,
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
            return Center(
              child: Text(l10n.credentialNotFound),
            );
          }
          return _buildCredentialDetails(context, credential, l10n);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(l10n.errorPrefix(error.toString())),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'helpFAB',
        onPressed: () => _showBeginnerHelp(context, l10n),
        tooltip: l10n.beginnerHelpTooltip,
        child: const Icon(Icons.help_outline),
      ),
      bottomNavigationBar: credentialAsync.maybeWhen(
        data: (credential) {
          if (credential == null) return null;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CredentialPresentationScreen(
                            credentialIds: [credential.id],
                          ),
                        ),
                      );
                    },
                    child: Text(l10n.createPresentationButton),
                  ),
                ),
                const SizedBox(width: 8),
                // Revocation management button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RevocationManagementScreen(
                            credentialId: credential.id,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.security),
                    label: Text(l10n.manageRevocationButton),
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

  // Method to convert a credential to eIDAS format
  Future<void> _convertToEidas(
    BuildContext context,
    WidgetRef ref,
    Credential credential,
    AppLocalizations l10n,
  ) async {
    final eidasNotifier = ref.read(eidasNotifierProvider.notifier);
    final credentialNotifier = ref.read(credentialNotifierProvider.notifier);

    try {
      final eidasCredential =
          await eidasNotifier.makeEidasCompatible(credential);
      if (eidasCredential != null) {
        // Update the credential
        final success = await credentialNotifier.addCredential(eidasCredential);

        if (context.mounted) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.convertedToEidasMessage),
                backgroundColor: Colors.green,
              ),
            );

            // Open eIDAS interoperability screen
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EidasInteropScreen(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.conversionErrorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildCredentialDetails(
    BuildContext context,
    Credential credential,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(context, credential, l10n),
          const SizedBox(height: 24),
          _buildGeneralInfoSection(context, credential, l10n),
          const SizedBox(height: 24),
          _buildCredentialSubjectSection(context, credential, l10n),
          const SizedBox(height: 24),
          _buildProofSection(context, credential.proof, l10n),
          const SizedBox(height: 16),
          _buildActionsCard(context, l10n),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    Credential credential,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (credential.isRevoked) {
      statusColor = Colors.red;
      statusText = l10n.revokedStatus;
      statusIcon = Icons.gpp_bad;
    } else if (!credential.isValid) {
      statusColor = Colors.orange;
      statusText = l10n.expiredStatus;
      statusIcon = Icons.warning;
    } else if (credential.isVerified) {
      statusColor = Colors.green;
      statusText = l10n.verifiedStatus;
      statusIcon = Icons.verified;
    } else {
      statusColor = Colors.grey;
      statusText = l10n.notVerifiedStatus;
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

  Widget _buildGeneralInfoSection(
    BuildContext context,
    Credential credential,
    AppLocalizations l10n,
  ) {
    Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.generalInformationSection),
        AppCard(
          child: Column(
            children: [
              _buildInfoRow(
                context,
                l10n.issuerLabel,
                credential.issuer,
                Icons.business,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                l10n.issuanceDateLabel,
                dateFormat.format(credential.issuanceDate),
                Icons.calendar_today,
              ),
              if (credential.expirationDate != null) ...[
                const Divider(),
                _buildInfoRow(
                  context,
                  l10n.expirationDateLabel,
                  dateFormat.format(credential.expirationDate!),
                  Icons.event_busy,
                ),
              ],
              const Divider(),
              _buildInfoRow(
                context,
                l10n.identifierLabel,
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
    BuildContext context,
    Credential credential,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: credential.credentialSubject.entries.map((entry) {
        // Skip the id field as it's already displayed
        if (entry.key == 'id') return const SizedBox.shrink();

        return Column(
          children: [
            _buildInfoRow(
              context,
              _formatKey(entry.key),
              _formatValue(context, entry.value, l10n),
              Icons.assignment,
            ),
            if (entry.key != credential.credentialSubject.keys.last)
              const Divider(),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildProofSection(
    BuildContext context,
    Map<String, dynamic> proof,
    AppLocalizations l10n,
  ) {
    final created = proof['created'] != null
        ? DateTime.tryParse(proof['created'].toString()) ?? DateTime.now()
        : DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.cryptographicProofSection),
        AppCard(
          child: Column(
            children: [
              _buildInfoRow(
                context,
                l10n.proofTypeLabel,
                proof['type']?.toString() ?? l10n.unspecified,
                Icons.security,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                l10n.proofCreatedLabel,
                dateFormat.format(created),
                Icons.access_time,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                l10n.proofPurposeLabel,
                proof['proofPurpose']?.toString() ?? l10n.unspecified,
                Icons.check_circle,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                l10n.proofMethodLabel,
                proof['verificationMethod']?.toString() ?? l10n.unspecified,
                Icons.vpn_key,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(),
              _buildInfoRow(
                context,
                l10n.proofSignatureLabel,
                proof['proofValue']?.toString() ?? l10n.unspecified,
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
      RegExp('([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }

  String _formatValue(
    BuildContext context,
    dynamic value,
    AppLocalizations l10n,
  ) {
    if (value == null) return l10n.unspecified;
    if (value is DateTime) {
      return DateFormat('dd/MM/yyyy').format(value);
    }
    if (value is bool) {
      return value ? l10n.yesValue : l10n.noValue;
    }
    if (value is Map) {
      return value.toString();
    }
    if (value is List) {
      if (value.isEmpty) return l10n.emptyList;
      return value.map((e) => e.toString()).join(', ');
    }
    return value.toString();
  }

  Widget _buildActionsCard(BuildContext context, AppLocalizations l10n) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: l10n.actionsSection),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CredentialStatusVerificationScreen(
                          credentialId: credentialId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.verified_user),
                  label: Text(l10n.verifyStatusButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Share action
                  },
                  icon: const Icon(Icons.share),
                  label: Text(l10n.shareButton),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Shows beginner help explaining credentials
  void _showBeginnerHelp(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    l10n.understandCredentialTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildHelpSection(
                  context,
                  l10n.whatIsDigitalCredentialTitle,
                  l10n.whatIsDigitalCredentialContent,
                  Icons.badge,
                ),
                _buildHelpSection(
                  context,
                  l10n.containedInformationTitle,
                  l10n.containedInformationContent,
                  Icons.verified_user,
                ),
                _buildHelpSection(
                  context,
                  l10n.expirationDateTitle,
                  l10n.expirationDateContent,
                  Icons.calendar_today,
                ),
                _buildHelpSection(
                  context,
                  l10n.eidasAssuranceLevelTitle,
                  l10n.eidasAssuranceLevelContent,
                  Icons.security,
                ),
                _buildHelpSection(
                  context,
                  l10n.howToUseCredentialTitle,
                  l10n.howToUseCredentialContent,
                  Icons.share,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(l10n.iUnderstandButton),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a help section with title, content, and icon
  Widget _buildHelpSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
