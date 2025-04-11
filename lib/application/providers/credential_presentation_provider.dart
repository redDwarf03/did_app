import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/qualified_credential.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/infrastructure/credential/mock_credential_repository.dart';
import 'package:did_app/infrastructure/credential/qualified_credential_service.dart';
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
    this.verificationResult,
    this.isValidating = false,
  });

  /// Indicateur de chargement
  final bool loading;

  /// Indicateur de validation en cours
  final bool isValidating;

  /// Présentation actuelle
  final CredentialPresentation? presentation;

  /// Message d'erreur éventuel
  final String? error;

  /// Résultat de la vérification
  final VerificationResult? verificationResult;

  /// Crée une copie de l'état avec des valeurs modifiées
  CredentialPresentationState copyWith({
    bool? loading,
    bool? isValidating,
    CredentialPresentation? presentation,
    String? error,
    VerificationResult? verificationResult,
  }) {
    return CredentialPresentationState(
      loading: loading ?? this.loading,
      isValidating: isValidating ?? this.isValidating,
      presentation: presentation ?? this.presentation,
      error: error,
      verificationResult: verificationResult ?? this.verificationResult,
    );
  }
}

/// Provider pour le service d'attestations qualifiées
final qualifiedCredentialServiceProvider = Provider<QualifiedCredentialService>(
  (ref) => QualifiedCredentialService(),
);

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
    String? challenge,
    String? domain,
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

      // Vérifier la qualification des attestations
      final qualifiedService = _ref.read(qualifiedCredentialServiceProvider);
      final qualifiedStatuses = await Future.wait(
          credentials.map((c) => qualifiedService.isQualified(c)));

      // Créer les contextes eIDAS
      final List<String> contexts = [
        'https://www.w3.org/2018/credentials/v1',
        'https://ec.europa.eu/digital-identity/credentials/v1'
      ];

      // Déterminer les types à inclure
      final types = ['VerifiablePresentation'];

      // Si toutes les attestations sont qualifiées, ajouter le type eIDAS
      if (qualifiedStatuses.every((q) => q)) {
        types.add('EidasPresentation');
      }

      // Générer la preuve
      final proof = await _generateProof(
          identity: identity,
          credentials: credentials,
          challenge: challenge,
          domain: domain);

      // Créer la présentation
      final presentation = CredentialPresentation(
        id: 'urn:uuid:${_uuid.v4()}',
        type: types,
        verifiableCredentials: credentials,
        revealedAttributes: revealedAttributes,
        challenge: challenge,
        domain: domain,
        created: DateTime.now(),
        proof: proof,
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

  /// Génère une preuve pour la présentation
  Future<Map<String, dynamic>> _generateProof({
    required DigitalIdentity identity,
    required List<Credential> credentials,
    String? challenge,
    String? domain,
  }) async {
    // Dans une implémentation réelle, on signerait avec la clé privée
    // Pour cette démo, on crée une preuve simulée compatible eIDAS

    // Déterminer le type de preuve approprié
    final proofType = _determineProofType(credentials);

    return {
      'type': proofType,
      'created': DateTime.now().toIso8601String(),
      'proofPurpose': 'authentication',
      'verificationMethod': 'did:archethic:${identity.identityAddress}#key-1',
      'proofValue': 'mockSignatureForPresentation',
      if (challenge != null) 'challenge': challenge,
      if (domain != null) 'domain': domain,
    };
  }

  /// Détermine le type de preuve à utiliser
  String _determineProofType(List<Credential> credentials) {
    // Si toutes les attestations supportent ZKP, utiliser BBS+
    if (credentials.every((c) => c.supportsZkp)) {
      return 'BbsBlsSignature2020';
    }

    // Sinon, utiliser une signature eIDAS standard
    return 'EidasSignature2023';
  }

  /// Vérifie une présentation
  Future<VerificationResult> verifyPresentation(
      CredentialPresentation presentation) async {
    state = state.copyWith(isValidating: true, error: null);

    try {
      // Vérifier la cohérence de la présentation
      if (presentation.verifiableCredentials.isEmpty) {
        final result = VerificationResult(
          isValid: false,
          message: 'La présentation ne contient aucune attestation',
        );
        state = state.copyWith(isValidating: false, verificationResult: result);
        return result;
      }

      // Vérifier la validité des attestations
      final invalidCredentials = presentation.verifiableCredentials.where((c) =>
          !c.isValid || c.verificationStatus == VerificationStatus.invalid);

      if (invalidCredentials.isNotEmpty) {
        final result = VerificationResult(
          isValid: false,
          message: 'La présentation contient des attestations invalides',
        );
        state = state.copyWith(isValidating: false, verificationResult: result);
        return result;
      }

      // Vérifier si c'est une présentation eIDAS
      final isEidasPresentation =
          presentation.type.contains('EidasPresentation');

      // Pour les présentations eIDAS, effectuer des vérifications supplémentaires
      if (isEidasPresentation) {
        final qualifiedService = _ref.read(qualifiedCredentialServiceProvider);

        // Vérifier que toutes les attestations sont qualifiées
        final qualifiedStatuses = await Future.wait(presentation
            .verifiableCredentials
            .map((c) => qualifiedService.isQualified(c)));

        if (!qualifiedStatuses.every((q) => q)) {
          final result = VerificationResult(
            isValid: false,
            message:
                'La présentation eIDAS contient des attestations non qualifiées',
          );
          state =
              state.copyWith(isValidating: false, verificationResult: result);
          return result;
        }
      }

      // Vérifier la signature de la présentation
      final isSignatureValid = await _verifySignature(presentation);

      if (!isSignatureValid) {
        final result = VerificationResult(
          isValid: false,
          message: 'La signature de la présentation est invalide',
        );
        state = state.copyWith(isValidating: false, verificationResult: result);
        return result;
      }

      // Tout est valide
      final result = VerificationResult(
        isValid: true,
        message: 'Présentation vérifiée avec succès',
        details: {
          'isEidas': isEidasPresentation,
          'credentialCount': presentation.verifiableCredentials.length,
          'type': presentation.type.join(', '),
        },
      );

      state = state.copyWith(isValidating: false, verificationResult: result);
      return result;
    } catch (e) {
      final result = VerificationResult(
        isValid: false,
        message: 'Erreur lors de la vérification: ${e.toString()}',
      );
      state = state.copyWith(isValidating: false, verificationResult: result);
      return result;
    }
  }

  /// Vérifie la signature d'une présentation
  Future<bool> _verifySignature(CredentialPresentation presentation) async {
    // Dans une implémentation réelle, on vérifierait la signature
    // Pour cette démo, on simule une vérification réussie

    // Vérification basique de la cohérence des données de preuve
    final proof = presentation.proof;

    return proof.containsKey('type') &&
        proof.containsKey('created') &&
        proof.containsKey('verificationMethod') &&
        proof.containsKey('proofValue');
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
