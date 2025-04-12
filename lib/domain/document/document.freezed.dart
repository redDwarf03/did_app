// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return _Document.fromJson(json);
}

/// @nodoc
mixin _$Document {
  /// A unique identifier for this specific document instance within the system.
  String get id => throw _privateConstructorUsedError;

  /// The type or category of the document. See [DocumentType].
  DocumentType get type => throw _privateConstructorUsedError;

  /// A user-friendly title or name for the document (e.g., "My Passport", "Bachelor's Degree").
  String get title => throw _privateConstructorUsedError;

  /// An optional description providing more context about the document.
  String? get description => throw _privateConstructorUsedError;

  /// The entity (authority, institution, organization) that issued the document.
  /// (e.g., "Government of Exampleland", "University of Knowledge").
  String get issuer => throw _privateConstructorUsedError;

  /// The date and time when the document was officially issued.
  DateTime get issuedAt => throw _privateConstructorUsedError;

  /// The date and time when the document expires, if applicable (e.g., for passports, licenses).
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// The current version number of the document, used for tracking updates.
  int get version => throw _privateConstructorUsedError;

  /// Optional additional metadata associated with the document, stored as a JSON-like map.
  /// Could include details specific to the document type (e.g., grade for a diploma).
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// The current verification status of the document. See [DocumentVerificationStatus].
  DocumentVerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;

  /// The path or reference indicating where the encrypted document file is stored.
  /// **Security Note:** The actual document content should always be stored encrypted.
  String get encryptedStoragePath => throw _privateConstructorUsedError;

  /// A cryptographic hash (e.g., SHA-256) of the original document file.
  /// Used to verify the integrity and ensure the document hasn't been tampered with.
  String get documentHash => throw _privateConstructorUsedError;

  /// The Initialization Vector (IV) used for the symmetric encryption (e.g., AES) of the document.
  /// Required alongside the key to decrypt the document content.
  String get encryptionIV => throw _privateConstructorUsedError;

  /// A digital signature created by the issuer using their private key.
  /// Can be verified using the issuer's public key (potentially linked via `issuerAddress`)
  /// to confirm authenticity and integrity.
  String? get issuerSignature => throw _privateConstructorUsedError;

  /// The blockchain address or Decentralized Identifier (DID) of the document issuer.
  /// Used to retrieve the issuer's public key for verifying the `issuerSignature`.
  String? get issuerAddress => throw _privateConstructorUsedError;

  /// The transaction ID on a blockchain where an event related to this document
  /// (e.g., issuance, revocation) was recorded. Provides a proof of existence/anchoring.
  String? get blockchainTxId => throw _privateConstructorUsedError;

  /// The timestamp of the last update made to this document record.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// The unique identifier ([DigitalIdentity.identityAddress]) of the identity that owns this document.
  String get ownerIdentityId => throw _privateConstructorUsedError;

  /// Optional list of tags or keywords for easier searching and categorization.
  List<String>? get tags => throw _privateConstructorUsedError;

  /// Flag indicating if the owner permits this document to be shared with others.
  bool get isShareable => throw _privateConstructorUsedError;

  /// The assessed eIDAS assurance level for this document, relevant for EU contexts.
  /// See [EidasLevel] and the eIDAS regulation (Regulation (EU) No 910/2014).
  EidasLevel get eidasLevel => throw _privateConstructorUsedError;

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call(
      {String id,
      DocumentType type,
      String title,
      String? description,
      String issuer,
      DateTime issuedAt,
      DateTime? expiresAt,
      int version,
      Map<String, dynamic>? metadata,
      DocumentVerificationStatus verificationStatus,
      String encryptedStoragePath,
      String documentHash,
      String encryptionIV,
      String? issuerSignature,
      String? issuerAddress,
      String? blockchainTxId,
      DateTime updatedAt,
      String ownerIdentityId,
      List<String>? tags,
      bool isShareable,
      EidasLevel eidasLevel});
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? description = freezed,
    Object? issuer = null,
    Object? issuedAt = null,
    Object? expiresAt = freezed,
    Object? version = null,
    Object? metadata = freezed,
    Object? verificationStatus = null,
    Object? encryptedStoragePath = null,
    Object? documentHash = null,
    Object? encryptionIV = null,
    Object? issuerSignature = freezed,
    Object? issuerAddress = freezed,
    Object? blockchainTxId = freezed,
    Object? updatedAt = null,
    Object? ownerIdentityId = null,
    Object? tags = freezed,
    Object? isShareable = null,
    Object? eidasLevel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DocumentType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as DocumentVerificationStatus,
      encryptedStoragePath: null == encryptedStoragePath
          ? _value.encryptedStoragePath
          : encryptedStoragePath // ignore: cast_nullable_to_non_nullable
              as String,
      documentHash: null == documentHash
          ? _value.documentHash
          : documentHash // ignore: cast_nullable_to_non_nullable
              as String,
      encryptionIV: null == encryptionIV
          ? _value.encryptionIV
          : encryptionIV // ignore: cast_nullable_to_non_nullable
              as String,
      issuerSignature: freezed == issuerSignature
          ? _value.issuerSignature
          : issuerSignature // ignore: cast_nullable_to_non_nullable
              as String?,
      issuerAddress: freezed == issuerAddress
          ? _value.issuerAddress
          : issuerAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      blockchainTxId: freezed == blockchainTxId
          ? _value.blockchainTxId
          : blockchainTxId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ownerIdentityId: null == ownerIdentityId
          ? _value.ownerIdentityId
          : ownerIdentityId // ignore: cast_nullable_to_non_nullable
              as String,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isShareable: null == isShareable
          ? _value.isShareable
          : isShareable // ignore: cast_nullable_to_non_nullable
              as bool,
      eidasLevel: null == eidasLevel
          ? _value.eidasLevel
          : eidasLevel // ignore: cast_nullable_to_non_nullable
              as EidasLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
          _$DocumentImpl value, $Res Function(_$DocumentImpl) then) =
      __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DocumentType type,
      String title,
      String? description,
      String issuer,
      DateTime issuedAt,
      DateTime? expiresAt,
      int version,
      Map<String, dynamic>? metadata,
      DocumentVerificationStatus verificationStatus,
      String encryptedStoragePath,
      String documentHash,
      String encryptionIV,
      String? issuerSignature,
      String? issuerAddress,
      String? blockchainTxId,
      DateTime updatedAt,
      String ownerIdentityId,
      List<String>? tags,
      bool isShareable,
      EidasLevel eidasLevel});
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
      _$DocumentImpl _value, $Res Function(_$DocumentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? description = freezed,
    Object? issuer = null,
    Object? issuedAt = null,
    Object? expiresAt = freezed,
    Object? version = null,
    Object? metadata = freezed,
    Object? verificationStatus = null,
    Object? encryptedStoragePath = null,
    Object? documentHash = null,
    Object? encryptionIV = null,
    Object? issuerSignature = freezed,
    Object? issuerAddress = freezed,
    Object? blockchainTxId = freezed,
    Object? updatedAt = null,
    Object? ownerIdentityId = null,
    Object? tags = freezed,
    Object? isShareable = null,
    Object? eidasLevel = null,
  }) {
    return _then(_$DocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DocumentType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as DocumentVerificationStatus,
      encryptedStoragePath: null == encryptedStoragePath
          ? _value.encryptedStoragePath
          : encryptedStoragePath // ignore: cast_nullable_to_non_nullable
              as String,
      documentHash: null == documentHash
          ? _value.documentHash
          : documentHash // ignore: cast_nullable_to_non_nullable
              as String,
      encryptionIV: null == encryptionIV
          ? _value.encryptionIV
          : encryptionIV // ignore: cast_nullable_to_non_nullable
              as String,
      issuerSignature: freezed == issuerSignature
          ? _value.issuerSignature
          : issuerSignature // ignore: cast_nullable_to_non_nullable
              as String?,
      issuerAddress: freezed == issuerAddress
          ? _value.issuerAddress
          : issuerAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      blockchainTxId: freezed == blockchainTxId
          ? _value.blockchainTxId
          : blockchainTxId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ownerIdentityId: null == ownerIdentityId
          ? _value.ownerIdentityId
          : ownerIdentityId // ignore: cast_nullable_to_non_nullable
              as String,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isShareable: null == isShareable
          ? _value.isShareable
          : isShareable // ignore: cast_nullable_to_non_nullable
              as bool,
      eidasLevel: null == eidasLevel
          ? _value.eidasLevel
          : eidasLevel // ignore: cast_nullable_to_non_nullable
              as EidasLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentImpl implements _Document {
  const _$DocumentImpl(
      {required this.id,
      required this.type,
      required this.title,
      this.description,
      required this.issuer,
      required this.issuedAt,
      this.expiresAt,
      required this.version,
      final Map<String, dynamic>? metadata,
      required this.verificationStatus,
      required this.encryptedStoragePath,
      required this.documentHash,
      required this.encryptionIV,
      this.issuerSignature,
      this.issuerAddress,
      this.blockchainTxId,
      required this.updatedAt,
      required this.ownerIdentityId,
      final List<String>? tags,
      this.isShareable = false,
      this.eidasLevel = EidasLevel.low})
      : _metadata = metadata,
        _tags = tags;

  factory _$DocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentImplFromJson(json);

  /// A unique identifier for this specific document instance within the system.
  @override
  final String id;

  /// The type or category of the document. See [DocumentType].
  @override
  final DocumentType type;

  /// A user-friendly title or name for the document (e.g., "My Passport", "Bachelor's Degree").
  @override
  final String title;

  /// An optional description providing more context about the document.
  @override
  final String? description;

  /// The entity (authority, institution, organization) that issued the document.
  /// (e.g., "Government of Exampleland", "University of Knowledge").
  @override
  final String issuer;

  /// The date and time when the document was officially issued.
  @override
  final DateTime issuedAt;

  /// The date and time when the document expires, if applicable (e.g., for passports, licenses).
  @override
  final DateTime? expiresAt;

  /// The current version number of the document, used for tracking updates.
  @override
  final int version;

  /// Optional additional metadata associated with the document, stored as a JSON-like map.
  /// Could include details specific to the document type (e.g., grade for a diploma).
  final Map<String, dynamic>? _metadata;

  /// Optional additional metadata associated with the document, stored as a JSON-like map.
  /// Could include details specific to the document type (e.g., grade for a diploma).
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// The current verification status of the document. See [DocumentVerificationStatus].
  @override
  final DocumentVerificationStatus verificationStatus;

  /// The path or reference indicating where the encrypted document file is stored.
  /// **Security Note:** The actual document content should always be stored encrypted.
  @override
  final String encryptedStoragePath;

  /// A cryptographic hash (e.g., SHA-256) of the original document file.
  /// Used to verify the integrity and ensure the document hasn't been tampered with.
  @override
  final String documentHash;

  /// The Initialization Vector (IV) used for the symmetric encryption (e.g., AES) of the document.
  /// Required alongside the key to decrypt the document content.
  @override
  final String encryptionIV;

  /// A digital signature created by the issuer using their private key.
  /// Can be verified using the issuer's public key (potentially linked via `issuerAddress`)
  /// to confirm authenticity and integrity.
  @override
  final String? issuerSignature;

  /// The blockchain address or Decentralized Identifier (DID) of the document issuer.
  /// Used to retrieve the issuer's public key for verifying the `issuerSignature`.
  @override
  final String? issuerAddress;

  /// The transaction ID on a blockchain where an event related to this document
  /// (e.g., issuance, revocation) was recorded. Provides a proof of existence/anchoring.
  @override
  final String? blockchainTxId;

  /// The timestamp of the last update made to this document record.
  @override
  final DateTime updatedAt;

  /// The unique identifier ([DigitalIdentity.identityAddress]) of the identity that owns this document.
  @override
  final String ownerIdentityId;

  /// Optional list of tags or keywords for easier searching and categorization.
  final List<String>? _tags;

  /// Optional list of tags or keywords for easier searching and categorization.
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Flag indicating if the owner permits this document to be shared with others.
  @override
  @JsonKey()
  final bool isShareable;

  /// The assessed eIDAS assurance level for this document, relevant for EU contexts.
  /// See [EidasLevel] and the eIDAS regulation (Regulation (EU) No 910/2014).
  @override
  @JsonKey()
  final EidasLevel eidasLevel;

  @override
  String toString() {
    return 'Document(id: $id, type: $type, title: $title, description: $description, issuer: $issuer, issuedAt: $issuedAt, expiresAt: $expiresAt, version: $version, metadata: $metadata, verificationStatus: $verificationStatus, encryptedStoragePath: $encryptedStoragePath, documentHash: $documentHash, encryptionIV: $encryptionIV, issuerSignature: $issuerSignature, issuerAddress: $issuerAddress, blockchainTxId: $blockchainTxId, updatedAt: $updatedAt, ownerIdentityId: $ownerIdentityId, tags: $tags, isShareable: $isShareable, eidasLevel: $eidasLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            (identical(other.encryptedStoragePath, encryptedStoragePath) ||
                other.encryptedStoragePath == encryptedStoragePath) &&
            (identical(other.documentHash, documentHash) ||
                other.documentHash == documentHash) &&
            (identical(other.encryptionIV, encryptionIV) ||
                other.encryptionIV == encryptionIV) &&
            (identical(other.issuerSignature, issuerSignature) ||
                other.issuerSignature == issuerSignature) &&
            (identical(other.issuerAddress, issuerAddress) ||
                other.issuerAddress == issuerAddress) &&
            (identical(other.blockchainTxId, blockchainTxId) ||
                other.blockchainTxId == blockchainTxId) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.ownerIdentityId, ownerIdentityId) ||
                other.ownerIdentityId == ownerIdentityId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isShareable, isShareable) ||
                other.isShareable == isShareable) &&
            (identical(other.eidasLevel, eidasLevel) ||
                other.eidasLevel == eidasLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        type,
        title,
        description,
        issuer,
        issuedAt,
        expiresAt,
        version,
        const DeepCollectionEquality().hash(_metadata),
        verificationStatus,
        encryptedStoragePath,
        documentHash,
        encryptionIV,
        issuerSignature,
        issuerAddress,
        blockchainTxId,
        updatedAt,
        ownerIdentityId,
        const DeepCollectionEquality().hash(_tags),
        isShareable,
        eidasLevel
      ]);

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentImplToJson(
      this,
    );
  }
}

abstract class _Document implements Document {
  const factory _Document(
      {required final String id,
      required final DocumentType type,
      required final String title,
      final String? description,
      required final String issuer,
      required final DateTime issuedAt,
      final DateTime? expiresAt,
      required final int version,
      final Map<String, dynamic>? metadata,
      required final DocumentVerificationStatus verificationStatus,
      required final String encryptedStoragePath,
      required final String documentHash,
      required final String encryptionIV,
      final String? issuerSignature,
      final String? issuerAddress,
      final String? blockchainTxId,
      required final DateTime updatedAt,
      required final String ownerIdentityId,
      final List<String>? tags,
      final bool isShareable,
      final EidasLevel eidasLevel}) = _$DocumentImpl;

  factory _Document.fromJson(Map<String, dynamic> json) =
      _$DocumentImpl.fromJson;

  /// A unique identifier for this specific document instance within the system.
  @override
  String get id;

  /// The type or category of the document. See [DocumentType].
  @override
  DocumentType get type;

  /// A user-friendly title or name for the document (e.g., "My Passport", "Bachelor's Degree").
  @override
  String get title;

  /// An optional description providing more context about the document.
  @override
  String? get description;

  /// The entity (authority, institution, organization) that issued the document.
  /// (e.g., "Government of Exampleland", "University of Knowledge").
  @override
  String get issuer;

  /// The date and time when the document was officially issued.
  @override
  DateTime get issuedAt;

  /// The date and time when the document expires, if applicable (e.g., for passports, licenses).
  @override
  DateTime? get expiresAt;

  /// The current version number of the document, used for tracking updates.
  @override
  int get version;

  /// Optional additional metadata associated with the document, stored as a JSON-like map.
  /// Could include details specific to the document type (e.g., grade for a diploma).
  @override
  Map<String, dynamic>? get metadata;

  /// The current verification status of the document. See [DocumentVerificationStatus].
  @override
  DocumentVerificationStatus get verificationStatus;

  /// The path or reference indicating where the encrypted document file is stored.
  /// **Security Note:** The actual document content should always be stored encrypted.
  @override
  String get encryptedStoragePath;

  /// A cryptographic hash (e.g., SHA-256) of the original document file.
  /// Used to verify the integrity and ensure the document hasn't been tampered with.
  @override
  String get documentHash;

  /// The Initialization Vector (IV) used for the symmetric encryption (e.g., AES) of the document.
  /// Required alongside the key to decrypt the document content.
  @override
  String get encryptionIV;

  /// A digital signature created by the issuer using their private key.
  /// Can be verified using the issuer's public key (potentially linked via `issuerAddress`)
  /// to confirm authenticity and integrity.
  @override
  String? get issuerSignature;

  /// The blockchain address or Decentralized Identifier (DID) of the document issuer.
  /// Used to retrieve the issuer's public key for verifying the `issuerSignature`.
  @override
  String? get issuerAddress;

  /// The transaction ID on a blockchain where an event related to this document
  /// (e.g., issuance, revocation) was recorded. Provides a proof of existence/anchoring.
  @override
  String? get blockchainTxId;

  /// The timestamp of the last update made to this document record.
  @override
  DateTime get updatedAt;

  /// The unique identifier ([DigitalIdentity.identityAddress]) of the identity that owns this document.
  @override
  String get ownerIdentityId;

  /// Optional list of tags or keywords for easier searching and categorization.
  @override
  List<String>? get tags;

  /// Flag indicating if the owner permits this document to be shared with others.
  @override
  bool get isShareable;

  /// The assessed eIDAS assurance level for this document, relevant for EU contexts.
  /// See [EidasLevel] and the eIDAS regulation (Regulation (EU) No 910/2014).
  @override
  EidasLevel get eidasLevel;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentVersion _$DocumentVersionFromJson(Map<String, dynamic> json) {
  return _DocumentVersion.fromJson(json);
}

/// @nodoc
mixin _$DocumentVersion {
  /// Unique identifier for this specific version entry.
  String get id => throw _privateConstructorUsedError;

  /// The sequential version number (corresponds to [Document.version] at the time).
  int get versionNumber => throw _privateConstructorUsedError;

  /// Timestamp indicating when this version was created (i.e., when the update occurred).
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The cryptographic hash of the document file as it existed in this version.
  String get documentHash => throw _privateConstructorUsedError;

  /// The storage path of the encrypted document file for this version.
  String get encryptedStoragePath => throw _privateConstructorUsedError;

  /// The Initialization Vector (IV) used for encrypting this version of the document.
  String get encryptionIV => throw _privateConstructorUsedError;

  /// Optional blockchain transaction ID anchoring this specific version.
  String? get blockchainTxId => throw _privateConstructorUsedError;

  /// An optional note describing the changes made in this version.
  String? get changeNote => throw _privateConstructorUsedError;

  /// Serializes this DocumentVersion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentVersionCopyWith<DocumentVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentVersionCopyWith<$Res> {
  factory $DocumentVersionCopyWith(
          DocumentVersion value, $Res Function(DocumentVersion) then) =
      _$DocumentVersionCopyWithImpl<$Res, DocumentVersion>;
  @useResult
  $Res call(
      {String id,
      int versionNumber,
      DateTime createdAt,
      String documentHash,
      String encryptedStoragePath,
      String encryptionIV,
      String? blockchainTxId,
      String? changeNote});
}

/// @nodoc
class _$DocumentVersionCopyWithImpl<$Res, $Val extends DocumentVersion>
    implements $DocumentVersionCopyWith<$Res> {
  _$DocumentVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? versionNumber = null,
    Object? createdAt = null,
    Object? documentHash = null,
    Object? encryptedStoragePath = null,
    Object? encryptionIV = null,
    Object? blockchainTxId = freezed,
    Object? changeNote = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      versionNumber: null == versionNumber
          ? _value.versionNumber
          : versionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      documentHash: null == documentHash
          ? _value.documentHash
          : documentHash // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedStoragePath: null == encryptedStoragePath
          ? _value.encryptedStoragePath
          : encryptedStoragePath // ignore: cast_nullable_to_non_nullable
              as String,
      encryptionIV: null == encryptionIV
          ? _value.encryptionIV
          : encryptionIV // ignore: cast_nullable_to_non_nullable
              as String,
      blockchainTxId: freezed == blockchainTxId
          ? _value.blockchainTxId
          : blockchainTxId // ignore: cast_nullable_to_non_nullable
              as String?,
      changeNote: freezed == changeNote
          ? _value.changeNote
          : changeNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentVersionImplCopyWith<$Res>
    implements $DocumentVersionCopyWith<$Res> {
  factory _$$DocumentVersionImplCopyWith(_$DocumentVersionImpl value,
          $Res Function(_$DocumentVersionImpl) then) =
      __$$DocumentVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int versionNumber,
      DateTime createdAt,
      String documentHash,
      String encryptedStoragePath,
      String encryptionIV,
      String? blockchainTxId,
      String? changeNote});
}

/// @nodoc
class __$$DocumentVersionImplCopyWithImpl<$Res>
    extends _$DocumentVersionCopyWithImpl<$Res, _$DocumentVersionImpl>
    implements _$$DocumentVersionImplCopyWith<$Res> {
  __$$DocumentVersionImplCopyWithImpl(
      _$DocumentVersionImpl _value, $Res Function(_$DocumentVersionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? versionNumber = null,
    Object? createdAt = null,
    Object? documentHash = null,
    Object? encryptedStoragePath = null,
    Object? encryptionIV = null,
    Object? blockchainTxId = freezed,
    Object? changeNote = freezed,
  }) {
    return _then(_$DocumentVersionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      versionNumber: null == versionNumber
          ? _value.versionNumber
          : versionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      documentHash: null == documentHash
          ? _value.documentHash
          : documentHash // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedStoragePath: null == encryptedStoragePath
          ? _value.encryptedStoragePath
          : encryptedStoragePath // ignore: cast_nullable_to_non_nullable
              as String,
      encryptionIV: null == encryptionIV
          ? _value.encryptionIV
          : encryptionIV // ignore: cast_nullable_to_non_nullable
              as String,
      blockchainTxId: freezed == blockchainTxId
          ? _value.blockchainTxId
          : blockchainTxId // ignore: cast_nullable_to_non_nullable
              as String?,
      changeNote: freezed == changeNote
          ? _value.changeNote
          : changeNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentVersionImpl implements _DocumentVersion {
  const _$DocumentVersionImpl(
      {required this.id,
      required this.versionNumber,
      required this.createdAt,
      required this.documentHash,
      required this.encryptedStoragePath,
      required this.encryptionIV,
      this.blockchainTxId,
      this.changeNote});

  factory _$DocumentVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentVersionImplFromJson(json);

  /// Unique identifier for this specific version entry.
  @override
  final String id;

  /// The sequential version number (corresponds to [Document.version] at the time).
  @override
  final int versionNumber;

  /// Timestamp indicating when this version was created (i.e., when the update occurred).
  @override
  final DateTime createdAt;

  /// The cryptographic hash of the document file as it existed in this version.
  @override
  final String documentHash;

  /// The storage path of the encrypted document file for this version.
  @override
  final String encryptedStoragePath;

  /// The Initialization Vector (IV) used for encrypting this version of the document.
  @override
  final String encryptionIV;

  /// Optional blockchain transaction ID anchoring this specific version.
  @override
  final String? blockchainTxId;

  /// An optional note describing the changes made in this version.
  @override
  final String? changeNote;

  @override
  String toString() {
    return 'DocumentVersion(id: $id, versionNumber: $versionNumber, createdAt: $createdAt, documentHash: $documentHash, encryptedStoragePath: $encryptedStoragePath, encryptionIV: $encryptionIV, blockchainTxId: $blockchainTxId, changeNote: $changeNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentVersionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.versionNumber, versionNumber) ||
                other.versionNumber == versionNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.documentHash, documentHash) ||
                other.documentHash == documentHash) &&
            (identical(other.encryptedStoragePath, encryptedStoragePath) ||
                other.encryptedStoragePath == encryptedStoragePath) &&
            (identical(other.encryptionIV, encryptionIV) ||
                other.encryptionIV == encryptionIV) &&
            (identical(other.blockchainTxId, blockchainTxId) ||
                other.blockchainTxId == blockchainTxId) &&
            (identical(other.changeNote, changeNote) ||
                other.changeNote == changeNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      versionNumber,
      createdAt,
      documentHash,
      encryptedStoragePath,
      encryptionIV,
      blockchainTxId,
      changeNote);

  /// Create a copy of DocumentVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentVersionImplCopyWith<_$DocumentVersionImpl> get copyWith =>
      __$$DocumentVersionImplCopyWithImpl<_$DocumentVersionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentVersionImplToJson(
      this,
    );
  }
}

abstract class _DocumentVersion implements DocumentVersion {
  const factory _DocumentVersion(
      {required final String id,
      required final int versionNumber,
      required final DateTime createdAt,
      required final String documentHash,
      required final String encryptedStoragePath,
      required final String encryptionIV,
      final String? blockchainTxId,
      final String? changeNote}) = _$DocumentVersionImpl;

  factory _DocumentVersion.fromJson(Map<String, dynamic> json) =
      _$DocumentVersionImpl.fromJson;

  /// Unique identifier for this specific version entry.
  @override
  String get id;

  /// The sequential version number (corresponds to [Document.version] at the time).
  @override
  int get versionNumber;

  /// Timestamp indicating when this version was created (i.e., when the update occurred).
  @override
  DateTime get createdAt;

  /// The cryptographic hash of the document file as it existed in this version.
  @override
  String get documentHash;

  /// The storage path of the encrypted document file for this version.
  @override
  String get encryptedStoragePath;

  /// The Initialization Vector (IV) used for encrypting this version of the document.
  @override
  String get encryptionIV;

  /// Optional blockchain transaction ID anchoring this specific version.
  @override
  String? get blockchainTxId;

  /// An optional note describing the changes made in this version.
  @override
  String? get changeNote;

  /// Create a copy of DocumentVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentVersionImplCopyWith<_$DocumentVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentShare _$DocumentShareFromJson(Map<String, dynamic> json) {
  return _DocumentShare.fromJson(json);
}

/// @nodoc
mixin _$DocumentShare {
  /// Unique identifier for this specific sharing instance.
  String get id => throw _privateConstructorUsedError;

  /// The identifier ([Document.id]) of the document being shared.
  String get documentId => throw _privateConstructorUsedError;

  /// The title of the document, shown to the recipient for context.
  String get documentTitle => throw _privateConstructorUsedError;

  /// The identifier of the recipient, if they are a known user in the system.
  String? get recipientId => throw _privateConstructorUsedError;

  /// A description or name identifying the recipient (e.g., "Bank XYZ", "HR Department").
  String get recipientDescription => throw _privateConstructorUsedError;

  /// Timestamp when the share was created.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Timestamp when the access granted by this share expires.
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// A unique URL that the recipient can use to access the shared document.
  String get shareUrl => throw _privateConstructorUsedError;

  /// An optional access code or PIN required by the recipient to view the document,
  /// providing an extra layer of security.
  String? get accessCode => throw _privateConstructorUsedError;

  /// Flag indicating whether this share is currently active and usable.
  bool get isActive => throw _privateConstructorUsedError;

  /// Optional limit on the total number of times the document can be accessed via this share.
  int? get maxAccessCount => throw _privateConstructorUsedError;

  /// The number of times the document has been accessed through this share so far.
  int get accessCount => throw _privateConstructorUsedError;

  /// The type of access granted to the recipient. See [DocumentShareAccessType].
  DocumentShareAccessType get accessType => throw _privateConstructorUsedError;

  /// Timestamp of the most recent access by the recipient.
  DateTime? get lastAccessedAt => throw _privateConstructorUsedError;

  /// Serializes this DocumentShare to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentShareCopyWith<DocumentShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentShareCopyWith<$Res> {
  factory $DocumentShareCopyWith(
          DocumentShare value, $Res Function(DocumentShare) then) =
      _$DocumentShareCopyWithImpl<$Res, DocumentShare>;
  @useResult
  $Res call(
      {String id,
      String documentId,
      String documentTitle,
      String? recipientId,
      String recipientDescription,
      DateTime createdAt,
      DateTime expiresAt,
      String shareUrl,
      String? accessCode,
      bool isActive,
      int? maxAccessCount,
      int accessCount,
      DocumentShareAccessType accessType,
      DateTime? lastAccessedAt});
}

/// @nodoc
class _$DocumentShareCopyWithImpl<$Res, $Val extends DocumentShare>
    implements $DocumentShareCopyWith<$Res> {
  _$DocumentShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? documentTitle = null,
    Object? recipientId = freezed,
    Object? recipientDescription = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? shareUrl = null,
    Object? accessCode = freezed,
    Object? isActive = null,
    Object? maxAccessCount = freezed,
    Object? accessCount = null,
    Object? accessType = null,
    Object? lastAccessedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      documentTitle: null == documentTitle
          ? _value.documentTitle
          : documentTitle // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: freezed == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipientDescription: null == recipientDescription
          ? _value.recipientDescription
          : recipientDescription // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shareUrl: null == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String,
      accessCode: freezed == accessCode
          ? _value.accessCode
          : accessCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      maxAccessCount: freezed == maxAccessCount
          ? _value.maxAccessCount
          : maxAccessCount // ignore: cast_nullable_to_non_nullable
              as int?,
      accessCount: null == accessCount
          ? _value.accessCount
          : accessCount // ignore: cast_nullable_to_non_nullable
              as int,
      accessType: null == accessType
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as DocumentShareAccessType,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentShareImplCopyWith<$Res>
    implements $DocumentShareCopyWith<$Res> {
  factory _$$DocumentShareImplCopyWith(
          _$DocumentShareImpl value, $Res Function(_$DocumentShareImpl) then) =
      __$$DocumentShareImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String documentId,
      String documentTitle,
      String? recipientId,
      String recipientDescription,
      DateTime createdAt,
      DateTime expiresAt,
      String shareUrl,
      String? accessCode,
      bool isActive,
      int? maxAccessCount,
      int accessCount,
      DocumentShareAccessType accessType,
      DateTime? lastAccessedAt});
}

/// @nodoc
class __$$DocumentShareImplCopyWithImpl<$Res>
    extends _$DocumentShareCopyWithImpl<$Res, _$DocumentShareImpl>
    implements _$$DocumentShareImplCopyWith<$Res> {
  __$$DocumentShareImplCopyWithImpl(
      _$DocumentShareImpl _value, $Res Function(_$DocumentShareImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? documentTitle = null,
    Object? recipientId = freezed,
    Object? recipientDescription = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? shareUrl = null,
    Object? accessCode = freezed,
    Object? isActive = null,
    Object? maxAccessCount = freezed,
    Object? accessCount = null,
    Object? accessType = null,
    Object? lastAccessedAt = freezed,
  }) {
    return _then(_$DocumentShareImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      documentTitle: null == documentTitle
          ? _value.documentTitle
          : documentTitle // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: freezed == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipientDescription: null == recipientDescription
          ? _value.recipientDescription
          : recipientDescription // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shareUrl: null == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String,
      accessCode: freezed == accessCode
          ? _value.accessCode
          : accessCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      maxAccessCount: freezed == maxAccessCount
          ? _value.maxAccessCount
          : maxAccessCount // ignore: cast_nullable_to_non_nullable
              as int?,
      accessCount: null == accessCount
          ? _value.accessCount
          : accessCount // ignore: cast_nullable_to_non_nullable
              as int,
      accessType: null == accessType
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as DocumentShareAccessType,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentShareImpl implements _DocumentShare {
  const _$DocumentShareImpl(
      {required this.id,
      required this.documentId,
      required this.documentTitle,
      this.recipientId,
      required this.recipientDescription,
      required this.createdAt,
      required this.expiresAt,
      required this.shareUrl,
      this.accessCode,
      this.isActive = true,
      this.maxAccessCount,
      this.accessCount = 0,
      required this.accessType,
      this.lastAccessedAt});

  factory _$DocumentShareImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentShareImplFromJson(json);

  /// Unique identifier for this specific sharing instance.
  @override
  final String id;

  /// The identifier ([Document.id]) of the document being shared.
  @override
  final String documentId;

  /// The title of the document, shown to the recipient for context.
  @override
  final String documentTitle;

  /// The identifier of the recipient, if they are a known user in the system.
  @override
  final String? recipientId;

  /// A description or name identifying the recipient (e.g., "Bank XYZ", "HR Department").
  @override
  final String recipientDescription;

  /// Timestamp when the share was created.
  @override
  final DateTime createdAt;

  /// Timestamp when the access granted by this share expires.
  @override
  final DateTime expiresAt;

  /// A unique URL that the recipient can use to access the shared document.
  @override
  final String shareUrl;

  /// An optional access code or PIN required by the recipient to view the document,
  /// providing an extra layer of security.
  @override
  final String? accessCode;

  /// Flag indicating whether this share is currently active and usable.
  @override
  @JsonKey()
  final bool isActive;

  /// Optional limit on the total number of times the document can be accessed via this share.
  @override
  final int? maxAccessCount;

  /// The number of times the document has been accessed through this share so far.
  @override
  @JsonKey()
  final int accessCount;

  /// The type of access granted to the recipient. See [DocumentShareAccessType].
  @override
  final DocumentShareAccessType accessType;

  /// Timestamp of the most recent access by the recipient.
  @override
  final DateTime? lastAccessedAt;

  @override
  String toString() {
    return 'DocumentShare(id: $id, documentId: $documentId, documentTitle: $documentTitle, recipientId: $recipientId, recipientDescription: $recipientDescription, createdAt: $createdAt, expiresAt: $expiresAt, shareUrl: $shareUrl, accessCode: $accessCode, isActive: $isActive, maxAccessCount: $maxAccessCount, accessCount: $accessCount, accessType: $accessType, lastAccessedAt: $lastAccessedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentShareImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.documentTitle, documentTitle) ||
                other.documentTitle == documentTitle) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientDescription, recipientDescription) ||
                other.recipientDescription == recipientDescription) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.shareUrl, shareUrl) ||
                other.shareUrl == shareUrl) &&
            (identical(other.accessCode, accessCode) ||
                other.accessCode == accessCode) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.maxAccessCount, maxAccessCount) ||
                other.maxAccessCount == maxAccessCount) &&
            (identical(other.accessCount, accessCount) ||
                other.accessCount == accessCount) &&
            (identical(other.accessType, accessType) ||
                other.accessType == accessType) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      documentId,
      documentTitle,
      recipientId,
      recipientDescription,
      createdAt,
      expiresAt,
      shareUrl,
      accessCode,
      isActive,
      maxAccessCount,
      accessCount,
      accessType,
      lastAccessedAt);

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentShareImplCopyWith<_$DocumentShareImpl> get copyWith =>
      __$$DocumentShareImplCopyWithImpl<_$DocumentShareImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentShareImplToJson(
      this,
    );
  }
}

abstract class _DocumentShare implements DocumentShare {
  const factory _DocumentShare(
      {required final String id,
      required final String documentId,
      required final String documentTitle,
      final String? recipientId,
      required final String recipientDescription,
      required final DateTime createdAt,
      required final DateTime expiresAt,
      required final String shareUrl,
      final String? accessCode,
      final bool isActive,
      final int? maxAccessCount,
      final int accessCount,
      required final DocumentShareAccessType accessType,
      final DateTime? lastAccessedAt}) = _$DocumentShareImpl;

  factory _DocumentShare.fromJson(Map<String, dynamic> json) =
      _$DocumentShareImpl.fromJson;

  /// Unique identifier for this specific sharing instance.
  @override
  String get id;

  /// The identifier ([Document.id]) of the document being shared.
  @override
  String get documentId;

  /// The title of the document, shown to the recipient for context.
  @override
  String get documentTitle;

  /// The identifier of the recipient, if they are a known user in the system.
  @override
  String? get recipientId;

  /// A description or name identifying the recipient (e.g., "Bank XYZ", "HR Department").
  @override
  String get recipientDescription;

  /// Timestamp when the share was created.
  @override
  DateTime get createdAt;

  /// Timestamp when the access granted by this share expires.
  @override
  DateTime get expiresAt;

  /// A unique URL that the recipient can use to access the shared document.
  @override
  String get shareUrl;

  /// An optional access code or PIN required by the recipient to view the document,
  /// providing an extra layer of security.
  @override
  String? get accessCode;

  /// Flag indicating whether this share is currently active and usable.
  @override
  bool get isActive;

  /// Optional limit on the total number of times the document can be accessed via this share.
  @override
  int? get maxAccessCount;

  /// The number of times the document has been accessed through this share so far.
  @override
  int get accessCount;

  /// The type of access granted to the recipient. See [DocumentShareAccessType].
  @override
  DocumentShareAccessType get accessType;

  /// Timestamp of the most recent access by the recipient.
  @override
  DateTime? get lastAccessedAt;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentShareImplCopyWith<_$DocumentShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
