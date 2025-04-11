// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Credential _$CredentialFromJson(Map<String, dynamic> json) {
  return _Credential.fromJson(json);
}

/// @nodoc
mixin _$Credential {
  /// Identifiant unique de l'attestation
  String get id => throw _privateConstructorUsedError;

  /// Type d'attestation
  CredentialType get type => throw _privateConstructorUsedError;

  /// Nom de l'attestation
  String get name => throw _privateConstructorUsedError;

  /// Description de l'attestation
  String? get description => throw _privateConstructorUsedError;

  /// Émetteur de l'attestation (autorité, institution, etc.)
  String get issuer => throw _privateConstructorUsedError;

  /// Identifiant de l'émetteur (DID)
  String get issuerId => throw _privateConstructorUsedError;

  /// Sujet de l'attestation (à qui elle appartient)
  String get subjectId => throw _privateConstructorUsedError;

  /// Date d'émission
  DateTime get issuedAt => throw _privateConstructorUsedError;

  /// Date d'expiration (si applicable)
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Attributs vérifiables contenus dans l'attestation
  Map<String, dynamic> get claims => throw _privateConstructorUsedError;

  /// Schéma de l'attestation
  String get schemaId => throw _privateConstructorUsedError;

  /// Preuve cryptographique
  CredentialProof get proof => throw _privateConstructorUsedError;

  /// Statut de révocation
  RevocationStatus get revocationStatus => throw _privateConstructorUsedError;

  /// URL pour vérifier le statut de révocation
  String? get revocationRegistryUrl => throw _privateConstructorUsedError;

  /// Statut de vérification
  VerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;

  /// Indique si des preuves à divulgation nulle de connaissance sont disponibles
  bool get supportsZkp => throw _privateConstructorUsedError;

  /// Métadonnées supplémentaires
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this Credential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialCopyWith<Credential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialCopyWith<$Res> {
  factory $CredentialCopyWith(
          Credential value, $Res Function(Credential) then) =
      _$CredentialCopyWithImpl<$Res, Credential>;
  @useResult
  $Res call(
      {String id,
      CredentialType type,
      String name,
      String? description,
      String issuer,
      String issuerId,
      String subjectId,
      DateTime issuedAt,
      DateTime? expiresAt,
      Map<String, dynamic> claims,
      String schemaId,
      CredentialProof proof,
      RevocationStatus revocationStatus,
      String? revocationRegistryUrl,
      VerificationStatus verificationStatus,
      bool supportsZkp,
      Map<String, dynamic>? metadata});

  $CredentialProofCopyWith<$Res> get proof;
}

/// @nodoc
class _$CredentialCopyWithImpl<$Res, $Val extends Credential>
    implements $CredentialCopyWith<$Res> {
  _$CredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = freezed,
    Object? issuer = null,
    Object? issuerId = null,
    Object? subjectId = null,
    Object? issuedAt = null,
    Object? expiresAt = freezed,
    Object? claims = null,
    Object? schemaId = null,
    Object? proof = null,
    Object? revocationStatus = null,
    Object? revocationRegistryUrl = freezed,
    Object? verificationStatus = null,
    Object? supportsZkp = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CredentialType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuerId: null == issuerId
          ? _value.issuerId
          : issuerId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: null == subjectId
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      claims: null == claims
          ? _value.claims
          : claims // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      schemaId: null == schemaId
          ? _value.schemaId
          : schemaId // ignore: cast_nullable_to_non_nullable
              as String,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as CredentialProof,
      revocationStatus: null == revocationStatus
          ? _value.revocationStatus
          : revocationStatus // ignore: cast_nullable_to_non_nullable
              as RevocationStatus,
      revocationRegistryUrl: freezed == revocationRegistryUrl
          ? _value.revocationRegistryUrl
          : revocationRegistryUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      supportsZkp: null == supportsZkp
          ? _value.supportsZkp
          : supportsZkp // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialProofCopyWith<$Res> get proof {
    return $CredentialProofCopyWith<$Res>(_value.proof, (value) {
      return _then(_value.copyWith(proof: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CredentialImplCopyWith<$Res>
    implements $CredentialCopyWith<$Res> {
  factory _$$CredentialImplCopyWith(
          _$CredentialImpl value, $Res Function(_$CredentialImpl) then) =
      __$$CredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CredentialType type,
      String name,
      String? description,
      String issuer,
      String issuerId,
      String subjectId,
      DateTime issuedAt,
      DateTime? expiresAt,
      Map<String, dynamic> claims,
      String schemaId,
      CredentialProof proof,
      RevocationStatus revocationStatus,
      String? revocationRegistryUrl,
      VerificationStatus verificationStatus,
      bool supportsZkp,
      Map<String, dynamic>? metadata});

  @override
  $CredentialProofCopyWith<$Res> get proof;
}

/// @nodoc
class __$$CredentialImplCopyWithImpl<$Res>
    extends _$CredentialCopyWithImpl<$Res, _$CredentialImpl>
    implements _$$CredentialImplCopyWith<$Res> {
  __$$CredentialImplCopyWithImpl(
      _$CredentialImpl _value, $Res Function(_$CredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = freezed,
    Object? issuer = null,
    Object? issuerId = null,
    Object? subjectId = null,
    Object? issuedAt = null,
    Object? expiresAt = freezed,
    Object? claims = null,
    Object? schemaId = null,
    Object? proof = null,
    Object? revocationStatus = null,
    Object? revocationRegistryUrl = freezed,
    Object? verificationStatus = null,
    Object? supportsZkp = null,
    Object? metadata = freezed,
  }) {
    return _then(_$CredentialImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CredentialType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuerId: null == issuerId
          ? _value.issuerId
          : issuerId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: null == subjectId
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      claims: null == claims
          ? _value._claims
          : claims // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      schemaId: null == schemaId
          ? _value.schemaId
          : schemaId // ignore: cast_nullable_to_non_nullable
              as String,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as CredentialProof,
      revocationStatus: null == revocationStatus
          ? _value.revocationStatus
          : revocationStatus // ignore: cast_nullable_to_non_nullable
              as RevocationStatus,
      revocationRegistryUrl: freezed == revocationRegistryUrl
          ? _value.revocationRegistryUrl
          : revocationRegistryUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      supportsZkp: null == supportsZkp
          ? _value.supportsZkp
          : supportsZkp // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialImpl implements _Credential {
  const _$CredentialImpl(
      {required this.id,
      required this.type,
      required this.name,
      this.description,
      required this.issuer,
      required this.issuerId,
      required this.subjectId,
      required this.issuedAt,
      this.expiresAt,
      required final Map<String, dynamic> claims,
      required this.schemaId,
      required this.proof,
      required this.revocationStatus,
      this.revocationRegistryUrl,
      this.verificationStatus = VerificationStatus.unverified,
      this.supportsZkp = false,
      final Map<String, dynamic>? metadata})
      : _claims = claims,
        _metadata = metadata;

  factory _$CredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialImplFromJson(json);

  /// Identifiant unique de l'attestation
  @override
  final String id;

  /// Type d'attestation
  @override
  final CredentialType type;

  /// Nom de l'attestation
  @override
  final String name;

  /// Description de l'attestation
  @override
  final String? description;

  /// Émetteur de l'attestation (autorité, institution, etc.)
  @override
  final String issuer;

  /// Identifiant de l'émetteur (DID)
  @override
  final String issuerId;

  /// Sujet de l'attestation (à qui elle appartient)
  @override
  final String subjectId;

  /// Date d'émission
  @override
  final DateTime issuedAt;

  /// Date d'expiration (si applicable)
  @override
  final DateTime? expiresAt;

  /// Attributs vérifiables contenus dans l'attestation
  final Map<String, dynamic> _claims;

  /// Attributs vérifiables contenus dans l'attestation
  @override
  Map<String, dynamic> get claims {
    if (_claims is EqualUnmodifiableMapView) return _claims;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_claims);
  }

  /// Schéma de l'attestation
  @override
  final String schemaId;

  /// Preuve cryptographique
  @override
  final CredentialProof proof;

  /// Statut de révocation
  @override
  final RevocationStatus revocationStatus;

  /// URL pour vérifier le statut de révocation
  @override
  final String? revocationRegistryUrl;

  /// Statut de vérification
  @override
  @JsonKey()
  final VerificationStatus verificationStatus;

  /// Indique si des preuves à divulgation nulle de connaissance sont disponibles
  @override
  @JsonKey()
  final bool supportsZkp;

  /// Métadonnées supplémentaires
  final Map<String, dynamic>? _metadata;

  /// Métadonnées supplémentaires
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Credential(id: $id, type: $type, name: $name, description: $description, issuer: $issuer, issuerId: $issuerId, subjectId: $subjectId, issuedAt: $issuedAt, expiresAt: $expiresAt, claims: $claims, schemaId: $schemaId, proof: $proof, revocationStatus: $revocationStatus, revocationRegistryUrl: $revocationRegistryUrl, verificationStatus: $verificationStatus, supportsZkp: $supportsZkp, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.issuerId, issuerId) ||
                other.issuerId == issuerId) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._claims, _claims) &&
            (identical(other.schemaId, schemaId) ||
                other.schemaId == schemaId) &&
            (identical(other.proof, proof) || other.proof == proof) &&
            (identical(other.revocationStatus, revocationStatus) ||
                other.revocationStatus == revocationStatus) &&
            (identical(other.revocationRegistryUrl, revocationRegistryUrl) ||
                other.revocationRegistryUrl == revocationRegistryUrl) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            (identical(other.supportsZkp, supportsZkp) ||
                other.supportsZkp == supportsZkp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      name,
      description,
      issuer,
      issuerId,
      subjectId,
      issuedAt,
      expiresAt,
      const DeepCollectionEquality().hash(_claims),
      schemaId,
      proof,
      revocationStatus,
      revocationRegistryUrl,
      verificationStatus,
      supportsZkp,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialImplCopyWith<_$CredentialImpl> get copyWith =>
      __$$CredentialImplCopyWithImpl<_$CredentialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialImplToJson(
      this,
    );
  }
}

abstract class _Credential implements Credential {
  const factory _Credential(
      {required final String id,
      required final CredentialType type,
      required final String name,
      final String? description,
      required final String issuer,
      required final String issuerId,
      required final String subjectId,
      required final DateTime issuedAt,
      final DateTime? expiresAt,
      required final Map<String, dynamic> claims,
      required final String schemaId,
      required final CredentialProof proof,
      required final RevocationStatus revocationStatus,
      final String? revocationRegistryUrl,
      final VerificationStatus verificationStatus,
      final bool supportsZkp,
      final Map<String, dynamic>? metadata}) = _$CredentialImpl;

  factory _Credential.fromJson(Map<String, dynamic> json) =
      _$CredentialImpl.fromJson;

  /// Identifiant unique de l'attestation
  @override
  String get id;

  /// Type d'attestation
  @override
  CredentialType get type;

  /// Nom de l'attestation
  @override
  String get name;

  /// Description de l'attestation
  @override
  String? get description;

  /// Émetteur de l'attestation (autorité, institution, etc.)
  @override
  String get issuer;

  /// Identifiant de l'émetteur (DID)
  @override
  String get issuerId;

  /// Sujet de l'attestation (à qui elle appartient)
  @override
  String get subjectId;

  /// Date d'émission
  @override
  DateTime get issuedAt;

  /// Date d'expiration (si applicable)
  @override
  DateTime? get expiresAt;

  /// Attributs vérifiables contenus dans l'attestation
  @override
  Map<String, dynamic> get claims;

  /// Schéma de l'attestation
  @override
  String get schemaId;

  /// Preuve cryptographique
  @override
  CredentialProof get proof;

  /// Statut de révocation
  @override
  RevocationStatus get revocationStatus;

  /// URL pour vérifier le statut de révocation
  @override
  String? get revocationRegistryUrl;

  /// Statut de vérification
  @override
  VerificationStatus get verificationStatus;

  /// Indique si des preuves à divulgation nulle de connaissance sont disponibles
  @override
  bool get supportsZkp;

  /// Métadonnées supplémentaires
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialImplCopyWith<_$CredentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CredentialProof _$CredentialProofFromJson(Map<String, dynamic> json) {
  return _CredentialProof.fromJson(json);
}

/// @nodoc
mixin _$CredentialProof {
  /// Type de preuve (par exemple, "Ed25519Signature2018")
  String get type => throw _privateConstructorUsedError;

  /// Date de création de la preuve
  DateTime get created => throw _privateConstructorUsedError;

  /// ID du vérificateur
  String get verificationMethod => throw _privateConstructorUsedError;

  /// But de la preuve (par exemple, "assertionMethod")
  String get proofPurpose => throw _privateConstructorUsedError;

  /// Valeur de la preuve
  String get proofValue => throw _privateConstructorUsedError;

  /// Serializes this CredentialProof to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialProofCopyWith<CredentialProof> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialProofCopyWith<$Res> {
  factory $CredentialProofCopyWith(
          CredentialProof value, $Res Function(CredentialProof) then) =
      _$CredentialProofCopyWithImpl<$Res, CredentialProof>;
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String verificationMethod,
      String proofPurpose,
      String proofValue});
}

/// @nodoc
class _$CredentialProofCopyWithImpl<$Res, $Val extends CredentialProof>
    implements $CredentialProofCopyWith<$Res> {
  _$CredentialProofCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialProof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? verificationMethod = null,
    Object? proofPurpose = null,
    Object? proofValue = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      proofPurpose: null == proofPurpose
          ? _value.proofPurpose
          : proofPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialProofImplCopyWith<$Res>
    implements $CredentialProofCopyWith<$Res> {
  factory _$$CredentialProofImplCopyWith(_$CredentialProofImpl value,
          $Res Function(_$CredentialProofImpl) then) =
      __$$CredentialProofImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String verificationMethod,
      String proofPurpose,
      String proofValue});
}

/// @nodoc
class __$$CredentialProofImplCopyWithImpl<$Res>
    extends _$CredentialProofCopyWithImpl<$Res, _$CredentialProofImpl>
    implements _$$CredentialProofImplCopyWith<$Res> {
  __$$CredentialProofImplCopyWithImpl(
      _$CredentialProofImpl _value, $Res Function(_$CredentialProofImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialProof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? verificationMethod = null,
    Object? proofPurpose = null,
    Object? proofValue = null,
  }) {
    return _then(_$CredentialProofImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      proofPurpose: null == proofPurpose
          ? _value.proofPurpose
          : proofPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialProofImpl implements _CredentialProof {
  const _$CredentialProofImpl(
      {required this.type,
      required this.created,
      required this.verificationMethod,
      required this.proofPurpose,
      required this.proofValue});

  factory _$CredentialProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialProofImplFromJson(json);

  /// Type de preuve (par exemple, "Ed25519Signature2018")
  @override
  final String type;

  /// Date de création de la preuve
  @override
  final DateTime created;

  /// ID du vérificateur
  @override
  final String verificationMethod;

  /// But de la preuve (par exemple, "assertionMethod")
  @override
  final String proofPurpose;

  /// Valeur de la preuve
  @override
  final String proofValue;

  @override
  String toString() {
    return 'CredentialProof(type: $type, created: $created, verificationMethod: $verificationMethod, proofPurpose: $proofPurpose, proofValue: $proofValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialProofImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod) &&
            (identical(other.proofPurpose, proofPurpose) ||
                other.proofPurpose == proofPurpose) &&
            (identical(other.proofValue, proofValue) ||
                other.proofValue == proofValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, created, verificationMethod, proofPurpose, proofValue);

  /// Create a copy of CredentialProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialProofImplCopyWith<_$CredentialProofImpl> get copyWith =>
      __$$CredentialProofImplCopyWithImpl<_$CredentialProofImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialProofImplToJson(
      this,
    );
  }
}

abstract class _CredentialProof implements CredentialProof {
  const factory _CredentialProof(
      {required final String type,
      required final DateTime created,
      required final String verificationMethod,
      required final String proofPurpose,
      required final String proofValue}) = _$CredentialProofImpl;

  factory _CredentialProof.fromJson(Map<String, dynamic> json) =
      _$CredentialProofImpl.fromJson;

  /// Type de preuve (par exemple, "Ed25519Signature2018")
  @override
  String get type;

  /// Date de création de la preuve
  @override
  DateTime get created;

  /// ID du vérificateur
  @override
  String get verificationMethod;

  /// But de la preuve (par exemple, "assertionMethod")
  @override
  String get proofPurpose;

  /// Valeur de la preuve
  @override
  String get proofValue;

  /// Create a copy of CredentialProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialProofImplCopyWith<_$CredentialProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CredentialPresentation _$CredentialPresentationFromJson(
    Map<String, dynamic> json) {
  return _CredentialPresentation.fromJson(json);
}

/// @nodoc
mixin _$CredentialPresentation {
  /// Identifiant unique de la présentation
  String get id => throw _privateConstructorUsedError;

  /// Type de présentation
  String get type => throw _privateConstructorUsedError;

  /// Attestations incluses
  List<Credential> get verifiableCredentials =>
      throw _privateConstructorUsedError;

  /// Date de création
  DateTime get created => throw _privateConstructorUsedError;

  /// Attributs révélés (pour divulgation sélective)
  Map<String, dynamic> get revealedAttributes =>
      throw _privateConstructorUsedError;

  /// Prédicats vérifiables (pour ZKP)
  List<CredentialPredicate>? get predicates =>
      throw _privateConstructorUsedError;

  /// Preuve cryptographique
  CredentialProof get proof => throw _privateConstructorUsedError;

  /// Serializes this CredentialPresentation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialPresentationCopyWith<CredentialPresentation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialPresentationCopyWith<$Res> {
  factory $CredentialPresentationCopyWith(CredentialPresentation value,
          $Res Function(CredentialPresentation) then) =
      _$CredentialPresentationCopyWithImpl<$Res, CredentialPresentation>;
  @useResult
  $Res call(
      {String id,
      String type,
      List<Credential> verifiableCredentials,
      DateTime created,
      Map<String, dynamic> revealedAttributes,
      List<CredentialPredicate>? predicates,
      CredentialProof proof});

  $CredentialProofCopyWith<$Res> get proof;
}

/// @nodoc
class _$CredentialPresentationCopyWithImpl<$Res,
        $Val extends CredentialPresentation>
    implements $CredentialPresentationCopyWith<$Res> {
  _$CredentialPresentationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? verifiableCredentials = null,
    Object? created = null,
    Object? revealedAttributes = null,
    Object? predicates = freezed,
    Object? proof = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      verifiableCredentials: null == verifiableCredentials
          ? _value.verifiableCredentials
          : verifiableCredentials // ignore: cast_nullable_to_non_nullable
              as List<Credential>,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      revealedAttributes: null == revealedAttributes
          ? _value.revealedAttributes
          : revealedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      predicates: freezed == predicates
          ? _value.predicates
          : predicates // ignore: cast_nullable_to_non_nullable
              as List<CredentialPredicate>?,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as CredentialProof,
    ) as $Val);
  }

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialProofCopyWith<$Res> get proof {
    return $CredentialProofCopyWith<$Res>(_value.proof, (value) {
      return _then(_value.copyWith(proof: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CredentialPresentationImplCopyWith<$Res>
    implements $CredentialPresentationCopyWith<$Res> {
  factory _$$CredentialPresentationImplCopyWith(
          _$CredentialPresentationImpl value,
          $Res Function(_$CredentialPresentationImpl) then) =
      __$$CredentialPresentationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      List<Credential> verifiableCredentials,
      DateTime created,
      Map<String, dynamic> revealedAttributes,
      List<CredentialPredicate>? predicates,
      CredentialProof proof});

  @override
  $CredentialProofCopyWith<$Res> get proof;
}

/// @nodoc
class __$$CredentialPresentationImplCopyWithImpl<$Res>
    extends _$CredentialPresentationCopyWithImpl<$Res,
        _$CredentialPresentationImpl>
    implements _$$CredentialPresentationImplCopyWith<$Res> {
  __$$CredentialPresentationImplCopyWithImpl(
      _$CredentialPresentationImpl _value,
      $Res Function(_$CredentialPresentationImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? verifiableCredentials = null,
    Object? created = null,
    Object? revealedAttributes = null,
    Object? predicates = freezed,
    Object? proof = null,
  }) {
    return _then(_$CredentialPresentationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      verifiableCredentials: null == verifiableCredentials
          ? _value._verifiableCredentials
          : verifiableCredentials // ignore: cast_nullable_to_non_nullable
              as List<Credential>,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      revealedAttributes: null == revealedAttributes
          ? _value._revealedAttributes
          : revealedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      predicates: freezed == predicates
          ? _value._predicates
          : predicates // ignore: cast_nullable_to_non_nullable
              as List<CredentialPredicate>?,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as CredentialProof,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialPresentationImpl implements _CredentialPresentation {
  const _$CredentialPresentationImpl(
      {required this.id,
      required this.type,
      required final List<Credential> verifiableCredentials,
      required this.created,
      required final Map<String, dynamic> revealedAttributes,
      final List<CredentialPredicate>? predicates,
      required this.proof})
      : _verifiableCredentials = verifiableCredentials,
        _revealedAttributes = revealedAttributes,
        _predicates = predicates;

  factory _$CredentialPresentationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialPresentationImplFromJson(json);

  /// Identifiant unique de la présentation
  @override
  final String id;

  /// Type de présentation
  @override
  final String type;

  /// Attestations incluses
  final List<Credential> _verifiableCredentials;

  /// Attestations incluses
  @override
  List<Credential> get verifiableCredentials {
    if (_verifiableCredentials is EqualUnmodifiableListView)
      return _verifiableCredentials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verifiableCredentials);
  }

  /// Date de création
  @override
  final DateTime created;

  /// Attributs révélés (pour divulgation sélective)
  final Map<String, dynamic> _revealedAttributes;

  /// Attributs révélés (pour divulgation sélective)
  @override
  Map<String, dynamic> get revealedAttributes {
    if (_revealedAttributes is EqualUnmodifiableMapView)
      return _revealedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_revealedAttributes);
  }

  /// Prédicats vérifiables (pour ZKP)
  final List<CredentialPredicate>? _predicates;

  /// Prédicats vérifiables (pour ZKP)
  @override
  List<CredentialPredicate>? get predicates {
    final value = _predicates;
    if (value == null) return null;
    if (_predicates is EqualUnmodifiableListView) return _predicates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Preuve cryptographique
  @override
  final CredentialProof proof;

  @override
  String toString() {
    return 'CredentialPresentation(id: $id, type: $type, verifiableCredentials: $verifiableCredentials, created: $created, revealedAttributes: $revealedAttributes, predicates: $predicates, proof: $proof)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialPresentationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._verifiableCredentials, _verifiableCredentials) &&
            (identical(other.created, created) || other.created == created) &&
            const DeepCollectionEquality()
                .equals(other._revealedAttributes, _revealedAttributes) &&
            const DeepCollectionEquality()
                .equals(other._predicates, _predicates) &&
            (identical(other.proof, proof) || other.proof == proof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      const DeepCollectionEquality().hash(_verifiableCredentials),
      created,
      const DeepCollectionEquality().hash(_revealedAttributes),
      const DeepCollectionEquality().hash(_predicates),
      proof);

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialPresentationImplCopyWith<_$CredentialPresentationImpl>
      get copyWith => __$$CredentialPresentationImplCopyWithImpl<
          _$CredentialPresentationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialPresentationImplToJson(
      this,
    );
  }
}

abstract class _CredentialPresentation implements CredentialPresentation {
  const factory _CredentialPresentation(
      {required final String id,
      required final String type,
      required final List<Credential> verifiableCredentials,
      required final DateTime created,
      required final Map<String, dynamic> revealedAttributes,
      final List<CredentialPredicate>? predicates,
      required final CredentialProof proof}) = _$CredentialPresentationImpl;

  factory _CredentialPresentation.fromJson(Map<String, dynamic> json) =
      _$CredentialPresentationImpl.fromJson;

  /// Identifiant unique de la présentation
  @override
  String get id;

  /// Type de présentation
  @override
  String get type;

  /// Attestations incluses
  @override
  List<Credential> get verifiableCredentials;

  /// Date de création
  @override
  DateTime get created;

  /// Attributs révélés (pour divulgation sélective)
  @override
  Map<String, dynamic> get revealedAttributes;

  /// Prédicats vérifiables (pour ZKP)
  @override
  List<CredentialPredicate>? get predicates;

  /// Preuve cryptographique
  @override
  CredentialProof get proof;

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialPresentationImplCopyWith<_$CredentialPresentationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CredentialPredicate _$CredentialPredicateFromJson(Map<String, dynamic> json) {
  return _CredentialPredicate.fromJson(json);
}

/// @nodoc
mixin _$CredentialPredicate {
  /// Nom de l'attribut
  String get attributeName => throw _privateConstructorUsedError;

  /// Opérateur de comparaison
  PredicateType get predicateType => throw _privateConstructorUsedError;

  /// Valeur de comparaison
  dynamic get value => throw _privateConstructorUsedError;

  /// Serializes this CredentialPredicate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialPredicateCopyWith<CredentialPredicate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialPredicateCopyWith<$Res> {
  factory $CredentialPredicateCopyWith(
          CredentialPredicate value, $Res Function(CredentialPredicate) then) =
      _$CredentialPredicateCopyWithImpl<$Res, CredentialPredicate>;
  @useResult
  $Res call({String attributeName, PredicateType predicateType, dynamic value});
}

/// @nodoc
class _$CredentialPredicateCopyWithImpl<$Res, $Val extends CredentialPredicate>
    implements $CredentialPredicateCopyWith<$Res> {
  _$CredentialPredicateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributeName = null,
    Object? predicateType = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      attributeName: null == attributeName
          ? _value.attributeName
          : attributeName // ignore: cast_nullable_to_non_nullable
              as String,
      predicateType: null == predicateType
          ? _value.predicateType
          : predicateType // ignore: cast_nullable_to_non_nullable
              as PredicateType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialPredicateImplCopyWith<$Res>
    implements $CredentialPredicateCopyWith<$Res> {
  factory _$$CredentialPredicateImplCopyWith(_$CredentialPredicateImpl value,
          $Res Function(_$CredentialPredicateImpl) then) =
      __$$CredentialPredicateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String attributeName, PredicateType predicateType, dynamic value});
}

/// @nodoc
class __$$CredentialPredicateImplCopyWithImpl<$Res>
    extends _$CredentialPredicateCopyWithImpl<$Res, _$CredentialPredicateImpl>
    implements _$$CredentialPredicateImplCopyWith<$Res> {
  __$$CredentialPredicateImplCopyWithImpl(_$CredentialPredicateImpl _value,
      $Res Function(_$CredentialPredicateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributeName = null,
    Object? predicateType = null,
    Object? value = freezed,
  }) {
    return _then(_$CredentialPredicateImpl(
      attributeName: null == attributeName
          ? _value.attributeName
          : attributeName // ignore: cast_nullable_to_non_nullable
              as String,
      predicateType: null == predicateType
          ? _value.predicateType
          : predicateType // ignore: cast_nullable_to_non_nullable
              as PredicateType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialPredicateImpl implements _CredentialPredicate {
  const _$CredentialPredicateImpl(
      {required this.attributeName,
      required this.predicateType,
      required this.value});

  factory _$CredentialPredicateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialPredicateImplFromJson(json);

  /// Nom de l'attribut
  @override
  final String attributeName;

  /// Opérateur de comparaison
  @override
  final PredicateType predicateType;

  /// Valeur de comparaison
  @override
  final dynamic value;

  @override
  String toString() {
    return 'CredentialPredicate(attributeName: $attributeName, predicateType: $predicateType, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialPredicateImpl &&
            (identical(other.attributeName, attributeName) ||
                other.attributeName == attributeName) &&
            (identical(other.predicateType, predicateType) ||
                other.predicateType == predicateType) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, attributeName, predicateType,
      const DeepCollectionEquality().hash(value));

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialPredicateImplCopyWith<_$CredentialPredicateImpl> get copyWith =>
      __$$CredentialPredicateImplCopyWithImpl<_$CredentialPredicateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialPredicateImplToJson(
      this,
    );
  }
}

abstract class _CredentialPredicate implements CredentialPredicate {
  const factory _CredentialPredicate(
      {required final String attributeName,
      required final PredicateType predicateType,
      required final dynamic value}) = _$CredentialPredicateImpl;

  factory _CredentialPredicate.fromJson(Map<String, dynamic> json) =
      _$CredentialPredicateImpl.fromJson;

  /// Nom de l'attribut
  @override
  String get attributeName;

  /// Opérateur de comparaison
  @override
  PredicateType get predicateType;

  /// Valeur de comparaison
  @override
  dynamic get value;

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialPredicateImplCopyWith<_$CredentialPredicateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
