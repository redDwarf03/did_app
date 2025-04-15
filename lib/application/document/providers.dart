import 'dart:typed_data';

import 'package:did_app/domain/document/document.dart';
import 'package:did_app/domain/document/document_repository.dart';
import 'package:did_app/infrastructure/document/mock_document_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.freezed.dart';
part 'providers.g.dart';

/// Provides an instance of [DocumentRepository].
///
/// This repository handles the storage and retrieval of user documents
/// (e.g., PDFs, images) in a secure manner, potentially using blockchain
/// or other secure storage solutions.
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  // TODO: Replace mock implementation with real document storage (e.g., on blockchain).
  // Ensure implementation includes encryption and access control.
  return MockDocumentRepository();
});

/// Represents the state for document management features.
@freezed
class DocumentState with _$DocumentState {
  const factory DocumentState({
    /// List of documents owned by the user.
    @Default([]) List<Document> documents,

    /// The currently selected document (e.g., for viewing details).
    Document? selectedDocument,

    /// Indicates if a document-related operation is in progress.
    @Default(false) bool isLoading,

    /// Holds a potential error message from the last operation.
    String? errorMessage,

    /// List of versions for the [selectedDocument].
    @Default([]) List<DocumentVersion> documentVersions,

    /// The currently selected version of the [selectedDocument].
    DocumentVersion? selectedVersion,

    /// List of shares created by the user for the [selectedDocument].
    @Default([]) List<DocumentShare> documentShares,

    /// List of documents shared with the current user by others.
    @Default([]) List<DocumentShare> sharedWithMe,
  }) = _DocumentState;
}

/// Provider for the [DocumentNotifier] which manages the [DocumentState].

/// Manages the state and orchestrates operations related to user documents.
///
/// Interacts with the [DocumentRepository] to load, add, update, delete,
/// share, and manage document versions and access.
@riverpod
class DocumentNotifier extends _$DocumentNotifier {
  /// Creates an instance of [DocumentNotifier].
  /// Requires a [Ref] to access the [documentRepositoryProvider].

  @override
  DocumentState build() {
    // Implement build method
    // Initial state
    return const DocumentState();
  }

  // Helper to get repository
  DocumentRepository get _repository => ref.read(documentRepositoryProvider);

  /// Loads the list of documents owned by the specified identity.
  Future<void> loadDocuments(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final documents = await _repository.getDocuments(identityAddress);
      state = state.copyWith(documents: documents, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading documents: $e',
      );
    }
  }

  /// Loads the details of a specific document, including its versions and shares.
  Future<void> loadDocument(String documentId) async {
    state = state.copyWith(
        isLoading: true, errorMessage: null, selectedDocument: null);
    try {
      final document = await _repository.getDocument(documentId);

      if (document != null) {
        // Also load associated versions and shares created by the owner.
        final versions = await _repository.getDocumentVersions(documentId);
        final shares = await _repository.getDocumentShares(documentId);
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
        errorMessage: 'Error loading document details: $e',
      );
    }
  }

  /// Adds a new document to the repository for the user.
  ///
  /// Requires document content, metadata, and identity address.
  /// Returns the newly created [Document] object or null on failure.
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
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final document = await _repository.addDocument(
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

      // Add the new document to the local list and select it.
      final updatedDocuments = [...state.documents, document];
      state = state.copyWith(
        documents: updatedDocuments,
        selectedDocument: document,
        documentVersions: [],
        documentShares: [],
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

  /// Updates an existing document, typically creating a new version.
  ///
  /// Requires the document ID and new file content, along with any updated metadata.
  /// Returns the updated [Document] object (representing the latest version) or null on failure.
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
    String? changeNote, // Note explaining the reason for the update
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final updatedDocument = await _repository.updateDocument(
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

      // Update the document in the local list.
      final index = state.documents.indexWhere((doc) => doc.id == documentId);
      if (index != -1) {
        final updatedDocuments = [...state.documents];
        updatedDocuments[index] = updatedDocument;
        // Reload versions to include the new one.
        final versions = await _repository.getDocumentVersions(documentId);
        state = state.copyWith(
          documents: updatedDocuments,
          selectedDocument: updatedDocument,
          documentVersions: versions,
          isLoading: false,
        );
      } else {
        // Should not happen if updating an existing doc, but handle gracefully.
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

  /// Deletes a document and all its associated data (versions, shares).
  /// Returns `true` on success, `false` otherwise.
  Future<bool> deleteDocument(String documentId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // final repository = ref.read(documentRepositoryProvider);
      final success = await _repository.deleteDocument(documentId);

      if (success) {
        // Remove the document from the local list.
        final updatedDocuments =
            state.documents.where((doc) => doc.id != documentId).toList();
        // Clear related state if the selected document was deleted.
        final isSelectedDocDeleted = state.selectedDocument?.id == documentId;
        state = state.copyWith(
          documents: updatedDocuments,
          selectedDocument:
              isSelectedDocDeleted ? null : state.selectedDocument,
          documentVersions: isSelectedDocDeleted ? [] : state.documentVersions,
          documentShares: isSelectedDocDeleted ? [] : state.documentShares,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete document from repository',
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

  /// Retrieves the actual content (file bytes) of the latest version of a document.
  Future<Uint8List?> getDocumentContent(String documentId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final content = await _repository.getDocumentContent(documentId);
      state = state.copyWith(isLoading: false);
      return content;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading document content: $e',
      );
      return null;
    }
  }

  /// Retrieves the actual content (file bytes) of a specific version of a document.
  Future<Uint8List?> getVersionContent(
    String documentId,
    String versionId,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final content =
          await _repository.getDocumentVersionContent(documentId, versionId);
      state = state.copyWith(isLoading: false);
      return content;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading version content: $e',
      );
      return null;
    }
  }

  /// Creates a share record for a document, allowing others to access it.
  ///
  /// - [documentId]: The ID of the document to share.
  /// - [recipientDescription]: A description of the recipient (e.g., email, name).
  /// - [recipientId]: Optional identifier of the recipient (e.g., DID).
  /// - [expiresAt]: When the share access expires.
  /// - [accessType]: The type of access (e.g., view, download).
  /// - [accessCode]: Optional code required to access the share.
  /// - [maxAccessCount]: Optional limit on the number of accesses.
  ///
  /// Returns the created [DocumentShare] object or null on failure.
  Future<DocumentShare?> shareDocument({
    required String documentId,
    required String recipientDescription,
    String? recipientId,
    required DateTime expiresAt,
    required DocumentShareAccessType accessType,
    String? accessCode,
    int? maxAccessCount,
  }) async {
    // Ensure a document is selected before sharing
    if (state.selectedDocument?.id != documentId) {
      await loadDocument(documentId);
      if (state.selectedDocument?.id != documentId) {
        state = state.copyWith(
            errorMessage: 'Cannot share: Document not loaded or found.');
        return null;
      }
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final share = await _repository.shareDocument(
        documentId: documentId,
        recipientDescription: recipientDescription,
        recipientId: recipientId,
        expiresAt: expiresAt,
        accessType: accessType,
        accessCode: accessCode,
        maxAccessCount: maxAccessCount,
      );

      // Add the new share to the local list for the selected document.
      final updatedShares = [...state.documentShares, share];
      state = state.copyWith(documentShares: updatedShares, isLoading: false);
      return share;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error sharing document: $e',
      );
      return null;
    }
  }

  /// Revokes a previously created share.
  /// Returns `true` on success, `false` otherwise.
  Future<bool> revokeShare(String shareId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _repository.revokeDocumentShare(shareId);

      if (success) {
        // Remove the share from the local list.
        final updatedShares =
            state.documentShares.where((share) => share.id != shareId).toList();
        state = state.copyWith(documentShares: updatedShares, isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to revoke share in repository',
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

  /// Loads the list of documents that have been shared with the current user.
  Future<void> loadSharedWithMe(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Fetches share records pointing to the current user.
      final shares = await _repository.getSharedWithMe(identityAddress);
      state = state.copyWith(sharedWithMe: shares, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading documents shared with me: $e',
      );
    }
  }

  /// Verifies the authenticity of a document (e.g., checking signatures, integrity).
  /// The specific verification logic depends on the repository implementation.
  /// Returns a [DocumentVerificationStatus] or null on failure.
  Future<DocumentVerificationStatus?> verifyDocumentAuthenticity(
    String documentId,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final status = await _repository.verifyDocumentAuthenticity(documentId);
      state = state.copyWith(isLoading: false);
      // Note: Status is returned but not stored directly in the main state.
      // UI might display it temporarily.
      return status;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error verifying document authenticity: $e',
      );
      return null;
    }
  }

  /// Signs a document using the specified signer's identity.
  /// This typically adds a signature to the document metadata or content.
  /// Returns the updated [Document] object with the signature or null on failure.
  Future<Document?> signDocument({
    required String documentId,
    required String signerIdentityAddress, // e.g., User's DID
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final signedDocument = await _repository.signDocument(
        documentId: documentId,
        signerIdentityAddress: signerIdentityAddress,
      );

      // Update the document in the local list and selected state.
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
        // Document might have been deleted or not loaded yet.
        state =
            state.copyWith(selectedDocument: signedDocument, isLoading: false);
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

  /// Accesses a document shared via a URL, potentially requiring an access code.
  /// Returns the accessed [Document] or null if access fails.
  Future<Document?> accessSharedDocument(
    String shareUrl, // URL received by the recipient
    String? accessCode, // Optional code provided by the recipient
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final document =
          await _repository.accessSharedDocument(shareUrl, accessCode);

      if (document != null) {
        // Document accessed successfully, potentially store it or display details.
        // For now, just update selectedDocument.
        state = state.copyWith(selectedDocument: document, isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Failed to access shared document. Invalid URL, code, or permissions.',
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
