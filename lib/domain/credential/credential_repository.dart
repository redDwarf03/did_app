import 'package:did_app/domain/credential/credential.dart';

/// Interface définissant les opérations sur les attestations
abstract class CredentialRepository {
  /// Récupère toutes les attestations de l'utilisateur
  Future<List<Credential>> getCredentials();

  /// Récupère une attestation par son identifiant
  Future<Credential?> getCredentialById(String id);

  /// Sauvegarde une attestation
  Future<void> saveCredential(Credential credential);

  /// Supprime une attestation
  Future<void> deleteCredential(String id);

  /// Vérifie une attestation
  Future<bool> verifyCredential(Credential credential);

  /// Crée une présentation d'attestation avec divulgation sélective
  Future<CredentialPresentation> createPresentation({
    required List<Credential> credentials,
    required Map<String, List<String>> selectiveDisclosure,
    String? challenge,
    String? domain,
  });

  /// Vérifie une présentation d'attestation
  Future<bool> verifyPresentation(CredentialPresentation presentation);

  /// Partage une présentation d'attestation (retourne un URI ou code QR)
  Future<String> sharePresentation(CredentialPresentation presentation);

  /// Récupère une attestation depuis un URI ou un code QR
  Future<Credential> receiveCredential(String uri);

  /// Récupère une demande de présentation depuis un URI ou un code QR
  Future<Map<String, dynamic>> receivePresentationRequest(String uri);

  /// Écoute les changements dans les attestations
  Stream<List<Credential>> watchCredentials();
}
