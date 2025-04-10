import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:did_app/domain/document/document_repository.dart';
import 'package:uuid/uuid.dart';

/// Implémentation mock du repository de documents pour le développement et les tests
class MockDocumentRepository implements DocumentRepository {
  final Map<String, Document> _documents = {};
  final Map<String, Uint8List> _documentContents = {};
  final Map<String, List<DocumentVersion>> _documentVersions = {};
  final Map<String, Uint8List> _versionContents = {};
  final Map<String, DocumentShare> _documentShares = {};

  // Map des documents par identité
  final Map<String, List<String>> _documentsByIdentity = {};

  // Map des partages reçus par identité
  final Map<String, List<String>> _sharesReceivedByIdentity = {};

  final _uuid = const Uuid();
  final _random = Random.secure();

  @override
  Future<bool> hasDocuments(String identityAddress) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 300));
    return _documentsByIdentity.containsKey(identityAddress) &&
        _documentsByIdentity[identityAddress]!.isNotEmpty;
  }

  @override
  Future<List<Document>> getDocuments(String identityAddress) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_documentsByIdentity.containsKey(identityAddress)) {
      return [];
    }

    final documentIds = _documentsByIdentity[identityAddress]!;
    return documentIds
        .map((id) => _documents[id])
        .whereType<Document>()
        .toList();
  }

  @override
  Future<Document?> getDocument(String documentId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 300));
    return _documents[documentId];
  }

  @override
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
  }) async {
    // Simuler un délai réseau et traitement de chiffrement
    await Future.delayed(const Duration(milliseconds: 800));

    // Générer un ID unique pour le document
    final documentId = _uuid.v4();

    // Simuler le chiffrement en générant un vecteur d'initialisation
    final encryptionIV = _generateRandomHex(16);

    // Calculer le hash du document pour l'intégrité
    final documentHash = sha256.convert(fileBytes).toString();

    // Chemin de stockage simulé
    final storagePath = 'documents/$identityAddress/$documentId';

    // Création du document
    final now = DateTime.now();
    final document = Document(
      id: documentId,
      type: documentType,
      title: title,
      description: description,
      issuer: issuer,
      issuedAt: now,
      expiresAt: expiresAt,
      version: 1,
      metadata: metadata,
      verificationStatus: DocumentVerificationStatus.unverified,
      encryptedStoragePath: storagePath,
      documentHash: documentHash,
      encryptionIV: encryptionIV,
      updatedAt: now,
      ownerIdentityId: identityAddress,
      tags: tags,
      isShareable: isShareable,
      eidasLevel: eidasLevel,
    );

    // Stocker le document et son contenu
    _documents[documentId] = document;
    _documentContents[documentId] = fileBytes;

    // Ajouter l'ID du document à la liste des documents de l'utilisateur
    if (!_documentsByIdentity.containsKey(identityAddress)) {
      _documentsByIdentity[identityAddress] = [];
    }
    _documentsByIdentity[identityAddress]!.add(documentId);

    // Créer la première version dans l'historique
    final versionId = _uuid.v4();
    final version = DocumentVersion(
      id: versionId,
      versionNumber: 1,
      createdAt: now,
      documentHash: documentHash,
      encryptedStoragePath: storagePath,
      encryptionIV: encryptionIV,
    );

    _documentVersions[documentId] = [version];
    _versionContents[versionId] = fileBytes;

    return document;
  }

  @override
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
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 800));

    final existingDocument = _documents[documentId];
    if (existingDocument == null) {
      throw Exception('Document non trouvé');
    }

    // Calculer le hash du nouveau contenu
    final documentHash = sha256.convert(fileBytes).toString();

    // Simuler un nouveau vecteur d'initialisation pour le chiffrement
    final encryptionIV = _generateRandomHex(16);

    // Chemin de stockage simulé pour la nouvelle version
    final storagePath =
        'documents/${existingDocument.ownerIdentityId}/$documentId/v${existingDocument.version + 1}';

    // Créer une nouvelle version dans l'historique
    final now = DateTime.now();
    final newVersion = existingDocument.version + 1;
    final versionId = _uuid.v4();
    final version = DocumentVersion(
      id: versionId,
      versionNumber: newVersion,
      createdAt: now,
      documentHash: documentHash,
      encryptedStoragePath: storagePath,
      encryptionIV: encryptionIV,
      changeNote: changeNote,
    );

    // Mettre à jour le document
    final updatedDocument = Document(
      id: documentId,
      type: existingDocument.type,
      title: title ?? existingDocument.title,
      description: description ?? existingDocument.description,
      issuer: issuer ?? existingDocument.issuer,
      issuedAt: existingDocument.issuedAt,
      expiresAt: expiresAt ?? existingDocument.expiresAt,
      version: newVersion,
      metadata: metadata ?? existingDocument.metadata,
      verificationStatus: existingDocument.verificationStatus,
      encryptedStoragePath: storagePath,
      documentHash: documentHash,
      encryptionIV: encryptionIV,
      issuerSignature: existingDocument.issuerSignature,
      issuerAddress: existingDocument.issuerAddress,
      blockchainTxId: existingDocument.blockchainTxId,
      updatedAt: now,
      ownerIdentityId: existingDocument.ownerIdentityId,
      tags: tags ?? existingDocument.tags,
      isShareable: isShareable ?? existingDocument.isShareable,
      eidasLevel: eidasLevel ?? existingDocument.eidasLevel,
    );

    // Stocker le document mis à jour et son contenu
    _documents[documentId] = updatedDocument;
    _documentContents[documentId] = fileBytes;

    // Ajouter la nouvelle version à l'historique
    if (!_documentVersions.containsKey(documentId)) {
      _documentVersions[documentId] = [];
    }
    _documentVersions[documentId]!.add(version);
    _versionContents[versionId] = fileBytes;

    return updatedDocument;
  }

  @override
  Future<bool> deleteDocument(String documentId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    final document = _documents[documentId];
    if (document == null) {
      return false;
    }

    // Supprimer le document et ses données associées
    _documents.remove(documentId);
    _documentContents.remove(documentId);

    // Supprimer de la liste des documents par identité
    final identityAddress = document.ownerIdentityId;
    if (_documentsByIdentity.containsKey(identityAddress)) {
      _documentsByIdentity[identityAddress]!.remove(documentId);
    }

    // Supprimer les versions
    _documentVersions.remove(documentId);

    // Supprimer les partages associés
    final sharesToRemove = _documentShares.values
        .where((share) => share.documentId == documentId)
        .map((share) => share.id)
        .toList();

    for (final shareId in sharesToRemove) {
      _documentShares.remove(shareId);
    }

    return true;
  }

  @override
  Future<Uint8List> getDocumentContent(String documentId) async {
    // Simuler un délai réseau et déchiffrement
    await Future.delayed(const Duration(milliseconds: 500));

    final content = _documentContents[documentId];
    if (content == null) {
      throw Exception('Contenu du document non trouvé');
    }

    return content;
  }

  @override
  Future<List<DocumentVersion>> getDocumentVersions(String documentId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 400));

    return _documentVersions[documentId] ?? [];
  }

  @override
  Future<Uint8List> getDocumentVersionContent(
      String documentId, String versionId) async {
    // Simuler un délai réseau et déchiffrement
    await Future.delayed(const Duration(milliseconds: 500));

    final content = _versionContents[versionId];
    if (content == null) {
      throw Exception('Contenu de la version non trouvé');
    }

    return content;
  }

  @override
  Future<DocumentShare> shareDocument({
    required String documentId,
    required String recipientDescription,
    String? recipientId,
    required DateTime expiresAt,
    required DocumentShareAccessType accessType,
    String? accessCode,
    int? maxAccessCount,
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 600));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document non trouvé');
    }

    if (!document.isShareable) {
      throw Exception('Ce document n\'est pas partageable');
    }

    // Générer un ID unique pour le partage
    final shareId = _uuid.v4();

    // Générer une URL de partage
    final shareToken = _generateRandomHex(32);
    final shareUrl = 'https://example.com/shared-docs/$shareToken';

    // Créer le partage
    final now = DateTime.now();
    final share = DocumentShare(
      id: shareId,
      documentId: documentId,
      documentTitle: document.title,
      recipientId: recipientId,
      recipientDescription: recipientDescription,
      createdAt: now,
      expiresAt: expiresAt,
      shareUrl: shareUrl,
      accessCode: accessCode,
      maxAccessCount: maxAccessCount,
      accessType: accessType,
    );

    // Stocker le partage
    _documentShares[shareId] = share;

    // Si un destinataire spécifique est identifié, ajouter à ses partages reçus
    if (recipientId != null) {
      if (!_sharesReceivedByIdentity.containsKey(recipientId)) {
        _sharesReceivedByIdentity[recipientId] = [];
      }
      _sharesReceivedByIdentity[recipientId]!.add(shareId);
    }

    return share;
  }

  @override
  Future<bool> revokeDocumentShare(String shareId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 400));

    final share = _documentShares[shareId];
    if (share == null) {
      return false;
    }

    // Si le partage est associé à un destinataire, le retirer de sa liste
    if (share.recipientId != null) {
      final recipientId = share.recipientId!;
      if (_sharesReceivedByIdentity.containsKey(recipientId)) {
        _sharesReceivedByIdentity[recipientId]!.remove(shareId);
      }
    }

    // Supprimer le partage
    _documentShares.remove(shareId);
    return true;
  }

  @override
  Future<List<DocumentShare>> getDocumentShares(String documentId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 400));

    return _documentShares.values
        .where((share) => share.documentId == documentId && share.isActive)
        .toList();
  }

  @override
  Future<DocumentVerificationStatus> verifyDocumentAuthenticity(
      String documentId) async {
    // Simuler un délai réseau et processus de vérification
    await Future.delayed(const Duration(milliseconds: 1000));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document non trouvé');
    }

    // Simuler une vérification simplifiée
    // Dans une implémentation réelle, cela impliquerait:
    // 1. Vérifier la signature cryptographique
    // 2. Vérifier la preuve d'existence sur la blockchain
    // 3. Vérifier que l'émetteur est dans une liste d'émetteurs de confiance

    // Simuler un résultat aléatoire pour la démonstration
    final result = _random.nextInt(100);

    if (result < 70) {
      // 70% de chance d'être vérifié
      return DocumentVerificationStatus.verified;
    } else if (result < 85) {
      // 15% de chance d'être en attente
      return DocumentVerificationStatus.pending;
    } else if (result < 95) {
      // 10% de chance d'être rejeté
      return DocumentVerificationStatus.rejected;
    } else {
      // 5% de chance d'être expiré
      return DocumentVerificationStatus.expired;
    }
  }

  @override
  Future<bool> verifyDocumentSignature(String documentId) async {
    // Simuler un délai réseau et processus de vérification de signature
    await Future.delayed(const Duration(milliseconds: 800));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document non trouvé');
    }

    // Pour la démonstration, vérifier si le document a une signature
    return document.issuerSignature != null;
  }

  @override
  Future<bool> verifyBlockchainProof(String documentId) async {
    // Simuler un délai réseau et vérification sur la blockchain
    await Future.delayed(const Duration(milliseconds: 1200));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document non trouvé');
    }

    // Pour la démonstration, vérifier si le document a un ID de transaction blockchain
    return document.blockchainTxId != null;
  }

  @override
  Future<List<DocumentShare>> getSharedWithMe(String identityAddress) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_sharesReceivedByIdentity.containsKey(identityAddress)) {
      return [];
    }

    final shareIds = _sharesReceivedByIdentity[identityAddress]!;
    return shareIds
        .map((id) => _documentShares[id])
        .whereType<DocumentShare>()
        .where((share) =>
            share.isActive &&
            share.expiresAt.isAfter(DateTime.now()) &&
            (share.maxAccessCount == null ||
                share.accessCount < share.maxAccessCount!))
        .toList();
  }

  @override
  Future<Document?> accessSharedDocument(
      String shareUrl, String? accessCode) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 700));

    // Trouver le partage correspondant à l'URL
    final share = _documentShares.values.firstWhere(
      (share) => share.shareUrl == shareUrl,
      orElse: () => throw Exception('Partage non trouvé'),
    );

    // Vérifier si le partage est actif
    if (!share.isActive) {
      throw Exception('Ce partage a été révoqué');
    }

    // Vérifier si le partage n'a pas expiré
    if (share.expiresAt.isBefore(DateTime.now())) {
      throw Exception('Ce partage a expiré');
    }

    // Vérifier le nombre d'accès maximum
    if (share.maxAccessCount != null &&
        share.accessCount >= share.maxAccessCount!) {
      throw Exception('Le nombre maximum d\'accès a été atteint');
    }

    // Vérifier le code d'accès si nécessaire
    if (share.accessCode != null && share.accessCode != accessCode) {
      throw Exception('Code d\'accès incorrect');
    }

    // Créer une nouvelle instance du partage avec le compteur incrémenté et la dernière date d'accès
    final updatedShare = DocumentShare(
      id: share.id,
      documentId: share.documentId,
      documentTitle: share.documentTitle,
      recipientId: share.recipientId,
      recipientDescription: share.recipientDescription,
      createdAt: share.createdAt,
      expiresAt: share.expiresAt,
      shareUrl: share.shareUrl,
      accessCode: share.accessCode,
      isActive: share.isActive,
      maxAccessCount: share.maxAccessCount,
      accessCount: share.accessCount + 1,
      accessType: share.accessType,
      lastAccessedAt: DateTime.now(),
    );

    // Mettre à jour le partage dans la map
    _documentShares[share.id] = updatedShare;

    // Retourner le document
    return _documents[share.documentId];
  }

  @override
  Future<Document> signDocument({
    required String documentId,
    required String signerIdentityAddress,
  }) async {
    // Simuler un délai réseau et processus de signature
    await Future.delayed(const Duration(milliseconds: 1000));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document non trouvé');
    }

    // Simuler une signature cryptographique
    final signature = _generateRandomHex(64);

    // Simuler un ID de transaction blockchain
    final blockchainTxId = _generateRandomHex(32);

    // Mettre à jour le document avec la signature
    final updatedDocument = Document(
      id: document.id,
      type: document.type,
      title: document.title,
      description: document.description,
      issuer: document.issuer,
      issuedAt: document.issuedAt,
      expiresAt: document.expiresAt,
      version: document.version,
      metadata: document.metadata,
      verificationStatus: DocumentVerificationStatus.verified,
      encryptedStoragePath: document.encryptedStoragePath,
      documentHash: document.documentHash,
      encryptionIV: document.encryptionIV,
      issuerSignature: signature,
      issuerAddress: signerIdentityAddress,
      blockchainTxId: blockchainTxId,
      updatedAt: DateTime.now(),
      ownerIdentityId: document.ownerIdentityId,
      tags: document.tags,
      isShareable: document.isShareable,
      eidasLevel: document.eidasLevel,
    );

    // Stocker le document mis à jour
    _documents[documentId] = updatedDocument;

    return updatedDocument;
  }

  // Méthode utilitaire pour générer une chaîne hexadécimale aléatoire
  String _generateRandomHex(int length) {
    final values = List<int>.generate(length, (i) => _random.nextInt(256));
    return values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
