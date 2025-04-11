import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/infrastructure/credential/mock_credential_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/identity/providers.dart';

/// État du provider de présentation d'attestations
class CredentialPresentationState {
  CredentialPresentationState({
    this.loading = false,
    this.presentation,
    this.error,
  });

  /// Indicateur de chargement
  final bool loading;

  /// Présentation actuelle
  final CredentialPresentation? presentation;

  /// Message d'erreur éventuel
  final String? error;

  /// Crée une copie de l'état avec des valeurs modifiées
  CredentialPresentationState copyWith({
    bool? loading,
    CredentialPresentation? presentation,
    String? error,
  }) {
    return CredentialPresentationState(
      loading: loading ?? this.loading,
      presentation: presentation ?? this.presentation,
      error: error,
    );
  }
}

/// Provider pour la gestion des présentations d'attestations
final credentialPresentationProvider = StateNotifierProvider<
    CredentialPresentationNotifier, CredentialPresentationState>(
  (ref) => CredentialPresentationNotifier(ref),
);

/// Notifier pour la gestion des présentations d'attestations
class CredentialPresentationNotifier
    extends StateNotifier<CredentialPresentationState> {
  CredentialPresentationNotifier(this._ref)
      : super(CredentialPresentationState());

  final Ref _ref;
  final _uuid = const Uuid();

  /// Crée une nouvelle présentation d'attestations
  Future<CredentialPresentation?> createPresentation({
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
    String? message,
  }) async {
    state = state.copyWith(loading: true, error: null);

    try {
      // Vérifier que l'utilisateur a une identité
      final identity = _ref.read(identityNotifierProvider).identity;
      if (identity == null) {
        state = state.copyWith(
          loading: false,
          error: 'Une identité est requise pour créer une présentation',
        );
        return null;
      }

      // Vérifier que les attestations existent
      final credentialState = _ref.read(credentialNotifierProvider);
      final credentials = <Credential>[];

      for (final id in credentialIds) {
        final credential = credentialState.credentials.firstWhere(
          (c) => c.id == id,
          orElse: () => throw Exception('Attestation non trouvée: $id'),
        );
        credentials.add(credential);
      }

      // Créer la présentation
      final presentation = CredentialPresentation(
        id: _uuid.v4(),
        context: ['https://www.w3.org/2018/credentials/v1'],
        type: ['VerifiablePresentation'],
        holder: identity.identityAddress,
        verifiableCredentials: credentials,
        revealedAttributes: revealedAttributes,
        predicates: predicates,
        created: DateTime.now(),
        proof: CredentialProof(
          type: 'Ed25519Signature2020',
          created: DateTime.now(),
          proofPurpose: 'authentication',
          verificationMethod: 'did:archethic:${identity.identityAddress}#key-1',
          proofValue: 'mockSignatureForPresentation',
        ),
      );

      state = state.copyWith(loading: false, presentation: presentation);
      return presentation;
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Erreur lors de la création de la présentation: ${e.toString()}',
      );
      return null;
    }
  }

  /// Génère un lien de partage pour une présentation
  String sharePresentation(String presentationId) {
    // Dans une implémentation réelle, on encoderait la présentation
    // dans un format adapté (JWT, etc.) et on générerait un lien
    return 'https://did.app/presentation/$presentationId';
  }

  /// Réinitialise l'état du provider
  void reset() {
    state = CredentialPresentationState();
  }
}
