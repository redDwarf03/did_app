import 'package:did_app/domain/credential/credential.dart';

/// Interface du repository pour la gestion des attestations vérifiables
abstract class CredentialRepository {
  /// Vérifie si un utilisateur a déjà des attestations
  Future<bool> hasCredentials(String identityAddress);

  /// Récupère toutes les attestations d'un utilisateur
  Future<List<Credential>> getCredentials(String identityAddress);

  /// Récupère une attestation spécifique
  Future<Credential?> getCredential(String credentialId);

  /// Ajoute une nouvelle attestation reçue d'un émetteur
  Future<Credential> addCredential({
    required String identityAddress,
    required Map<String, dynamic> credentialData,
  });

  /// Supprime une attestation
  Future<bool> deleteCredential(String credentialId);

  /// Vérifie la validité d'une attestation
  Future<bool> verifyCredential(String credentialId);

  /// Vérifie le statut de révocation d'une attestation
  Future<RevocationStatus> checkRevocationStatus(String credentialId);

  /// Crée une présentation à partir d'attestations
  Future<CredentialPresentation> createPresentation({
    required String identityAddress,
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
  });

  /// Vérifie une présentation reçue
  Future<bool> verifyPresentation(CredentialPresentation presentation);

  /// Génère un lien ou QR code pour partager une présentation
  Future<String> generatePresentationLink(String presentationId);

  /// Récupère une présentation à partir d'un lien
  Future<CredentialPresentation?> getPresentationFromLink(String link);

  /// Accepte une demande d'attestation
  Future<Credential> acceptCredentialOffer({
    required String identityAddress,
    required String offerId,
    required Map<String, dynamic> consents,
  });

  /// Crée une demande d'attestation pour envoyer à un émetteur
  Future<String> createCredentialRequest({
    required String identityAddress,
    required String issuerId,
    required String credentialType,
    Map<String, dynamic>? additionalInfo,
  });
}
