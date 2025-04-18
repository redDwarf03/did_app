import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:did_app/domain/document/document_repository.dart';
import 'package:uuid/uuid.dart';

/// Mock implementation of the document repository for development and testing
///
/// TODO: Replace this mock implementation with a real blockchain-based document repository
/// This class simulates document management with in-memory storage and artificial delays.
/// A real implementation should:
/// - Store documents securely on the Archethic blockchain with proper encryption
/// - Implement real end-to-end encryption for document contents
/// - Use secure key management for document access control
/// - Implement proper versioning with blockchain transaction history
/// - Support secure document sharing with proper permission management
/// - Implement verification of document authenticity using blockchain signatures
class MockDocumentRepository implements DocumentRepository {
  final Map<String, Document> _documents = {};
  final Map<String, Uint8List> _documentContents = {};
  final Map<String, List<DocumentVersion>> _documentVersions = {};
  final Map<String, Uint8List> _versionContents = {};
  final Map<String, DocumentShare> _documentShares = {};

  // Map of documents by identity
  final Map<String, List<String>> _documentsByIdentity = {};

  // Map of shares received by identity
  final Map<String, List<String>> _sharesReceivedByIdentity = {};

  final _uuid = const Uuid();
  final _random = Random.secure();

  @override
  Future<bool> hasDocuments(String identityAddress) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _documentsByIdentity.containsKey(identityAddress) &&
        _documentsByIdentity[identityAddress]!.isNotEmpty;
  }

  @override
  Future<List<Document>> getDocuments(String identityAddress) async {
    // Simulate network delay
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
    // Simulate network delay
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
    // Simulate network delay and encryption processing
    await Future.delayed(const Duration(milliseconds: 800));

    // Generate a unique ID for the document
    final documentId = _uuid.v4();

    // Simulate encryption by generating an initialization vector
    final encryptionIV = _generateRandomHex(16);

    // Calculate document hash for integrity
    final documentHash = sha256.convert(fileBytes).toString();

    // Simulated storage path
    final storagePath = 'documents/$identityAddress/$documentId';

    // Create the document
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

    // Store the document and its content
    _documents[documentId] = document;
    _documentContents[documentId] = fileBytes;

    // Add document ID to the user's document list
    if (!_documentsByIdentity.containsKey(identityAddress)) {
      _documentsByIdentity[identityAddress] = [];
    }
    _documentsByIdentity[identityAddress]!.add(documentId);

    // Create the first version in history
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
    Uint8List? fileBytes,
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
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    final existingDocument = _documents[documentId];
    if (existingDocument == null) {
      throw Exception('Document not found');
    }

    final now = DateTime.now();
    int newVersion = existingDocument.version;
    String? newDocumentHash = existingDocument.documentHash;
    String? newEncryptionIV = existingDocument.encryptionIV;
    String? newStoragePath = existingDocument.encryptedStoragePath;

    // Only update content-related fields and version if fileBytes is provided
    if (fileBytes != null) {
      newVersion = existingDocument.version + 1;
      newDocumentHash = sha256.convert(fileBytes).toString();
      newEncryptionIV = _generateRandomHex(16);
      newStoragePath =
          'documents/${existingDocument.ownerIdentityId}/$documentId/v$newVersion';

      // Create a new version in history
      final versionId = _uuid.v4();
      final version = DocumentVersion(
        id: versionId,
        versionNumber: newVersion,
        createdAt: now,
        documentHash: newDocumentHash,
        encryptedStoragePath: newStoragePath,
        encryptionIV: newEncryptionIV,
        changeNote: changeNote,
      );

      // Add the new version to history
      if (!_documentVersions.containsKey(documentId)) {
        _documentVersions[documentId] = [];
      }
      _documentVersions[documentId]!.add(version);
      _versionContents[versionId] = fileBytes;
      // Update the main document content only if new bytes are provided
      _documentContents[documentId] = fileBytes;
    }

    // Update the document metadata regardless of fileBytes
    final updatedDocument = Document(
      id: documentId,
      type: existingDocument.type, // Type is not updatable in this mock
      title: title ?? existingDocument.title,
      description: description ?? existingDocument.description,
      issuer: issuer ?? existingDocument.issuer,
      issuedAt: existingDocument.issuedAt, // Issuance date doesn't change
      expiresAt: expiresAt ?? existingDocument.expiresAt,
      version:
          newVersion, // Use new version number if content changed, else old
      metadata: metadata ?? existingDocument.metadata,
      verificationStatus:
          existingDocument.verificationStatus, // Status not changed here
      encryptedStoragePath: newStoragePath, // Use new path if content changed
      documentHash: newDocumentHash, // Use new hash if content changed
      encryptionIV: newEncryptionIV, // Use new IV if content changed
      issuerSignature: existingDocument.issuerSignature, // Not updated in mock
      issuerAddress: existingDocument.issuerAddress, // Not updated in mock
      blockchainTxId: existingDocument.blockchainTxId, // Not updated in mock
      updatedAt: now, // Always update the timestamp
      ownerIdentityId: existingDocument.ownerIdentityId,
      tags: tags ?? existingDocument.tags,
      isShareable: isShareable ?? existingDocument.isShareable,
      eidasLevel: eidasLevel ?? existingDocument.eidasLevel,
    );

    // Store the updated document metadata
    _documents[documentId] = updatedDocument;

    return updatedDocument;
  }

  @override
  Future<bool> deleteDocument(String documentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final document = _documents[documentId];
    if (document == null) {
      return false;
    }

    // Delete the document and its associated data
    _documents.remove(documentId);
    _documentContents.remove(documentId);

    // Remove from the document list by identity
    final identityAddress = document.ownerIdentityId;
    if (_documentsByIdentity.containsKey(identityAddress)) {
      _documentsByIdentity[identityAddress]!.remove(documentId);
    }

    // Remove versions
    _documentVersions.remove(documentId);

    // Remove associated shares
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
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final content = _documentContents[documentId];
    if (content == null) {
      throw Exception('Document content not found for ID: $documentId');
    }
    return content;
  }

  @override
  Future<List<DocumentVersion>> getDocumentVersions(String documentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _documentVersions[documentId] ?? [];
  }

  @override
  Future<Uint8List> getDocumentVersionContent(
    String documentId,
    String versionId,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final content = _versionContents[versionId];
    if (content == null) {
      throw Exception('Version content not found for ID: $versionId');
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
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document not found');
    }

    if (!document.isShareable) {
      throw Exception('This document is not shareable');
    }

    // Generate a unique ID for the share
    final shareId = _uuid.v4();

    // Generate a share URL
    final shareToken = _generateRandomHex(32);
    final shareUrl = 'https://example.com/shared-docs/$shareToken';

    // Create the share
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

    // Store the share
    _documentShares[shareId] = share;

    // If a specific recipient is identified, add to their received shares
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
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final share = _documentShares[shareId];
    if (share == null) {
      return false;
    }

    // If the share is associated with a recipient, remove it from their list
    if (share.recipientId != null) {
      final recipientId = share.recipientId!;
      if (_sharesReceivedByIdentity.containsKey(recipientId)) {
        _sharesReceivedByIdentity[recipientId]!.remove(shareId);
      }
    }

    // Remove the share
    _documentShares.remove(shareId);
    return true;
  }

  @override
  Future<List<DocumentShare>> getDocumentShares(String documentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _documentShares.values
        .where((share) => share.documentId == documentId && share.isActive)
        .toList();
  }

  @override
  Future<DocumentVerificationStatus> verifyDocumentAuthenticity(
    String documentId,
  ) async {
    // Simulate network delay and verification process
    await Future.delayed(const Duration(milliseconds: 1000));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document not found');
    }

    // Simulate a simplified verification
    // In a real implementation, this would involve:
    // 1. Verifying the cryptographic signature
    // 2. Verifying the proof of existence on the blockchain
    // 3. Checking that the issuer is in a list of trusted issuers

    // Simulate a random result for demonstration
    final result = _random.nextInt(100);

    if (result < 70) {
      // 70% chance of being verified
      return DocumentVerificationStatus.verified;
    } else if (result < 85) {
      // 15% chance of being pending
      return DocumentVerificationStatus.pending;
    } else if (result < 95) {
      // 10% chance of being rejected
      return DocumentVerificationStatus.rejected;
    } else {
      // 5% chance of being expired
      return DocumentVerificationStatus.expired;
    }
  }

  @override
  Future<bool> verifyDocumentSignature(String documentId) async {
    // Simulate network delay and signature verification process
    await Future.delayed(const Duration(milliseconds: 800));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document not found');
    }

    // For demonstration, check if the document has a signature
    return document.issuerSignature != null;
  }

  @override
  Future<bool> verifyBlockchainProof(String documentId) async {
    // Simulate network delay and blockchain verification
    await Future.delayed(const Duration(milliseconds: 1200));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document not found');
    }

    // For demonstration, check if the document has a blockchain transaction ID
    return document.blockchainTxId != null;
  }

  @override
  Future<List<DocumentShare>> getSharedWithMe(String identityAddress) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_sharesReceivedByIdentity.containsKey(identityAddress)) {
      return [];
    }

    final shareIds = _sharesReceivedByIdentity[identityAddress]!;
    return shareIds
        .map((id) => _documentShares[id])
        .whereType<DocumentShare>()
        .where(
          (share) =>
              share.isActive &&
              share.expiresAt.isAfter(DateTime.now()) &&
              (share.maxAccessCount == null ||
                  share.accessCount < share.maxAccessCount!),
        )
        .toList();
  }

  @override
  Future<Document?> accessSharedDocument(
    String shareUrl,
    String? accessCode,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Extract share ID from URL
    final shareId = shareUrl.split('/').last;
    final share = _documentShares[shareId];

    if (share == null) {
      throw Exception('Share link not found');
    }

    // Check expiration
    if (share.expiresAt != null && share.expiresAt!.isBefore(DateTime.now())) {
      throw Exception('Share link has expired');
    }

    // Check access code
    if (share.accessCode != null && share.accessCode != accessCode) {
      throw Exception('Invalid access code');
    }

    // Check access count
    if (share.maxAccessCount != null &&
        share.accessCount >= share.maxAccessCount!) {
      throw Exception('Share access limit reached');
    }

    // Increment access count by creating a new instance
    final updatedShare = share.copyWith(accessCount: share.accessCount + 1);
    _documentShares[shareId] = updatedShare;

    // Return the associated document
    return _documents[share.documentId];
  }

  @override
  Future<Document> signDocument({
    required String documentId,
    required String signerIdentityAddress,
  }) async {
    // Simulate network delay and signing process
    await Future.delayed(const Duration(milliseconds: 1000));

    final document = _documents[documentId];
    if (document == null) {
      throw Exception('Document not found');
    }

    // Simulate a cryptographic signature
    final signature = _generateRandomHex(64);

    // Simulate a blockchain transaction ID
    final blockchainTxId = _generateRandomHex(32);

    // Update the document with the signature
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

    // Store the updated document
    _documents[documentId] = updatedDocument;

    return updatedDocument;
  }

  // Utility method to generate a random hex string
  String _generateRandomHex(int length) {
    final values = List<int>.generate(length, (i) => _random.nextInt(256));
    return values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
