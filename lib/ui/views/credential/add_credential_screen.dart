import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Écran d'ajout d'une nouvelle attestation
class AddCredentialScreen extends ConsumerWidget {
  const AddCredentialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialListTitle),
      ),
      body: Center(
        child: Text(l10n.pickDocumentFeatureNotAvailable),
      ),
    );
  }
}
