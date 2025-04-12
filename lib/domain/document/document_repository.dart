import 'dart:typed_data';

import 'package:did_app/domain/document/document.dart';

/// Abstract interface defining the contract for managing digital documents.
///
/// This repository handles CRUD operations for [Document] objects, as well as
/// versioning, sharing, verification, and content retrieval.
/// Implementations will handle the underlying storage (e.g., local database,
/// cloud storage, blockchain interactions).
abstract class DocumentRepository {
  /// Checks if a user associated with the given [identityAddress] has any documents.
  ///
  /// Returns `true` if documents exist, `false` otherwise.
  Future<bool> hasDocuments(String identityAddress);

  /// Retrieves all documents belonging to the user identified by [identityAddress].
  ///
  /// Returns a list of [Document] objects.
  Future<List<Document>> getDocuments(String identityAddress);

  /// Retrieves a specific document by its unique [documentId].
  ///
  /// Returns the [Document] if found, otherwise `null`.
  Future<Document?> getDocument(String documentId);

  /// Adds a new document to the repository for the specified user.
  ///
  /// - [identityAddress]: The identifier of the document owner.
  /// - [fileBytes]: The binary content of the document file to be stored (will be encrypted).
  /// - [fileName]: The original name of the uploaded file.
  /// - [documentType]: The type of the document (e.g., passport, diploma). See [DocumentType].
  /// - [title]: A user-friendly title for the document.
  /// - [description]: An optional description.
  /// - [issuer]: The entity that issued the document.
  /// - [expiresAt]: Optional expiration date of the document.
  /// - [metadata]: Optional map of additional key-value metadata.
  /// - [tags]: Optional list of tags for categorization.
  /// - [isShareable]: Flag indicating if the document can be shared (defaults to false).
  /// - [eidasLevel]: The eIDAS assurance level of the document (defaults to low). See [EidasLevel].
  ///
  /// Returns the newly created [Document] object, including its assigned ID and metadata.
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

  /// Updates an existing document identified by [documentId].
  ///
  /// Allows modification of the document file content and/or its metadata.
  /// If [fileBytes] is provided, a new version of the document may be created.
  ///
  /// - [documentId]: The ID of the document to update.
  /// - [fileBytes]: Optional new binary content for the document file.
  /// - [title]: Optional new title.
  /// - [description]: Optional new description.
  /// - [issuer]: Optional updated issuer information.
  /// - [expiresAt]: Optional updated expiration date.
  /// - [metadata]: Optional updated metadata map.
  /// - [tags]: Optional updated list of tags.
  /// - [isShareable]: Optional updated shareability flag.
  /// - [eidasLevel]: Optional updated eIDAS level.
  /// - [changeNote]: An optional note describing the reason for the update (used for version history).
  ///
  /// Returns the updated [Document] object.
  Future<Document> updateDocument({
    required String documentId,
    Uint8List? fileBytes, // Make optional as we might only update metadata
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

  /// Deletes a document identified by [documentId].
  ///
  /// This operation should securely remove the document metadata and its encrypted content.
  /// Returns `true` if deletion was successful, `false` otherwise.
  Future<bool> deleteDocument(String documentId);

  /// Retrieves the decrypted binary content of a document.
  ///
  /// - [documentId]: The ID of the document whose content is requested.
  ///
  /// **Security Note:** This method handles decryption. Ensure proper access controls are in place.
  /// Returns the document content as a [Uint8List].
  Future<Uint8List> getDocumentContent(String documentId);

  /// Retrieves the version history for a specific document.
  ///
  /// - [documentId]: The ID of the document.
  ///
  /// Returns a list of [DocumentVersion] objects, typically ordered from newest to oldest.
  Future<List<DocumentVersion>> getDocumentVersions(String documentId);

  /// Retrieves the decrypted binary content of a specific historical version of a document.
  ///
  /// - [documentId]: The ID of the parent document.
  /// - [versionId]: The ID of the specific [DocumentVersion] to retrieve.
  ///
  /// **Security Note:** Handles decryption of historical data.
  /// Returns the content of the specified version as a [Uint8List].
  Future<Uint8List> getDocumentVersionContent(
    String documentId,
    String versionId,
  );

  /// Creates a shareable link/record for a document.
  ///
  /// - [documentId]: The ID of the document to share.
  /// - [recipientDescription]: A textual description of the intended recipient.
  /// - [recipientId]: Optional identifier of the recipient if they are a known user.
  /// - [expiresAt]: The date and time when the share will automatically expire.
  /// - [accessType]: The level of access granted to the recipient. See [DocumentShareAccessType].
  /// - [accessCode]: Optional PIN or code required to access the share.
  /// - [maxAccessCount]: Optional limit on the number of times the share can be accessed.
  ///
  /// Returns a [DocumentShare] object containing details of the created share, including the `shareUrl`.
  Future<DocumentShare> shareDocument({
    required String documentId,
    required String recipientDescription,
    String? recipientId,
    required DateTime expiresAt,
    required DocumentShareAccessType accessType,
    String? accessCode,
    int? maxAccessCount,
  });

  /// Revokes an active document share, making it inaccessible.
  ///
  /// - [shareId]: The unique ID of the [DocumentShare] to revoke.
  ///
  /// Returns `true` if revocation was successful, `false` otherwise.
  Future<bool> revokeDocumentShare(String shareId);

  /// Retrieves all active sharing records associated with a specific document.
  ///
  /// - [documentId]: The ID of the document.
  ///
  /// Returns a list of active [DocumentShare] objects.
  Future<List<DocumentShare>> getDocumentShares(String documentId);

  /// Verifies the authenticity and integrity of a document.
  ///
  /// This might involve checking the document hash, verifying the issuer's signature,
  /// or querying an external verification service.
  ///
  /// - [documentId]: The ID of the document to verify.
  ///
  /// Returns the resulting [DocumentVerificationStatus].
  Future<DocumentVerificationStatus> verifyDocumentAuthenticity(
    String documentId,
  );

  /// Specifically verifies the digital signature (e.g., `issuerSignature`) of a document.
  ///
  /// This usually requires fetching the issuer's public key (potentially via `issuerAddress`).
  ///
  /// - [documentId]: The ID of the document whose signature is to be verified.
  ///
  /// Returns `true` if the signature is valid, `false` otherwise.
  Future<bool> verifyDocumentSignature(String documentId);

  /// Verifies the existence proof of the document on a blockchain, if available.
  ///
  /// Checks if the `blockchainTxId` associated with the document corresponds to a valid
  /// transaction on the relevant blockchain.
  ///
  /// - [documentId]: The ID of the document.
  ///
  /// Returns `true` if the blockchain proof is valid, `false` otherwise or if not applicable.
  Future<bool> verifyBlockchainProof(String documentId);

  /// Retrieves a list of documents that have been shared *with* the user identified by [identityAddress].
  ///
  /// Returns a list of [DocumentShare] objects representing shares where the user is the recipient.
  Future<List<DocumentShare>> getSharedWithMe(String identityAddress);

  /// Accesses the details of a document shared via a URL, potentially requiring an access code.
  ///
  /// This method is used by a recipient to view a document shared with them.
  /// It should handle access counting and expiration checks based on the [DocumentShare] rules.
  ///
  /// - [shareUrl]: The unique URL identifying the share.
  /// - [accessCode]: The access code, if required by the share settings.
  ///
  /// Returns the [Document] metadata if access is granted and the share is valid, `null` otherwise.
  /// Note: This typically returns document *metadata* only, not the full content initially.
  /// Content retrieval might be a separate step depending on the access type.
  Future<Document?> accessSharedDocument(
    String shareUrl,
    String? accessCode,
  );

  /// Signs a document, presumably by the issuer identified by [signerIdentityAddress].
  ///
  /// This method would calculate the document hash, create a digital signature using the
  /// signer's private key, and update the [Document.issuerSignature] and potentially
  /// [Document.issuerAddress] fields.
  ///
  /// - [documentId]: The ID of the document to be signed.
  /// - [signerIdentityAddress]: The identity address of the entity signing the document.
  ///
  /// Returns the updated [Document] with the signature information added.
  Future<Document> signDocument({
    required String documentId,
    required String signerIdentityAddress,
  });
}
