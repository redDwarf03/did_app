import 'dart:typed_data';

import 'package:did_app/domain/document/document.dart';
import 'package:did_app/domain/document/document_repository.dart';
import 'package:did_app/infrastructure/document/mock_document_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the document repository
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  // TODO: Replace mock implementation with real document storage on blockchain
  // This should implement secure storage of documents, with end-to-end encryption
  // and proper access control based on user permissions
  return MockDocumentRepository();
});

/// State for document management
class DocumentState {
  const DocumentState({
    this.documents = const [],
    this.selectedDocument,
    this.isLoading = false,
    this.errorMessage,
    this.documentVersions = const [],
    this.selectedVersion,
    this.documentShares = const [],
    this.sharedWithMe = const [],
  });

  /// List of user's documents
  final List<Document> documents;

  /// Currently selected document
  final Document? selectedDocument;

  /// Loading indicator
  final bool isLoading;

  /// Error message if any
  final String? errorMessage;

  /// List of versions for the selected document
  final List<DocumentVersion> documentVersions;

  /// Selected version
  final DocumentVersion? selectedVersion;

  /// List of shares for the selected document
  final List<DocumentShare> documentShares;

  /// List of documents shared with the user
  final List<DocumentShare> sharedWithMe;

  /// Utility method to copy the instance with modifications
  DocumentState copyWith({
    List<Document>? documents,
    Document? selectedDocument,
    bool? isLoading,
    String? errorMessage,
    List<DocumentVersion>? documentVersions,
    DocumentVersion? selectedVersion,
    List<DocumentShare>? documentShares,
    List<DocumentShare>? sharedWithMe,
  }) {
    return DocumentState(
      documents: documents ?? this.documents,
      selectedDocument: selectedDocument ?? this.selectedDocument,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      documentVersions: documentVersions ?? this.documentVersions,
      selectedVersion: selectedVersion ?? this.selectedVersion,
      documentShares: documentShares ?? this.documentShares,
      sharedWithMe: sharedWithMe ?? this.sharedWithMe,
    );
  }
}

/// Provider for document management
final documentNotifierProvider =
    StateNotifierProvider<DocumentNotifier, DocumentState>((ref) {
  return DocumentNotifier(ref);
});

/// Notifier for document management
class DocumentNotifier extends StateNotifier<DocumentState> {
  DocumentNotifier(this.ref) : super(const DocumentState());

  final Ref ref;

  /// Load user's documents
  Future<void> loadDocuments(String identityAddress) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final documents = await repository.getDocuments(identityAddress);

      state = state.copyWith(
        documents: documents,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading documents: $e',
      );
    }
  }

  /// Load a specific document
  Future<void> loadDocument(String documentId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final document = await repository.getDocument(documentId);

      if (document != null) {
        // Also load versions and shares
        final versions = await repository.getDocumentVersions(documentId);
        final shares = await repository.getDocumentShares(documentId);

        state = state.copyWith(
          selectedDocument: document,
          documentVersions: versions,
          documentShares: shares,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Document not found',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading document: $e',
      );
    }
  }

  /// Add a new document
  Future<Document?> addDocument({
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
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final document = await repository.addDocument(
        identityAddress: identityAddress,
        fileBytes: fileBytes,
        fileName: fileName,
        documentType: documentType,
        title: title,
        description: description,
        issuer: issuer,
        expiresAt: expiresAt,
        metadata: metadata,
        tags: tags,
        isShareable: isShareable,
        eidasLevel: eidasLevel,
      );

      // Update document list
      final updatedDocuments = [...state.documents, document];
      state = state.copyWith(
        documents: updatedDocuments,
        selectedDocument: document,
        isLoading: false,
      );

      return document;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error adding document: $e',
      );
      return null;
    }
  }

  /// Update a document
  Future<Document?> updateDocument({
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
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final updatedDocument = await repository.updateDocument(
        documentId: documentId,
        fileBytes: fileBytes,
        title: title,
        description: description,
        issuer: issuer,
        expiresAt: expiresAt,
        metadata: metadata,
        tags: tags,
        isShareable: isShareable,
        eidasLevel: eidasLevel,
        changeNote: changeNote,
      );

      // Update document list
      final index = state.documents.indexWhere((doc) => doc.id == documentId);
      if (index != -1) {
        final updatedDocuments = [...state.documents];
        updatedDocuments[index] = updatedDocument;

        // Load updated versions
        final versions = await repository.getDocumentVersions(documentId);

        state = state.copyWith(
          documents: updatedDocuments,
          selectedDocument: updatedDocument,
          documentVersions: versions,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          selectedDocument: updatedDocument,
          isLoading: false,
        );
      }

      return updatedDocument;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error updating document: $e',
      );
      return null;
    }
  }

  /// Delete a document
  Future<bool> deleteDocument(String documentId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final success = await repository.deleteDocument(documentId);

      if (success) {
        // Remove document from list
        final updatedDocuments =
            state.documents.where((doc) => doc.id != documentId).toList();

        state = state.copyWith(
          documents: updatedDocuments,
          documentVersions: [],
          documentShares: [],
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete document',
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error deleting document: $e',
      );
      return false;
    }
  }

  /// Load document content
  Future<Uint8List?> getDocumentContent(String documentId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final content = await repository.getDocumentContent(documentId);

      state = state.copyWith(isLoading: false);
      return content;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading content: $e',
      );
      return null;
    }
  }

  /// Load content of a specific version
  Future<Uint8List?> getVersionContent(
    String documentId,
    String versionId,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final content =
          await repository.getDocumentVersionContent(documentId, versionId);

      state = state.copyWith(isLoading: false);
      return content;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading version: $e',
      );
      return null;
    }
  }

  /// Share a document
  Future<DocumentShare?> shareDocument({
    required String documentId,
    required String recipientDescription,
    String? recipientId,
    required DateTime expiresAt,
    required DocumentShareAccessType accessType,
    String? accessCode,
    int? maxAccessCount,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final share = await repository.shareDocument(
        documentId: documentId,
        recipientDescription: recipientDescription,
        recipientId: recipientId,
        expiresAt: expiresAt,
        accessType: accessType,
        accessCode: accessCode,
        maxAccessCount: maxAccessCount,
      );

      // Update shares list
      final updatedShares = [...state.documentShares, share];
      state = state.copyWith(
        documentShares: updatedShares,
        isLoading: false,
      );

      return share;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error sharing document: $e',
      );
      return null;
    }
  }

  /// Revoke a share
  Future<bool> revokeShare(String shareId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final success = await repository.revokeDocumentShare(shareId);

      if (success) {
        // Remove share from list
        final updatedShares =
            state.documentShares.where((share) => share.id != shareId).toList();

        state = state.copyWith(
          documentShares: updatedShares,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to revoke share',
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error revoking share: $e',
      );
      return false;
    }
  }

  /// Load documents shared with the user
  Future<void> loadSharedWithMe(String identityAddress) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final shares = await repository.getSharedWithMe(identityAddress);

      state = state.copyWith(
        sharedWithMe: shares,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading shared documents: $e',
      );
    }
  }

  /// Verify document authenticity
  Future<DocumentVerificationStatus?> verifyDocumentAuthenticity(
    String documentId,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final status = await repository.verifyDocumentAuthenticity(documentId);

      state = state.copyWith(isLoading: false);
      return status;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error verifying document: $e',
      );
      return null;
    }
  }

  /// Sign a document
  Future<Document?> signDocument({
    required String documentId,
    required String signerIdentityAddress,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final signedDocument = await repository.signDocument(
        documentId: documentId,
        signerIdentityAddress: signerIdentityAddress,
      );

      // Update document in the list and as selected document
      final index = state.documents.indexWhere((doc) => doc.id == documentId);
      if (index != -1) {
        final updatedDocuments = [...state.documents];
        updatedDocuments[index] = signedDocument;

        state = state.copyWith(
          documents: updatedDocuments,
          selectedDocument: signedDocument,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          selectedDocument: signedDocument,
          isLoading: false,
        );
      }

      return signedDocument;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error signing document: $e',
      );
      return null;
    }
  }

  /// Access a shared document
  Future<Document?> accessSharedDocument(
    String shareUrl,
    String? accessCode,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final document =
          await repository.accessSharedDocument(shareUrl, accessCode);

      if (document != null) {
        state = state.copyWith(
          selectedDocument: document,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Shared document not available',
        );
      }

      return document;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error accessing shared document: $e',
      );
      return null;
    }
  }
}
