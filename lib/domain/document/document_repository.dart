import 'dart:typed_data';

import 'package:did_app/domain/document/document.dart';

/// Interface du repository pour la gestion des documents
abstract class DocumentRepository {
  /// Vérifie si un utilisateur a déjà des documents
  Future<bool> hasDocuments(String identityAddress);

  /// Récupère tous les documents d'un utilisateur
  Future<List<Document>> getDocuments(String identityAddress);

  /// Récupère un document spécifique
  Future<Document?> getDocument(String documentId);

  /// Ajoute un nouveau document
  ///
  /// [fileBytes] contient les données binaires du document
  /// [fileName] est le nom original du fichier
  /// [documentType] est le type de document
  /// [title] est le titre du document
  /// [description] est une description optionnelle
  /// [issuer] est l'émetteur du document
  /// [expiresAt] est la date d'expiration optionnelle
  /// [metadata] contient des métadonnées supplémentaires
  /// [tags] sont des étiquettes pour la recherche
  /// [isShareable] indique si le document peut être partagé
  /// [eidasLevel] spécifie le niveau de garantie eIDAS
  Future<Document> addDocument({
    required String identityAddress,
    required Uint8List fileBytes,
    required String fileName,
    required DocumentType documentType,
    required String title,
    String? description,
    required String issuer,
    DateTime? expiresAt,
    Map<String, dynamic>? metadata,
    List<String>? tags,
    bool isShareable = false,
    EidasLevel eidasLevel = EidasLevel.low,
  });

  /// Met à jour un document existant
  Future<Document> updateDocument({
    required String documentId,
    required Uint8List fileBytes,
    String? title,
    String? description,
    String? issuer,
    DateTime? expiresAt,
    Map<String, dynamic>? metadata,
    List<String>? tags,
    bool? isShareable,
    EidasLevel? eidasLevel,
    String? changeNote,
  });

  /// Supprime un document
  Future<bool> deleteDocument(String documentId);

  /// Récupère le contenu binaire d'un document
  Future<Uint8List> getDocumentContent(String documentId);

  /// Récupère l'historique des versions d'un document
  Future<List<DocumentVersion>> getDocumentVersions(String documentId);

  /// Récupère une version spécifique d'un document
  Future<Uint8List> getDocumentVersionContent(
    String documentId,
    String versionId,
  );

  /// Crée un partage de document
  Future<DocumentShare> shareDocument({
    required String documentId,
    required String recipientDescription,
    String? recipientId,
    required DateTime expiresAt,
    required DocumentShareAccessType accessType,
    String? accessCode,
    int? maxAccessCount,
  });

  /// Révoque un partage de document
  Future<bool> revokeDocumentShare(String shareId);

  /// Récupère tous les partages actifs pour un document
  Future<List<DocumentShare>> getDocumentShares(String documentId);

  /// Vérifie l'authenticité d'un document
  Future<DocumentVerificationStatus> verifyDocumentAuthenticity(
      String documentId);

  /// Vérifie la validité de la signature d'un document
  Future<bool> verifyDocumentSignature(String documentId);

  /// Vérifie la preuve d'existence sur la blockchain
  Future<bool> verifyBlockchainProof(String documentId);

  /// Récupère les documents partagés avec l'utilisateur
  Future<List<DocumentShare>> getSharedWithMe(String identityAddress);

  /// Accéde à un document partagé via une URL et un code d'accès
  Future<Document?> accessSharedDocument(
    String shareUrl,
    String? accessCode,
  );

  /// Signe un document (en tant qu'émetteur)
  Future<Document> signDocument({
    required String documentId,
    required String signerIdentityAddress,
  });
}
