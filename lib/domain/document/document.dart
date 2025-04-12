import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

/// Represents a digital document stored within the identity wallet.
///
/// This class encapsulates the data and metadata associated with a verifiable digital
/// document, such as an ID card, passport, diploma, or certificate.
/// It includes details about the document itself, its issuance, verification status,
/// security parameters (encryption, hashing), and potential blockchain anchoring.
@freezed
class Document with _$Document {
  const factory Document({
    /// A unique identifier for this specific document instance within the system.
    required String id,

    /// The type or category of the document. See [DocumentType].
    required DocumentType type,

    /// A user-friendly title or name for the document (e.g., "My Passport", "Bachelor's Degree").
    required String title,

    /// An optional description providing more context about the document.
    String? description,

    /// The entity (authority, institution, organization) that issued the document.
    /// (e.g., "Government of Exampleland", "University of Knowledge").
    required String issuer,

    /// The date and time when the document was officially issued.
    required DateTime issuedAt,

    /// The date and time when the document expires, if applicable (e.g., for passports, licenses).
    DateTime? expiresAt,

    /// The current version number of the document, used for tracking updates.
    required int version,

    /// Optional additional metadata associated with the document, stored as a JSON-like map.
    /// Could include details specific to the document type (e.g., grade for a diploma).
    Map<String, dynamic>? metadata,

    /// The current verification status of the document. See [DocumentVerificationStatus].
    required DocumentVerificationStatus verificationStatus,

    /// The path or reference indicating where the encrypted document file is stored.
    /// **Security Note:** The actual document content should always be stored encrypted.
    required String encryptedStoragePath,

    /// A cryptographic hash (e.g., SHA-256) of the original document file.
    /// Used to verify the integrity and ensure the document hasn't been tampered with.
    required String documentHash,

    /// The Initialization Vector (IV) used for the symmetric encryption (e.g., AES) of the document.
    /// Required alongside the key to decrypt the document content.
    required String encryptionIV,

    /// A digital signature created by the issuer using their private key.
    /// Can be verified using the issuer's public key (potentially linked via `issuerAddress`)
    /// to confirm authenticity and integrity.
    String? issuerSignature,

    /// The blockchain address or Decentralized Identifier (DID) of the document issuer.
    /// Used to retrieve the issuer's public key for verifying the `issuerSignature`.
    String? issuerAddress,

    /// The transaction ID on a blockchain where an event related to this document
    /// (e.g., issuance, revocation) was recorded. Provides a proof of existence/anchoring.
    String? blockchainTxId,

    /// The timestamp of the last update made to this document record.
    required DateTime updatedAt,

    /// The unique identifier ([DigitalIdentity.identityAddress]) of the identity that owns this document.
    required String ownerIdentityId,

    /// Optional list of tags or keywords for easier searching and categorization.
    List<String>? tags,

    /// Flag indicating if the owner permits this document to be shared with others.
    @Default(false) bool isShareable,

    /// The assessed eIDAS assurance level for this document, relevant for EU contexts.
    /// See [EidasLevel] and the eIDAS regulation (Regulation (EU) No 910/2014).
    @Default(EidasLevel.low) EidasLevel eidasLevel,
  }) = _Document;

  /// Creates a [Document] instance from a JSON map.
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}

/// Enumerates the supported types of documents.
enum DocumentType {
  /// National Identity Card.
  nationalId,

  /// Passport.
  passport,

  /// Driver's License.
  drivingLicense,

  /// Academic Diploma (e.g., Bachelor's, Master's).
  diploma,

  /// Professional or training certificate.
  certificate,

  /// Document verifying a residential address (e.g., utility bill).
  addressProof,

  /// Document related to banking (e.g., bank statement).
  bankDocument,

  /// Medical record or certificate.
  medicalRecord,

  /// Document related to a company or business.
  corporateDocument,

  /// Any other type of document not listed above.
  other
}

/// Defines the possible verification statuses of a [Document].
enum DocumentVerificationStatus {
  /// The document has not been verified by any authority or system.
  unverified,

  /// The document is currently undergoing a verification process.
  pending,

  /// The document has been successfully verified for authenticity and validity.
  verified,

  /// The document verification process failed or was rejected.
  rejected,

  /// The document was once valid but has now passed its expiration date.
  expired
}

/// Represents a historical version of a [Document].
///
/// Used to track changes and maintain an audit trail of document updates.
@freezed
class DocumentVersion with _$DocumentVersion {
  const factory DocumentVersion({
    /// Unique identifier for this specific version entry.
    required String id,

    /// The sequential version number (corresponds to [Document.version] at the time).
    required int versionNumber,

    /// Timestamp indicating when this version was created (i.e., when the update occurred).
    required DateTime createdAt,

    /// The cryptographic hash of the document file as it existed in this version.
    required String documentHash,

    /// The storage path of the encrypted document file for this version.
    required String encryptedStoragePath,

    /// The Initialization Vector (IV) used for encrypting this version of the document.
    required String encryptionIV,

    /// Optional blockchain transaction ID anchoring this specific version.
    String? blockchainTxId,

    /// An optional note describing the changes made in this version.
    String? changeNote,
  }) = _DocumentVersion;

  /// Creates a [DocumentVersion] instance from a JSON map.
  factory DocumentVersion.fromJson(Map<String, dynamic> json) =>
      _$DocumentVersionFromJson(json);
}

/// Represents the act of sharing a [Document] with a third party.
///
/// This manages the permissions, duration, and access control for sharing documents.
@freezed
class DocumentShare with _$DocumentShare {
  const factory DocumentShare({
    /// Unique identifier for this specific sharing instance.
    required String id,

    /// The identifier ([Document.id]) of the document being shared.
    required String documentId,

    /// The title of the document, shown to the recipient for context.
    required String documentTitle,

    /// The identifier of the recipient, if they are a known user in the system.
    String? recipientId,

    /// A description or name identifying the recipient (e.g., "Bank XYZ", "HR Department").
    required String recipientDescription,

    /// Timestamp when the share was created.
    required DateTime createdAt,

    /// Timestamp when the access granted by this share expires.
    required DateTime expiresAt,

    /// A unique URL that the recipient can use to access the shared document.
    required String shareUrl,

    /// An optional access code or PIN required by the recipient to view the document,
    /// providing an extra layer of security.
    String? accessCode,

    /// Flag indicating whether this share is currently active and usable.
    @Default(true) bool isActive,

    /// Optional limit on the total number of times the document can be accessed via this share.
    int? maxAccessCount,

    /// The number of times the document has been accessed through this share so far.
    @Default(0) int accessCount,

    /// The type of access granted to the recipient. See [DocumentShareAccessType].
    required DocumentShareAccessType accessType,

    /// Timestamp of the most recent access by the recipient.
    DateTime? lastAccessedAt,
  }) = _DocumentShare;

  /// Creates a [DocumentShare] instance from a JSON map.
  factory DocumentShare.fromJson(Map<String, dynamic> json) =>
      _$DocumentShareFromJson(json);
}

/// Defines the types of access permissions that can be granted when sharing a document.
enum DocumentShareAccessType {
  /// Recipient can only view the document content.
  readOnly,

  /// Recipient can view and download a copy of the document.
  download,

  /// Recipient (typically an institution) can view the document and potentially trigger
  /// a verification process based on it.
  verify,

  /// Recipient has comprehensive access, potentially including viewing, downloading,
  /// and using the document data.
  fullAccess
}

/// Represents the levels of assurance defined by the eIDAS regulation (EU No 910/2014).
///
/// These levels indicate the degree of confidence in the claimed identity or the
/// authenticity/integrity of an electronic document or signature.
/// Relevant primarily within the European Union for cross-border electronic transactions.
enum EidasLevel {
  /// Provides a limited degree of confidence.
  /// Suitable for low-risk scenarios.
  low,

  /// Provides a substantial degree of confidence.
  /// Suitable for moderate-risk scenarios requiring higher assurance than 'low'.
  substantial,

  /// Provides the highest degree of confidence.
  /// Suitable for high-risk scenarios and legally binding transactions requiring
  /// the equivalent of face-to-face identification.
  high
}
