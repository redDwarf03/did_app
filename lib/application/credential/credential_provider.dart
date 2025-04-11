import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour récupérer une attestation par son ID
final credentialByIdProvider = FutureProvider.family<Credential?, String>(
  (ref, credentialId) async {
    final repository = ref.watch(credentialRepositoryProvider);

    try {
      return await repository.getCredentialById(credentialId);
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'attestation: $e");
    }
  },
);
