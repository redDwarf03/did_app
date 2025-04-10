import 'dart:typed_data';

import 'package:did_app/domain/document/document.dart';
import 'package:did_app/domain/document/document_repository.dart';
import 'package:did_app/infrastructure/document/mock_document_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le repository de documents
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  // TODO: Replace mock implementation with real document storage on blockchain
  // This should implement secure storage of documents, with end-to-end encryption
  // and proper access control based on user permissions
  return MockDocumentRepository();
});

/// État de la gestion des documents
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

  /// Liste des documents de l'utilisateur
  final List<Document> documents;

  /// Document actuellement sélectionné
  final Document? selectedDocument;

  /// Indicateur de chargement
  final bool isLoading;

  /// Message d'erreur éventuel
  final String? errorMessage;

  /// Liste des versions pour le document sélectionné
  final List<DocumentVersion> documentVersions;

  /// Version sélectionnée
  final DocumentVersion? selectedVersion;

  /// Liste des partages pour le document sélectionné
  final List<DocumentShare> documentShares;

  /// Liste des documents partagés avec l'utilisateur
  final List<DocumentShare> sharedWithMe;

  /// Méthode utilitaire pour copier l'instance avec des modifications
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

/// Provider pour la gestion des documents
final documentNotifierProvider =
    StateNotifierProvider<DocumentNotifier, DocumentState>((ref) {
  return DocumentNotifier(ref);
});

/// Notifier pour la gestion des documents
class DocumentNotifier extends StateNotifier<DocumentState> {
  DocumentNotifier(this.ref) : super(const DocumentState());

  final Ref ref;

  /// Charger les documents d'un utilisateur
  Future<void> loadDocuments(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

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
        errorMessage:
            'Erreur lors du chargement des documents: ${e.toString()}',
      );
    }
  }

  /// Charger un document spécifique
  Future<void> loadDocument(String documentId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final document = await repository.getDocument(documentId);

      if (document != null) {
        // Charger également les versions et les partages
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
          errorMessage: 'Document non trouvé',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du chargement du document: ${e.toString()}',
      );
    }
  }

  /// Ajouter un nouveau document
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

      // Mettre à jour la liste des documents
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
        errorMessage: 'Erreur lors de l\'ajout du document: ${e.toString()}',
      );
      return null;
    }
  }

  /// Mettre à jour un document
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
    state = state.copyWith(isLoading: true, errorMessage: null);

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

      // Mettre à jour la liste des documents
      final index = state.documents.indexWhere((doc) => doc.id == documentId);
      if (index != -1) {
        final updatedDocuments = [...state.documents];
        updatedDocuments[index] = updatedDocument;

        // Charger les versions mises à jour
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
        errorMessage:
            'Erreur lors de la mise à jour du document: ${e.toString()}',
      );
      return null;
    }
  }

  /// Supprimer un document
  Future<bool> deleteDocument(String documentId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final success = await repository.deleteDocument(documentId);

      if (success) {
        // Supprimer le document de la liste
        final updatedDocuments =
            state.documents.where((doc) => doc.id != documentId).toList();

        state = state.copyWith(
          documents: updatedDocuments,
          selectedDocument: null,
          documentVersions: [],
          documentShares: [],
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Échec de la suppression du document',
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Erreur lors de la suppression du document: ${e.toString()}',
      );
      return false;
    }
  }

  /// Charger le contenu d'un document
  Future<Uint8List?> getDocumentContent(String documentId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final content = await repository.getDocumentContent(documentId);

      state = state.copyWith(isLoading: false);
      return content;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du chargement du contenu: ${e.toString()}',
      );
      return null;
    }
  }

  /// Charger le contenu d'une version spécifique
  Future<Uint8List?> getVersionContent(
      String documentId, String versionId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final content =
          await repository.getDocumentVersionContent(documentId, versionId);

      state = state.copyWith(isLoading: false);
      return content;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Erreur lors du chargement de la version: ${e.toString()}',
      );
      return null;
    }
  }

  /// Partager un document
  Future<DocumentShare?> shareDocument({
    required String documentId,
    required String recipientDescription,
    String? recipientId,
    required DateTime expiresAt,
    required DocumentShareAccessType accessType,
    String? accessCode,
    int? maxAccessCount,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

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

      // Mettre à jour la liste des partages
      final updatedShares = [...state.documentShares, share];
      state = state.copyWith(
        documentShares: updatedShares,
        isLoading: false,
      );

      return share;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du partage du document: ${e.toString()}',
      );
      return null;
    }
  }

  /// Révoquer un partage
  Future<bool> revokeShare(String shareId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final success = await repository.revokeDocumentShare(shareId);

      if (success) {
        // Supprimer le partage de la liste
        final updatedShares =
            state.documentShares.where((share) => share.id != shareId).toList();

        state = state.copyWith(
          documentShares: updatedShares,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Échec de la révocation du partage',
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Erreur lors de la révocation du partage: ${e.toString()}',
      );
      return false;
    }
  }

  /// Charger les documents partagés avec l'utilisateur
  Future<void> loadSharedWithMe(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

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
        errorMessage:
            'Erreur lors du chargement des documents partagés: ${e.toString()}',
      );
    }
  }

  /// Vérifier l'authenticité d'un document
  Future<DocumentVerificationStatus?> verifyDocumentAuthenticity(
      String documentId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final status = await repository.verifyDocumentAuthenticity(documentId);

      state = state.copyWith(isLoading: false);
      return status;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Erreur lors de la vérification du document: ${e.toString()}',
      );
      return null;
    }
  }

  /// Signer un document
  Future<Document?> signDocument({
    required String documentId,
    required String signerIdentityAddress,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(documentRepositoryProvider);
      final signedDocument = await repository.signDocument(
        documentId: documentId,
        signerIdentityAddress: signerIdentityAddress,
      );

      // Mettre à jour le document dans la liste et comme document sélectionné
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
        errorMessage:
            'Erreur lors de la signature du document: ${e.toString()}',
      );
      return null;
    }
  }

  /// Accéder à un document partagé
  Future<Document?> accessSharedDocument(
      String shareUrl, String? accessCode) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

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
          errorMessage: 'Document partagé non disponible',
        );
      }

      return document;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Erreur lors de l\'accès au document partagé: ${e.toString()}',
      );
      return null;
    }
  }
}
