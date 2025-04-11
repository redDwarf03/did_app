import 'package:did_app/application/credential/eidas_provider.dart';
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/views/credential/credential_detail_screen.dart';
import 'package:flutter/material.dart';
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

    // Liste des attestations compatibles eIDAS
    final eidasCompatibleCredentials = credentialState.credentials
        .where((credential) => ref
            .read(eidasNotifierProvider.notifier)
            .isEidasCompatible(credential))
        .toList();

    // Liste des attestations qui peuvent être rendues compatibles
    final convertibleCredentials = credentialState.credentials
        .where((credential) => !ref
            .read(eidasNotifierProvider.notifier)
            .isEidasCompatible(credential))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('eIDAS 2.0 & EUDI Wallet'),
      ),
      body: eidasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  if (eidasState.errorMessage != null)
                    _buildErrorMessage(eidasState.errorMessage!),
                  const SizedBox(height: 16),
                  if (eidasState.isEudiWalletAvailable)
                    _buildEudiWalletSection(eidasCompatibleCredentials),
                  const SizedBox(height: 24),
                  _buildEidasCompatibleCredentialsSection(
                      eidasCompatibleCredentials),
                  const SizedBox(height: 24),
                  _buildConvertibleCredentialsSection(convertibleCredentials),
                  const SizedBox(height: 24),
                  _buildImportExportSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interopérabilité eIDAS 2.0',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Cet écran permet d\'importer et d\'exporter des attestations au format eIDAS 2.0, '
          'compatible avec la réglementation européenne sur l\'identité numérique.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
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

  Widget _buildEudiWalletSection(List<Credential> compatibleCredentials) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'EUDI Wallet'),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: Icon(Icons.wallet),
                title: Text('European Digital Identity Wallet'),
                subtitle: Text(
                    'Partagez vos attestations avec l\'EUDI Wallet ou importez-en depuis celui-ci'),
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
                      label: const Text('Importer depuis\nEUDI Wallet'),
                    ),
                    if (_selectedCredential != null)
                      ElevatedButton.icon(
                        onPressed: () =>
                            _shareWithEudiWallet(_selectedCredential!),
                        icon: const Icon(Icons.upload),
                        label: const Text('Partager avec\nEUDI Wallet'),
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
      List<Credential> compatibleCredentials) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Attestations compatibles eIDAS'),
        if (compatibleCredentials.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Aucune attestation compatible eIDAS disponible',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
        else
          AppCard(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: compatibleCredentials.length,
              itemBuilder: (context, index) {
                final credential = compatibleCredentials[index];
                return ListTile(
                  leading: Icon(
                    Icons.verified,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(credential.name ?? 'Attestation'),
                  subtitle: Text(
                    'Émise par ${credential.issuer}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Radio<Credential>(
                    value: credential,
                    groupValue: _selectedCredential,
                    onChanged: (value) {
                      setState(() {
                        _selectedCredential = value;
                      });
                    },
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
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildConvertibleCredentialsSection(
      List<Credential> convertibleCredentials) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Attestations convertibles'),
        if (convertibleCredentials.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Aucune attestation convertible disponible',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
        else
          AppCard(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: convertibleCredentials.length,
              itemBuilder: (context, index) {
                final credential = convertibleCredentials[index];
                return ListTile(
                  leading: Icon(
                    Icons.transform,
                    color: Colors.orange,
                  ),
                  title: Text(credential.name ?? 'Attestation'),
                  subtitle: Text(
                    'Émise par ${credential.issuer}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: TextButton(
                    onPressed: () => _convertToEidas(credential),
                    child: const Text('Convertir'),
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
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildImportExportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Import / Export JSON'),
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _jsonController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'JSON eIDAS',
                    hintText:
                        'Collez ici le JSON d\'une attestation eIDAS ou exportez une attestation sélectionnée',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _jsonController.text.isNotEmpty
                          ? _importFromJson
                          : null,
                      icon: const Icon(Icons.download),
                      label: const Text('Importer'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _selectedCredential != null
                          ? () => _exportToJson(_selectedCredential!)
                          : null,
                      icon: const Icon(Icons.upload),
                      label: const Text('Exporter'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _importFromJson() async {
    if (_jsonController.text.isEmpty) return;

    final credential = await ref
        .read(eidasNotifierProvider.notifier)
        .importFromJson(_jsonController.text);

    if (credential != null) {
      await ref
          .read(credentialNotifierProvider.notifier)
          .addCredential(credential);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attestation importée avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _jsonController.clear();
        });
      }
    }
  }

  Future<void> _exportToJson(Credential credential) async {
    final json =
        await ref.read(eidasNotifierProvider.notifier).exportToJson(credential);

    if (json != null) {
      setState(() {
        _jsonController.text = json;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attestation exportée au format eIDAS 2.0'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _convertToEidas(Credential credential) async {
    final convertedCredential = await ref
        .read(eidasNotifierProvider.notifier)
        .makeEidasCompatible(credential);

    if (convertedCredential != null) {
      await ref
          .read(credentialNotifierProvider.notifier)
          .addCredential(convertedCredential);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attestation convertie au format eIDAS 2.0'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _shareWithEudiWallet(Credential credential) async {
    final success = await ref
        .read(eidasNotifierProvider.notifier)
        .shareWithEudiWallet(credential);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attestation partagée avec l\'EUDI Wallet'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _importFromEudiWallet() async {
    final credential =
        await ref.read(eidasNotifierProvider.notifier).importFromEudiWallet();

    if (credential != null) {
      await ref
          .read(credentialNotifierProvider.notifier)
          .addCredential(credential);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attestation importée depuis l\'EUDI Wallet'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _selectedCredential = credential;
        });
      }
    }
  }
}
