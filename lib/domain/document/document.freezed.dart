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
  /// Identifiant unique du document
  String get id => throw _privateConstructorUsedError;

  /// Type du document (carte d'identité, passeport, diplôme, etc.)
  DocumentType get type => throw _privateConstructorUsedError;

  /// Titre du document
  String get title => throw _privateConstructorUsedError;

  /// Description du document
  String? get description => throw _privateConstructorUsedError;

  /// Émetteur du document (autorité, institution, etc.)
  String get issuer => throw _privateConstructorUsedError;

  /// Date d'émission du document
  DateTime get issuedAt => throw _privateConstructorUsedError;

  /// Date d'expiration du document (si applicable)
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Version actuelle du document
  int get version => throw _privateConstructorUsedError;

  /// Métadonnées du document (format JSON)
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// État de vérification du document
  DocumentVerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;

  /// Chemin de stockage du document chiffré
  String get encryptedStoragePath => throw _privateConstructorUsedError;

  /// Hash du document pour vérification d'intégrité
  String get documentHash => throw _privateConstructorUsedError;

  /// Vecteur d'initialisation pour le déchiffrement
  String get encryptionIV => throw _privateConstructorUsedError;

  /// Signature numérique de l'émetteur
  String? get issuerSignature => throw _privateConstructorUsedError;

  /// Adresse blockchain de l'émetteur (pour vérification)
  String? get issuerAddress => throw _privateConstructorUsedError;

  /// Identifiant de transaction blockchain (pour preuve d'existence)
  String? get blockchainTxId => throw _privateConstructorUsedError;

  /// Timestamp de la dernière mise à jour
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Identifiant du propriétaire du document
  String get ownerIdentityId => throw _privateConstructorUsedError;

  /// Tags pour la recherche et le classement
  List<String>? get tags => throw _privateConstructorUsedError;

  /// Indique si le document est partageable
  bool get isShareable => throw _privateConstructorUsedError;

  /// Niveau eIDAS du document (pour conformité européenne)
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

  /// Identifiant unique du document
  @override
  final String id;

  /// Type du document (carte d'identité, passeport, diplôme, etc.)
  @override
  final DocumentType type;

  /// Titre du document
  @override
  final String title;

  /// Description du document
  @override
  final String? description;

  /// Émetteur du document (autorité, institution, etc.)
  @override
  final String issuer;

  /// Date d'émission du document
  @override
  final DateTime issuedAt;

  /// Date d'expiration du document (si applicable)
  @override
  final DateTime? expiresAt;

  /// Version actuelle du document
  @override
  final int version;

  /// Métadonnées du document (format JSON)
  final Map<String, dynamic>? _metadata;

  /// Métadonnées du document (format JSON)
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// État de vérification du document
  @override
  final DocumentVerificationStatus verificationStatus;

  /// Chemin de stockage du document chiffré
  @override
  final String encryptedStoragePath;

  /// Hash du document pour vérification d'intégrité
  @override
  final String documentHash;

  /// Vecteur d'initialisation pour le déchiffrement
  @override
  final String encryptionIV;

  /// Signature numérique de l'émetteur
  @override
  final String? issuerSignature;

  /// Adresse blockchain de l'émetteur (pour vérification)
  @override
  final String? issuerAddress;

  /// Identifiant de transaction blockchain (pour preuve d'existence)
  @override
  final String? blockchainTxId;

  /// Timestamp de la dernière mise à jour
  @override
  final DateTime updatedAt;

  /// Identifiant du propriétaire du document
  @override
  final String ownerIdentityId;

  /// Tags pour la recherche et le classement
  final List<String>? _tags;

  /// Tags pour la recherche et le classement
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Indique si le document est partageable
  @override
  @JsonKey()
  final bool isShareable;

  /// Niveau eIDAS du document (pour conformité européenne)
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

  /// Identifiant unique du document
  @override
  String get id;

  /// Type du document (carte d'identité, passeport, diplôme, etc.)
  @override
  DocumentType get type;

  /// Titre du document
  @override
  String get title;

  /// Description du document
  @override
  String? get description;

  /// Émetteur du document (autorité, institution, etc.)
  @override
  String get issuer;

  /// Date d'émission du document
  @override
  DateTime get issuedAt;

  /// Date d'expiration du document (si applicable)
  @override
  DateTime? get expiresAt;

  /// Version actuelle du document
  @override
  int get version;

  /// Métadonnées du document (format JSON)
  @override
  Map<String, dynamic>? get metadata;

  /// État de vérification du document
  @override
  DocumentVerificationStatus get verificationStatus;

  /// Chemin de stockage du document chiffré
  @override
  String get encryptedStoragePath;

  /// Hash du document pour vérification d'intégrité
  @override
  String get documentHash;

  /// Vecteur d'initialisation pour le déchiffrement
  @override
  String get encryptionIV;

  /// Signature numérique de l'émetteur
  @override
  String? get issuerSignature;

  /// Adresse blockchain de l'émetteur (pour vérification)
  @override
  String? get issuerAddress;

  /// Identifiant de transaction blockchain (pour preuve d'existence)
  @override
  String? get blockchainTxId;

  /// Timestamp de la dernière mise à jour
  @override
  DateTime get updatedAt;

  /// Identifiant du propriétaire du document
  @override
  String get ownerIdentityId;

  /// Tags pour la recherche et le classement
  @override
  List<String>? get tags;

  /// Indique si le document est partageable
  @override
  bool get isShareable;

  /// Niveau eIDAS du document (pour conformité européenne)
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
  /// Identifiant de version
  String get id => throw _privateConstructorUsedError;

  /// Numéro de version
  int get versionNumber => throw _privateConstructorUsedError;

  /// Date de création de cette version
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Hash du document pour vérification d'intégrité
  String get documentHash => throw _privateConstructorUsedError;

  /// Chemin de stockage du document chiffré
  String get encryptedStoragePath => throw _privateConstructorUsedError;

  /// Vecteur d'initialisation pour le déchiffrement
  String get encryptionIV => throw _privateConstructorUsedError;

  /// Identifiant de transaction blockchain (pour preuve d'existence)
  String? get blockchainTxId => throw _privateConstructorUsedError;

  /// Note sur la modification apportée
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

  /// Identifiant de version
  @override
  final String id;

  /// Numéro de version
  @override
  final int versionNumber;

  /// Date de création de cette version
  @override
  final DateTime createdAt;

  /// Hash du document pour vérification d'intégrité
  @override
  final String documentHash;

  /// Chemin de stockage du document chiffré
  @override
  final String encryptedStoragePath;

  /// Vecteur d'initialisation pour le déchiffrement
  @override
  final String encryptionIV;

  /// Identifiant de transaction blockchain (pour preuve d'existence)
  @override
  final String? blockchainTxId;

  /// Note sur la modification apportée
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

  /// Identifiant de version
  @override
  String get id;

  /// Numéro de version
  @override
  int get versionNumber;

  /// Date de création de cette version
  @override
  DateTime get createdAt;

  /// Hash du document pour vérification d'intégrité
  @override
  String get documentHash;

  /// Chemin de stockage du document chiffré
  @override
  String get encryptedStoragePath;

  /// Vecteur d'initialisation pour le déchiffrement
  @override
  String get encryptionIV;

  /// Identifiant de transaction blockchain (pour preuve d'existence)
  @override
  String? get blockchainTxId;

  /// Note sur la modification apportée
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
  /// Identifiant unique du partage
  String get id => throw _privateConstructorUsedError;

  /// Identifiant du document partagé
  String get documentId => throw _privateConstructorUsedError;

  /// Titre du document (pour affichage au destinataire)
  String get documentTitle => throw _privateConstructorUsedError;

  /// Identifiant du destinataire (si connu)
  String? get recipientId => throw _privateConstructorUsedError;

  /// Description ou nom du destinataire
  String get recipientDescription => throw _privateConstructorUsedError;

  /// Date de création du partage
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Date d'expiration du partage
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// URL de partage (pour accès externe)
  String get shareUrl => throw _privateConstructorUsedError;

  /// Code d'accès ou PIN (optionnel, pour sécurité supplémentaire)
  String? get accessCode => throw _privateConstructorUsedError;

  /// Indique si le partage est actif
  bool get isActive => throw _privateConstructorUsedError;

  /// Nombre maximal d'accès autorisés
  int? get maxAccessCount => throw _privateConstructorUsedError;

  /// Nombre d'accès effectués
  int get accessCount => throw _privateConstructorUsedError;

  /// Type d'accès accordé
  DocumentShareAccessType get accessType => throw _privateConstructorUsedError;

  /// Dernier accès au document partagé
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

  /// Identifiant unique du partage
  @override
  final String id;

  /// Identifiant du document partagé
  @override
  final String documentId;

  /// Titre du document (pour affichage au destinataire)
  @override
  final String documentTitle;

  /// Identifiant du destinataire (si connu)
  @override
  final String? recipientId;

  /// Description ou nom du destinataire
  @override
  final String recipientDescription;

  /// Date de création du partage
  @override
  final DateTime createdAt;

  /// Date d'expiration du partage
  @override
  final DateTime expiresAt;

  /// URL de partage (pour accès externe)
  @override
  final String shareUrl;

  /// Code d'accès ou PIN (optionnel, pour sécurité supplémentaire)
  @override
  final String? accessCode;

  /// Indique si le partage est actif
  @override
  @JsonKey()
  final bool isActive;

  /// Nombre maximal d'accès autorisés
  @override
  final int? maxAccessCount;

  /// Nombre d'accès effectués
  @override
  @JsonKey()
  final int accessCount;

  /// Type d'accès accordé
  @override
  final DocumentShareAccessType accessType;

  /// Dernier accès au document partagé
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

  /// Identifiant unique du partage
  @override
  String get id;

  /// Identifiant du document partagé
  @override
  String get documentId;

  /// Titre du document (pour affichage au destinataire)
  @override
  String get documentTitle;

  /// Identifiant du destinataire (si connu)
  @override
  String? get recipientId;

  /// Description ou nom du destinataire
  @override
  String get recipientDescription;

  /// Date de création du partage
  @override
  DateTime get createdAt;

  /// Date d'expiration du partage
  @override
  DateTime get expiresAt;

  /// URL de partage (pour accès externe)
  @override
  String get shareUrl;

  /// Code d'accès ou PIN (optionnel, pour sécurité supplémentaire)
  @override
  String? get accessCode;

  /// Indique si le partage est actif
  @override
  bool get isActive;

  /// Nombre maximal d'accès autorisés
  @override
  int? get maxAccessCount;

  /// Nombre d'accès effectués
  @override
  int get accessCount;

  /// Type d'accès accordé
  @override
  DocumentShareAccessType get accessType;

  /// Dernier accès au document partagé
  @override
  DateTime? get lastAccessedAt;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentShareImplCopyWith<_$DocumentShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
