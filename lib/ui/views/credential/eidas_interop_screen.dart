import 'package:did_app/application/credential/eidas_provider.dart';
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/credential_detail_screen.dart';
import 'package:did_app/ui/views/credential/eidas_trust_registry_screen.dart';
import 'package:did_app/ui/views/credential/eidas_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran pour gérer l'interopérabilité avec eIDAS et l'EUDI Wallet
class EidasInteropScreen extends ConsumerStatefulWidget {
  const EidasInteropScreen({super.key});

  @override
  ConsumerState<EidasInteropScreen> createState() => _EidasInteropScreenState();
}

class _EidasInteropScreenState extends ConsumerState<EidasInteropScreen> {
  Credential? _selectedCredential;
  final TextEditingController _jsonController = TextEditingController();

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eidasState = ref.watch(eidasNotifierProvider);
    final credentialState = ref.watch(credentialNotifierProvider);
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    // Liste des attestations compatibles eIDAS
    final eidasCompatibleCredentials = credentialState.credentials
        .where(
          (credential) => ref
              .read(eidasNotifierProvider.notifier)
              .isEidasCompatible(credential),
        )
        .toList();

    // Liste des attestations qui peuvent être rendues compatibles
    final convertibleCredentials = credentialState.credentials
        .where(
          (credential) => !ref
              .read(eidasNotifierProvider.notifier)
              .isEidasCompatible(credential),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.eidasTrustRegistryTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.verified_user),
            tooltip: l10n.aboutRegistryTooltip,
            onPressed: _openTrustRegistry,
          ),
        ],
      ),
      body: eidasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(l10n),
                  const SizedBox(height: 24),
                  if (eidasState.errorMessage != null)
                    _buildErrorMessage(eidasState.errorMessage!),
                  const SizedBox(height: 16),
                  _buildRegistryAndSyncSection(eidasState, l10n),
                  const SizedBox(height: 16),
                  if (eidasState.isEudiWalletAvailable)
                    _buildEudiWalletSection(eidasCompatibleCredentials, l10n),
                  const SizedBox(height: 24),
                  _buildEidasCompatibleCredentialsSection(
                    eidasCompatibleCredentials,
                    l10n,
                  ),
                  const SizedBox(height: 24),
                  _buildConvertibleCredentialsSection(
                    convertibleCredentials,
                    l10n,
                  ),
                  const SizedBox(height: 24),
                  _buildImportExportSection(l10n),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.eidasTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.eidasDescription,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistryAndSyncSection(
    EidasState eidasState,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.eidasTrustRegistryTitle),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
          child: Text(
            // TODO: Localize
            'Synchronize with the official EU trust registry to verify issuers.',
            // l10n.eidasTrustRegistryDescription,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.verified_user),
                title: Text(l10n.eidasTrustRegistryTitle),
                subtitle: Text(
                  eidasState.lastSyncDate != null
                      ? '${l10n.lastSynchronization}: ${_formatDate(eidasState.lastSyncDate!)}'
                      : l10n.neverSynchronized,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _openTrustRegistry,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _syncTrustRegistry,
                        icon: const Icon(Icons.sync),
                        label: Text(l10n.synchronizeWithEuRegistry),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildEudiWalletSection(
    List<Credential> compatibleCredentials,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'EUDI Wallet',
        ), // TODO: Localize (l10n.eudiWalletSectionTitle)
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
          child: Text(
            // TODO: Localize
            'Interact with your European Digital Identity Wallet (EUDI Wallet). Note: Simulated functionality.',
            // l10n.eudiWalletSectionDescription,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: Icon(Icons.wallet),
                title: Text(
                  'EUDI Wallet Interaction',
                ), // TODO: Localize (l10n.eudiWalletInteractionTitle)
                subtitle: Text(
                  'Import from or share credentials with the EUDI Wallet.',
                ), // TODO: Localize (l10n.eudiWalletInteractionDesc)
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _importFromEudiWallet,
                      icon: const Icon(Icons.download),
                      label: Text(l10n.importButton),
                    ),
                    if (_selectedCredential != null)
                      ElevatedButton.icon(
                        onPressed: () =>
                            _shareWithEudiWallet(_selectedCredential!),
                        icon: const Icon(Icons.upload),
                        label: Text(l10n.shareButton),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEidasCompatibleCredentialsSection(
    List<Credential> compatibleCredentials,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'eIDAS Compatible Credentials',
        ), // TODO: Localize (l10n.eidasCompatibleCredentialsTitle)
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
          child: Text(
            // TODO: Localize
            'These credentials are already in a format recognized by the eIDAS framework.',
            // l10n.eidasCompatibleCredentialsDescription,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        if (compatibleCredentials.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                l10n.credentialNotFound,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
        else
          AppCard(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: compatibleCredentials.length,
                  itemBuilder: (context, index) {
                    final credential = compatibleCredentials[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.verified,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                            credential.name ?? l10n.defaultCredentialName,
                          ),
                          subtitle: Text(
                            l10n.issuedByPrefix + credential.issuer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.verified_user),
                                tooltip: l10n.verifyThisCredentialTooltip,
                                onPressed: () =>
                                    _openVerificationScreen(credential),
                              ),
                              Radio<Credential>(
                                value: credential,
                                groupValue: _selectedCredential,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCredential = value;
                                  });
                                },
                              ),
                            ],
                          ),
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
                        ),
                        if (index < compatibleCredentials.length - 1)
                          const Divider(height: 1),
                      ],
                    );
                  },
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: compatibleCredentials.isNotEmpty
                            ? () {
                                _verifyCredentialCompatibility(
                                  compatibleCredentials.first,
                                );
                              }
                            : null,
                        icon: const Icon(Icons.security),
                        label: Text(l10n.verifyEidasCompatibilityButton),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildConvertibleCredentialsSection(
    List<Credential> convertibleCredentials,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Convertible Credentials',
        ), // TODO: Localize (l10n.eidasConvertibleCredentialsTitle)
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
          child: Text(
            // TODO: Localize
            'These credentials can be converted to the eIDAS format for better interoperability.',
            // l10n.eidasConvertibleCredentialsDescription,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        if (convertibleCredentials.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                l10n.credentialNotFound,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
        else
          AppCard(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: convertibleCredentials.length,
                  itemBuilder: (context, index) {
                    final credential = convertibleCredentials[index];
                    return ListTile(
                      title:
                          Text(credential.name ?? l10n.defaultCredentialName),
                      subtitle: Text(
                        credential.issuer,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.euro),
                        onPressed: () => _convertToEidas(credential),
                        tooltip: l10n.convertToEidasTooltip,
                      ),
                      onTap: () => _selectCredential(credential),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: _selectedCredential != null
                        ? () {
                            _verifyCredentialCompatibility(
                              _selectedCredential!,
                            );
                          }
                        : null,
                    icon: const Icon(Icons.verified_user),
                    label: Text(l10n.verifyStatusButton),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildImportExportSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Manual Import/Export',
        ), // TODO: Localize (l10n.importExportSectionTitle)
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
          child: Text(
            // TODO: Localize
            'Manually import or export credentials in eIDAS-compatible JSON format.',
            // l10n.importExportSectionDescription,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _importCredential,
                      icon: const Icon(Icons.download),
                      label: Text(l10n.importButton),
                    ),
                    ElevatedButton.icon(
                      onPressed: _exportCredential,
                      icon: const Icon(Icons.upload),
                      label: Text(l10n.exportButton),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _syncTrustRegistry,
                  icon: const Icon(Icons.sync),
                  label: Text(l10n.synchronizeWithEuRegistry),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _selectCredential(Credential credential) {
    setState(() {
      _selectedCredential = credential;
    });
  }

  Future<void> _verifyCredentialCompatibility(Credential credential) async {
    try {
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EidasVerificationScreen(credential: credential),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _convertToEidas(Credential credential) async {
    try {
      final eidasCredential = await ref
          .read(eidasNotifierProvider.notifier)
          .makeEidasCompatible(credential);

      if (eidasCredential != null) {
        if (mounted) {
          final l10n =
              Localizations.of<AppLocalizations>(context, AppLocalizations)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.convertedToEidasMessage),
              backgroundColor: Colors.green,
            ),
          );

          // Refresh
          ref.refresh(eidasNotifierProvider);
          ref.refresh(credentialNotifierProvider);
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _importCredential() async {
    try {
      final success =
          await ref.read(eidasNotifierProvider.notifier).importFromEudiWallet();
      if (success != null && mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.credentialImportedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _exportCredential() async {
    if (_selectedCredential == null) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.credentialNotFound),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      final success = await ref
          .read(eidasNotifierProvider.notifier)
          .exportToJson(_selectedCredential!);
      if (success != null && mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.credentialExportedToEidas),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _shareWithEudiWallet(Credential credential) async {
    try {
      await ref
          .read(eidasNotifierProvider.notifier)
          .shareWithEudiWallet(credential);

      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.shareFunctionalityMessage),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _importFromEudiWallet() async {
    try {
      final success =
          await ref.read(eidasNotifierProvider.notifier).importFromEudiWallet();
      if (success != null && mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.credentialImportedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _syncTrustRegistry() async {
    try {
      await ref.read(eidasNotifierProvider.notifier).syncTrustRegistry();

      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.synchronizeWithEuRegistry),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n =
            Localizations.of<AppLocalizations>(context, AppLocalizations)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _openVerificationScreen(Credential credential) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EidasVerificationScreen(
          credential: credential,
        ),
      ),
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
}
