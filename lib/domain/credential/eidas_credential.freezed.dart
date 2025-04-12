// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eidas_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EidasCredential _$EidasCredentialFromJson(Map<String, dynamic> json) {
  return _EidasCredential.fromJson(json);
}

/// @nodoc
mixin _$EidasCredential {
  String get id => throw _privateConstructorUsedError;
  List<String> get type => throw _privateConstructorUsedError;
  EidasIssuer get issuer => throw _privateConstructorUsedError;
  DateTime get issuanceDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get credentialSubject =>
      throw _privateConstructorUsedError;
  DateTime? get expirationDate => throw _privateConstructorUsedError;
  EidasCredentialSchema? get credentialSchema =>
      throw _privateConstructorUsedError;
  EidasCredentialStatus? get credentialStatus =>
      throw _privateConstructorUsedError;
  EidasProof? get proof => throw _privateConstructorUsedError;
  List<EidasEvidence>? get evidence => throw _privateConstructorUsedError;

  /// Serializes this EidasCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasCredentialCopyWith<EidasCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasCredentialCopyWith<$Res> {
  factory $EidasCredentialCopyWith(
          EidasCredential value, $Res Function(EidasCredential) then) =
      _$EidasCredentialCopyWithImpl<$Res, EidasCredential>;
  @useResult
  $Res call(
      {String id,
      List<String> type,
      EidasIssuer issuer,
      DateTime issuanceDate,
      Map<String, dynamic> credentialSubject,
      DateTime? expirationDate,
      EidasCredentialSchema? credentialSchema,
      EidasCredentialStatus? credentialStatus,
      EidasProof? proof,
      List<EidasEvidence>? evidence});

  $EidasIssuerCopyWith<$Res> get issuer;
  $EidasCredentialSchemaCopyWith<$Res>? get credentialSchema;
  $EidasCredentialStatusCopyWith<$Res>? get credentialStatus;
  $EidasProofCopyWith<$Res>? get proof;
}

/// @nodoc
class _$EidasCredentialCopyWithImpl<$Res, $Val extends EidasCredential>
    implements $EidasCredentialCopyWith<$Res> {
  _$EidasCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? issuer = null,
    Object? issuanceDate = null,
    Object? credentialSubject = null,
    Object? expirationDate = freezed,
    Object? credentialSchema = freezed,
    Object? credentialStatus = freezed,
    Object? proof = freezed,
    Object? evidence = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as EidasIssuer,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      credentialSubject: null == credentialSubject
          ? _value.credentialSubject
          : credentialSubject // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      credentialSchema: freezed == credentialSchema
          ? _value.credentialSchema
          : credentialSchema // ignore: cast_nullable_to_non_nullable
              as EidasCredentialSchema?,
      credentialStatus: freezed == credentialStatus
          ? _value.credentialStatus
          : credentialStatus // ignore: cast_nullable_to_non_nullable
              as EidasCredentialStatus?,
      proof: freezed == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as EidasProof?,
      evidence: freezed == evidence
          ? _value.evidence
          : evidence // ignore: cast_nullable_to_non_nullable
              as List<EidasEvidence>?,
    ) as $Val);
  }

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EidasIssuerCopyWith<$Res> get issuer {
    return $EidasIssuerCopyWith<$Res>(_value.issuer, (value) {
      return _then(_value.copyWith(issuer: value) as $Val);
    });
  }

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EidasCredentialSchemaCopyWith<$Res>? get credentialSchema {
    if (_value.credentialSchema == null) {
      return null;
    }

    return $EidasCredentialSchemaCopyWith<$Res>(_value.credentialSchema!,
        (value) {
      return _then(_value.copyWith(credentialSchema: value) as $Val);
    });
  }

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EidasCredentialStatusCopyWith<$Res>? get credentialStatus {
    if (_value.credentialStatus == null) {
      return null;
    }

    return $EidasCredentialStatusCopyWith<$Res>(_value.credentialStatus!,
        (value) {
      return _then(_value.copyWith(credentialStatus: value) as $Val);
    });
  }

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EidasProofCopyWith<$Res>? get proof {
    if (_value.proof == null) {
      return null;
    }

    return $EidasProofCopyWith<$Res>(_value.proof!, (value) {
      return _then(_value.copyWith(proof: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EidasCredentialImplCopyWith<$Res>
    implements $EidasCredentialCopyWith<$Res> {
  factory _$$EidasCredentialImplCopyWith(_$EidasCredentialImpl value,
          $Res Function(_$EidasCredentialImpl) then) =
      __$$EidasCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> type,
      EidasIssuer issuer,
      DateTime issuanceDate,
      Map<String, dynamic> credentialSubject,
      DateTime? expirationDate,
      EidasCredentialSchema? credentialSchema,
      EidasCredentialStatus? credentialStatus,
      EidasProof? proof,
      List<EidasEvidence>? evidence});

  @override
  $EidasIssuerCopyWith<$Res> get issuer;
  @override
  $EidasCredentialSchemaCopyWith<$Res>? get credentialSchema;
  @override
  $EidasCredentialStatusCopyWith<$Res>? get credentialStatus;
  @override
  $EidasProofCopyWith<$Res>? get proof;
}

/// @nodoc
class __$$EidasCredentialImplCopyWithImpl<$Res>
    extends _$EidasCredentialCopyWithImpl<$Res, _$EidasCredentialImpl>
    implements _$$EidasCredentialImplCopyWith<$Res> {
  __$$EidasCredentialImplCopyWithImpl(
      _$EidasCredentialImpl _value, $Res Function(_$EidasCredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? issuer = null,
    Object? issuanceDate = null,
    Object? credentialSubject = null,
    Object? expirationDate = freezed,
    Object? credentialSchema = freezed,
    Object? credentialStatus = freezed,
    Object? proof = freezed,
    Object? evidence = freezed,
  }) {
    return _then(_$EidasCredentialImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as EidasIssuer,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      credentialSubject: null == credentialSubject
          ? _value._credentialSubject
          : credentialSubject // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      credentialSchema: freezed == credentialSchema
          ? _value.credentialSchema
          : credentialSchema // ignore: cast_nullable_to_non_nullable
              as EidasCredentialSchema?,
      credentialStatus: freezed == credentialStatus
          ? _value.credentialStatus
          : credentialStatus // ignore: cast_nullable_to_non_nullable
              as EidasCredentialStatus?,
      proof: freezed == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as EidasProof?,
      evidence: freezed == evidence
          ? _value._evidence
          : evidence // ignore: cast_nullable_to_non_nullable
              as List<EidasEvidence>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasCredentialImpl extends _EidasCredential {
  const _$EidasCredentialImpl(
      {required this.id,
      required final List<String> type,
      required this.issuer,
      required this.issuanceDate,
      required final Map<String, dynamic> credentialSubject,
      this.expirationDate,
      this.credentialSchema,
      this.credentialStatus,
      this.proof,
      final List<EidasEvidence>? evidence})
      : _type = type,
        _credentialSubject = credentialSubject,
        _evidence = evidence,
        super._();

  factory _$EidasCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasCredentialImplFromJson(json);

  @override
  final String id;
  final List<String> _type;
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  @override
  final EidasIssuer issuer;
  @override
  final DateTime issuanceDate;
  final Map<String, dynamic> _credentialSubject;
  @override
  Map<String, dynamic> get credentialSubject {
    if (_credentialSubject is EqualUnmodifiableMapView)
      return _credentialSubject;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_credentialSubject);
  }

  @override
  final DateTime? expirationDate;
  @override
  final EidasCredentialSchema? credentialSchema;
  @override
  final EidasCredentialStatus? credentialStatus;
  @override
  final EidasProof? proof;
  final List<EidasEvidence>? _evidence;
  @override
  List<EidasEvidence>? get evidence {
    final value = _evidence;
    if (value == null) return null;
    if (_evidence is EqualUnmodifiableListView) return _evidence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'EidasCredential(id: $id, type: $type, issuer: $issuer, issuanceDate: $issuanceDate, credentialSubject: $credentialSubject, expirationDate: $expirationDate, credentialSchema: $credentialSchema, credentialStatus: $credentialStatus, proof: $proof, evidence: $evidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasCredentialImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.issuanceDate, issuanceDate) ||
                other.issuanceDate == issuanceDate) &&
            const DeepCollectionEquality()
                .equals(other._credentialSubject, _credentialSubject) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.credentialSchema, credentialSchema) ||
                other.credentialSchema == credentialSchema) &&
            (identical(other.credentialStatus, credentialStatus) ||
                other.credentialStatus == credentialStatus) &&
            (identical(other.proof, proof) || other.proof == proof) &&
            const DeepCollectionEquality().equals(other._evidence, _evidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_type),
      issuer,
      issuanceDate,
      const DeepCollectionEquality().hash(_credentialSubject),
      expirationDate,
      credentialSchema,
      credentialStatus,
      proof,
      const DeepCollectionEquality().hash(_evidence));

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasCredentialImplCopyWith<_$EidasCredentialImpl> get copyWith =>
      __$$EidasCredentialImplCopyWithImpl<_$EidasCredentialImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasCredentialImplToJson(
      this,
    );
  }
}

abstract class _EidasCredential extends EidasCredential {
  const factory _EidasCredential(
      {required final String id,
      required final List<String> type,
      required final EidasIssuer issuer,
      required final DateTime issuanceDate,
      required final Map<String, dynamic> credentialSubject,
      final DateTime? expirationDate,
      final EidasCredentialSchema? credentialSchema,
      final EidasCredentialStatus? credentialStatus,
      final EidasProof? proof,
      final List<EidasEvidence>? evidence}) = _$EidasCredentialImpl;
  const _EidasCredential._() : super._();

  factory _EidasCredential.fromJson(Map<String, dynamic> json) =
      _$EidasCredentialImpl.fromJson;

  @override
  String get id;
  @override
  List<String> get type;
  @override
  EidasIssuer get issuer;
  @override
  DateTime get issuanceDate;
  @override
  Map<String, dynamic> get credentialSubject;
  @override
  DateTime? get expirationDate;
  @override
  EidasCredentialSchema? get credentialSchema;
  @override
  EidasCredentialStatus? get credentialStatus;
  @override
  EidasProof? get proof;
  @override
  List<EidasEvidence>? get evidence;

  /// Create a copy of EidasCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasCredentialImplCopyWith<_$EidasCredentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EidasIssuer _$EidasIssuerFromJson(Map<String, dynamic> json) {
  return _EidasIssuer.fromJson(json);
}

/// @nodoc
mixin _$EidasIssuer {
  /// The unique identifier (e.g., DID or URI) of the issuer. REQUIRED (either direct string or in object).
  String get id => throw _privateConstructorUsedError;

  /// Optional human-readable name of the issuer.
  String? get name => throw _privateConstructorUsedError;

  /// Optional URL to an image representing the issuer.
  String? get image => throw _privateConstructorUsedError;

  /// Optional URL for more information about the issuer.
  String? get url => throw _privateConstructorUsedError;

  /// Optional type of the issuing organization (e.g., government, private).
  String? get organizationType => throw _privateConstructorUsedError;

  /// Optional registration number of the issuer organization.
  String? get registrationNumber => throw _privateConstructorUsedError;

  /// Optional structured address of the issuer.
  Map<String, dynamic>? get address => throw _privateConstructorUsedError;

  /// Serializes this EidasIssuer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasIssuer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasIssuerCopyWith<EidasIssuer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasIssuerCopyWith<$Res> {
  factory $EidasIssuerCopyWith(
          EidasIssuer value, $Res Function(EidasIssuer) then) =
      _$EidasIssuerCopyWithImpl<$Res, EidasIssuer>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? image,
      String? url,
      String? organizationType,
      String? registrationNumber,
      Map<String, dynamic>? address});
}

/// @nodoc
class _$EidasIssuerCopyWithImpl<$Res, $Val extends EidasIssuer>
    implements $EidasIssuerCopyWith<$Res> {
  _$EidasIssuerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasIssuer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? image = freezed,
    Object? url = freezed,
    Object? organizationType = freezed,
    Object? registrationNumber = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationType: freezed == organizationType
          ? _value.organizationType
          : organizationType // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EidasIssuerImplCopyWith<$Res>
    implements $EidasIssuerCopyWith<$Res> {
  factory _$$EidasIssuerImplCopyWith(
          _$EidasIssuerImpl value, $Res Function(_$EidasIssuerImpl) then) =
      __$$EidasIssuerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? image,
      String? url,
      String? organizationType,
      String? registrationNumber,
      Map<String, dynamic>? address});
}

/// @nodoc
class __$$EidasIssuerImplCopyWithImpl<$Res>
    extends _$EidasIssuerCopyWithImpl<$Res, _$EidasIssuerImpl>
    implements _$$EidasIssuerImplCopyWith<$Res> {
  __$$EidasIssuerImplCopyWithImpl(
      _$EidasIssuerImpl _value, $Res Function(_$EidasIssuerImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasIssuer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? image = freezed,
    Object? url = freezed,
    Object? organizationType = freezed,
    Object? registrationNumber = freezed,
    Object? address = freezed,
  }) {
    return _then(_$EidasIssuerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationType: freezed == organizationType
          ? _value.organizationType
          : organizationType // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value._address
          : address // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasIssuerImpl implements _EidasIssuer {
  const _$EidasIssuerImpl(
      {required this.id,
      this.name,
      this.image,
      this.url,
      this.organizationType,
      this.registrationNumber,
      final Map<String, dynamic>? address})
      : _address = address;

  factory _$EidasIssuerImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasIssuerImplFromJson(json);

  /// The unique identifier (e.g., DID or URI) of the issuer. REQUIRED (either direct string or in object).
  @override
  final String id;

  /// Optional human-readable name of the issuer.
  @override
  final String? name;

  /// Optional URL to an image representing the issuer.
  @override
  final String? image;

  /// Optional URL for more information about the issuer.
  @override
  final String? url;

  /// Optional type of the issuing organization (e.g., government, private).
  @override
  final String? organizationType;

  /// Optional registration number of the issuer organization.
  @override
  final String? registrationNumber;

  /// Optional structured address of the issuer.
  final Map<String, dynamic>? _address;

  /// Optional structured address of the issuer.
  @override
  Map<String, dynamic>? get address {
    final value = _address;
    if (value == null) return null;
    if (_address is EqualUnmodifiableMapView) return _address;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EidasIssuer(id: $id, name: $name, image: $image, url: $url, organizationType: $organizationType, registrationNumber: $registrationNumber, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasIssuerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.organizationType, organizationType) ||
                other.organizationType == organizationType) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            const DeepCollectionEquality().equals(other._address, _address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      image,
      url,
      organizationType,
      registrationNumber,
      const DeepCollectionEquality().hash(_address));

  /// Create a copy of EidasIssuer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasIssuerImplCopyWith<_$EidasIssuerImpl> get copyWith =>
      __$$EidasIssuerImplCopyWithImpl<_$EidasIssuerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasIssuerImplToJson(
      this,
    );
  }
}

abstract class _EidasIssuer implements EidasIssuer {
  const factory _EidasIssuer(
      {required final String id,
      final String? name,
      final String? image,
      final String? url,
      final String? organizationType,
      final String? registrationNumber,
      final Map<String, dynamic>? address}) = _$EidasIssuerImpl;

  factory _EidasIssuer.fromJson(Map<String, dynamic> json) =
      _$EidasIssuerImpl.fromJson;

  /// The unique identifier (e.g., DID or URI) of the issuer. REQUIRED (either direct string or in object).
  @override
  String get id;

  /// Optional human-readable name of the issuer.
  @override
  String? get name;

  /// Optional URL to an image representing the issuer.
  @override
  String? get image;

  /// Optional URL for more information about the issuer.
  @override
  String? get url;

  /// Optional type of the issuing organization (e.g., government, private).
  @override
  String? get organizationType;

  /// Optional registration number of the issuer organization.
  @override
  String? get registrationNumber;

  /// Optional structured address of the issuer.
  @override
  Map<String, dynamic>? get address;

  /// Create a copy of EidasIssuer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasIssuerImplCopyWith<_$EidasIssuerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EidasCredentialSchema _$EidasCredentialSchemaFromJson(
    Map<String, dynamic> json) {
  return _EidasCredentialSchema.fromJson(json);
}

/// @nodoc
mixin _$EidasCredentialSchema {
  /// The unique identifier (URI) of the schema. REQUIRED.
  String get id => throw _privateConstructorUsedError;

  /// The type of the schema (e.g., "JsonSchemaValidator2018", "ShapeExpressionSchema"). REQUIRED.
  String get type => throw _privateConstructorUsedError;

  /// Serializes this EidasCredentialSchema to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasCredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasCredentialSchemaCopyWith<EidasCredentialSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasCredentialSchemaCopyWith<$Res> {
  factory $EidasCredentialSchemaCopyWith(EidasCredentialSchema value,
          $Res Function(EidasCredentialSchema) then) =
      _$EidasCredentialSchemaCopyWithImpl<$Res, EidasCredentialSchema>;
  @useResult
  $Res call({String id, String type});
}

/// @nodoc
class _$EidasCredentialSchemaCopyWithImpl<$Res,
        $Val extends EidasCredentialSchema>
    implements $EidasCredentialSchemaCopyWith<$Res> {
  _$EidasCredentialSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasCredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EidasCredentialSchemaImplCopyWith<$Res>
    implements $EidasCredentialSchemaCopyWith<$Res> {
  factory _$$EidasCredentialSchemaImplCopyWith(
          _$EidasCredentialSchemaImpl value,
          $Res Function(_$EidasCredentialSchemaImpl) then) =
      __$$EidasCredentialSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String type});
}

/// @nodoc
class __$$EidasCredentialSchemaImplCopyWithImpl<$Res>
    extends _$EidasCredentialSchemaCopyWithImpl<$Res,
        _$EidasCredentialSchemaImpl>
    implements _$$EidasCredentialSchemaImplCopyWith<$Res> {
  __$$EidasCredentialSchemaImplCopyWithImpl(_$EidasCredentialSchemaImpl _value,
      $Res Function(_$EidasCredentialSchemaImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasCredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$EidasCredentialSchemaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasCredentialSchemaImpl implements _EidasCredentialSchema {
  const _$EidasCredentialSchemaImpl({required this.id, required this.type});

  factory _$EidasCredentialSchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasCredentialSchemaImplFromJson(json);

  /// The unique identifier (URI) of the schema. REQUIRED.
  @override
  final String id;

  /// The type of the schema (e.g., "JsonSchemaValidator2018", "ShapeExpressionSchema"). REQUIRED.
  @override
  final String type;

  @override
  String toString() {
    return 'EidasCredentialSchema(id: $id, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasCredentialSchemaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  /// Create a copy of EidasCredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasCredentialSchemaImplCopyWith<_$EidasCredentialSchemaImpl>
      get copyWith => __$$EidasCredentialSchemaImplCopyWithImpl<
          _$EidasCredentialSchemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasCredentialSchemaImplToJson(
      this,
    );
  }
}

abstract class _EidasCredentialSchema implements EidasCredentialSchema {
  const factory _EidasCredentialSchema(
      {required final String id,
      required final String type}) = _$EidasCredentialSchemaImpl;

  factory _EidasCredentialSchema.fromJson(Map<String, dynamic> json) =
      _$EidasCredentialSchemaImpl.fromJson;

  /// The unique identifier (URI) of the schema. REQUIRED.
  @override
  String get id;

  /// The type of the schema (e.g., "JsonSchemaValidator2018", "ShapeExpressionSchema"). REQUIRED.
  @override
  String get type;

  /// Create a copy of EidasCredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasCredentialSchemaImplCopyWith<_$EidasCredentialSchemaImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EidasCredentialStatus _$EidasCredentialStatusFromJson(
    Map<String, dynamic> json) {
  return _EidasCredentialStatus.fromJson(json);
}

/// @nodoc
mixin _$EidasCredentialStatus {
  /// The unique identifier of the status entry (URI). REQUIRED.
  String get id => throw _privateConstructorUsedError;

  /// The type of the credential status mechanism used (e.g., "StatusList2021"). REQUIRED.
  String get type => throw _privateConstructorUsedError;

  /// Optional purpose of the status (e.g., "revocation", "suspension").
  String? get statusPurpose => throw _privateConstructorUsedError;

  /// Optional index within the status list (used with StatusList2021).
  int? get statusListIndex => throw _privateConstructorUsedError;

  /// Optional URL of the status list credential (used with StatusList2021).
  String? get statusListCredential => throw _privateConstructorUsedError;

  /// Serializes this EidasCredentialStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasCredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasCredentialStatusCopyWith<EidasCredentialStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasCredentialStatusCopyWith<$Res> {
  factory $EidasCredentialStatusCopyWith(EidasCredentialStatus value,
          $Res Function(EidasCredentialStatus) then) =
      _$EidasCredentialStatusCopyWithImpl<$Res, EidasCredentialStatus>;
  @useResult
  $Res call(
      {String id,
      String type,
      String? statusPurpose,
      int? statusListIndex,
      String? statusListCredential});
}

/// @nodoc
class _$EidasCredentialStatusCopyWithImpl<$Res,
        $Val extends EidasCredentialStatus>
    implements $EidasCredentialStatusCopyWith<$Res> {
  _$EidasCredentialStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasCredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? statusPurpose = freezed,
    Object? statusListIndex = freezed,
    Object? statusListCredential = freezed,
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
      statusPurpose: freezed == statusPurpose
          ? _value.statusPurpose
          : statusPurpose // ignore: cast_nullable_to_non_nullable
              as String?,
      statusListIndex: freezed == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      statusListCredential: freezed == statusListCredential
          ? _value.statusListCredential
          : statusListCredential // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EidasCredentialStatusImplCopyWith<$Res>
    implements $EidasCredentialStatusCopyWith<$Res> {
  factory _$$EidasCredentialStatusImplCopyWith(
          _$EidasCredentialStatusImpl value,
          $Res Function(_$EidasCredentialStatusImpl) then) =
      __$$EidasCredentialStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String? statusPurpose,
      int? statusListIndex,
      String? statusListCredential});
}

/// @nodoc
class __$$EidasCredentialStatusImplCopyWithImpl<$Res>
    extends _$EidasCredentialStatusCopyWithImpl<$Res,
        _$EidasCredentialStatusImpl>
    implements _$$EidasCredentialStatusImplCopyWith<$Res> {
  __$$EidasCredentialStatusImplCopyWithImpl(_$EidasCredentialStatusImpl _value,
      $Res Function(_$EidasCredentialStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasCredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? statusPurpose = freezed,
    Object? statusListIndex = freezed,
    Object? statusListCredential = freezed,
  }) {
    return _then(_$EidasCredentialStatusImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      statusPurpose: freezed == statusPurpose
          ? _value.statusPurpose
          : statusPurpose // ignore: cast_nullable_to_non_nullable
              as String?,
      statusListIndex: freezed == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      statusListCredential: freezed == statusListCredential
          ? _value.statusListCredential
          : statusListCredential // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasCredentialStatusImpl implements _EidasCredentialStatus {
  const _$EidasCredentialStatusImpl(
      {required this.id,
      required this.type,
      this.statusPurpose,
      this.statusListIndex,
      this.statusListCredential});

  factory _$EidasCredentialStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasCredentialStatusImplFromJson(json);

  /// The unique identifier of the status entry (URI). REQUIRED.
  @override
  final String id;

  /// The type of the credential status mechanism used (e.g., "StatusList2021"). REQUIRED.
  @override
  final String type;

  /// Optional purpose of the status (e.g., "revocation", "suspension").
  @override
  final String? statusPurpose;

  /// Optional index within the status list (used with StatusList2021).
  @override
  final int? statusListIndex;

  /// Optional URL of the status list credential (used with StatusList2021).
  @override
  final String? statusListCredential;

  @override
  String toString() {
    return 'EidasCredentialStatus(id: $id, type: $type, statusPurpose: $statusPurpose, statusListIndex: $statusListIndex, statusListCredential: $statusListCredential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasCredentialStatusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.statusPurpose, statusPurpose) ||
                other.statusPurpose == statusPurpose) &&
            (identical(other.statusListIndex, statusListIndex) ||
                other.statusListIndex == statusListIndex) &&
            (identical(other.statusListCredential, statusListCredential) ||
                other.statusListCredential == statusListCredential));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, statusPurpose,
      statusListIndex, statusListCredential);

  /// Create a copy of EidasCredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasCredentialStatusImplCopyWith<_$EidasCredentialStatusImpl>
      get copyWith => __$$EidasCredentialStatusImplCopyWithImpl<
          _$EidasCredentialStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasCredentialStatusImplToJson(
      this,
    );
  }
}

abstract class _EidasCredentialStatus implements EidasCredentialStatus {
  const factory _EidasCredentialStatus(
      {required final String id,
      required final String type,
      final String? statusPurpose,
      final int? statusListIndex,
      final String? statusListCredential}) = _$EidasCredentialStatusImpl;

  factory _EidasCredentialStatus.fromJson(Map<String, dynamic> json) =
      _$EidasCredentialStatusImpl.fromJson;

  /// The unique identifier of the status entry (URI). REQUIRED.
  @override
  String get id;

  /// The type of the credential status mechanism used (e.g., "StatusList2021"). REQUIRED.
  @override
  String get type;

  /// Optional purpose of the status (e.g., "revocation", "suspension").
  @override
  String? get statusPurpose;

  /// Optional index within the status list (used with StatusList2021).
  @override
  int? get statusListIndex;

  /// Optional URL of the status list credential (used with StatusList2021).
  @override
  String? get statusListCredential;

  /// Create a copy of EidasCredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasCredentialStatusImplCopyWith<_$EidasCredentialStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EidasProof _$EidasProofFromJson(Map<String, dynamic> json) {
  return _EidasProof.fromJson(json);
}

/// @nodoc
mixin _$EidasProof {
  /// The type of the cryptographic proof suite used. REQUIRED.
  String get type => throw _privateConstructorUsedError;

  /// The date and time when the proof was created. REQUIRED.
  DateTime get created => throw _privateConstructorUsedError;

  /// The identifier (e.g., DID URL) of the verification method used. REQUIRED.
  String get verificationMethod => throw _privateConstructorUsedError;

  /// The purpose of the proof (e.g., "assertionMethod", "authentication"). REQUIRED.
  String get proofPurpose => throw _privateConstructorUsedError;

  /// The value of the cryptographic proof (e.g., signature). REQUIRED.
  String get proofValue => throw _privateConstructorUsedError;

  /// Optional challenge used in the proof creation (relevant for VPs).
  String? get challenge => throw _privateConstructorUsedError;

  /// Optional domain for which the proof is valid (relevant for VPs).
  String? get domain => throw _privateConstructorUsedError;

  /// Optional JSON Web Signature (JWS) if the proof is in JWS format.
  String? get jws => throw _privateConstructorUsedError;

  /// Serializes this EidasProof to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasProofCopyWith<EidasProof> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasProofCopyWith<$Res> {
  factory $EidasProofCopyWith(
          EidasProof value, $Res Function(EidasProof) then) =
      _$EidasProofCopyWithImpl<$Res, EidasProof>;
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String verificationMethod,
      String proofPurpose,
      String proofValue,
      String? challenge,
      String? domain,
      String? jws});
}

/// @nodoc
class _$EidasProofCopyWithImpl<$Res, $Val extends EidasProof>
    implements $EidasProofCopyWith<$Res> {
  _$EidasProofCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasProof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? verificationMethod = null,
    Object? proofPurpose = null,
    Object? proofValue = null,
    Object? challenge = freezed,
    Object? domain = freezed,
    Object? jws = freezed,
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
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String?,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      jws: freezed == jws
          ? _value.jws
          : jws // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EidasProofImplCopyWith<$Res>
    implements $EidasProofCopyWith<$Res> {
  factory _$$EidasProofImplCopyWith(
          _$EidasProofImpl value, $Res Function(_$EidasProofImpl) then) =
      __$$EidasProofImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String verificationMethod,
      String proofPurpose,
      String proofValue,
      String? challenge,
      String? domain,
      String? jws});
}

/// @nodoc
class __$$EidasProofImplCopyWithImpl<$Res>
    extends _$EidasProofCopyWithImpl<$Res, _$EidasProofImpl>
    implements _$$EidasProofImplCopyWith<$Res> {
  __$$EidasProofImplCopyWithImpl(
      _$EidasProofImpl _value, $Res Function(_$EidasProofImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasProof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? verificationMethod = null,
    Object? proofPurpose = null,
    Object? proofValue = null,
    Object? challenge = freezed,
    Object? domain = freezed,
    Object? jws = freezed,
  }) {
    return _then(_$EidasProofImpl(
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
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String?,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      jws: freezed == jws
          ? _value.jws
          : jws // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasProofImpl implements _EidasProof {
  const _$EidasProofImpl(
      {required this.type,
      required this.created,
      required this.verificationMethod,
      required this.proofPurpose,
      required this.proofValue,
      this.challenge,
      this.domain,
      this.jws});

  factory _$EidasProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasProofImplFromJson(json);

  /// The type of the cryptographic proof suite used. REQUIRED.
  @override
  final String type;

  /// The date and time when the proof was created. REQUIRED.
  @override
  final DateTime created;

  /// The identifier (e.g., DID URL) of the verification method used. REQUIRED.
  @override
  final String verificationMethod;

  /// The purpose of the proof (e.g., "assertionMethod", "authentication"). REQUIRED.
  @override
  final String proofPurpose;

  /// The value of the cryptographic proof (e.g., signature). REQUIRED.
  @override
  final String proofValue;

  /// Optional challenge used in the proof creation (relevant for VPs).
  @override
  final String? challenge;

  /// Optional domain for which the proof is valid (relevant for VPs).
  @override
  final String? domain;

  /// Optional JSON Web Signature (JWS) if the proof is in JWS format.
  @override
  final String? jws;

  @override
  String toString() {
    return 'EidasProof(type: $type, created: $created, verificationMethod: $verificationMethod, proofPurpose: $proofPurpose, proofValue: $proofValue, challenge: $challenge, domain: $domain, jws: $jws)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasProofImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod) &&
            (identical(other.proofPurpose, proofPurpose) ||
                other.proofPurpose == proofPurpose) &&
            (identical(other.proofValue, proofValue) ||
                other.proofValue == proofValue) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.jws, jws) || other.jws == jws));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, created,
      verificationMethod, proofPurpose, proofValue, challenge, domain, jws);

  /// Create a copy of EidasProof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasProofImplCopyWith<_$EidasProofImpl> get copyWith =>
      __$$EidasProofImplCopyWithImpl<_$EidasProofImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasProofImplToJson(
      this,
    );
  }
}

abstract class _EidasProof implements EidasProof {
  const factory _EidasProof(
      {required final String type,
      required final DateTime created,
      required final String verificationMethod,
      required final String proofPurpose,
      required final String proofValue,
      final String? challenge,
      final String? domain,
      final String? jws}) = _$EidasProofImpl;

  factory _EidasProof.fromJson(Map<String, dynamic> json) =
      _$EidasProofImpl.fromJson;

  /// The type of the cryptographic proof suite used. REQUIRED.
  @override
  String get type;

  /// The date and time when the proof was created. REQUIRED.
  @override
  DateTime get created;

  /// The identifier (e.g., DID URL) of the verification method used. REQUIRED.
  @override
  String get verificationMethod;

  /// The purpose of the proof (e.g., "assertionMethod", "authentication"). REQUIRED.
  @override
  String get proofPurpose;

  /// The value of the cryptographic proof (e.g., signature). REQUIRED.
  @override
  String get proofValue;

  /// Optional challenge used in the proof creation (relevant for VPs).
  @override
  String? get challenge;

  /// Optional domain for which the proof is valid (relevant for VPs).
  @override
  String? get domain;

  /// Optional JSON Web Signature (JWS) if the proof is in JWS format.
  @override
  String? get jws;

  /// Create a copy of EidasProof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasProofImplCopyWith<_$EidasProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EidasEvidence _$EidasEvidenceFromJson(Map<String, dynamic> json) {
  return _EidasEvidence.fromJson(json);
}

/// @nodoc
mixin _$EidasEvidence {
  /// The type of evidence provided (e.g., "DocumentVerification", "IdentityVerification"). REQUIRED.
  String get type => throw _privateConstructorUsedError;

  /// Identifier of the entity that verified the evidence. REQUIRED.
  String get verifier => throw _privateConstructorUsedError;

  /// Optional list of identifiers or references to evidence documents.
  List<String>? get evidenceDocument => throw _privateConstructorUsedError;

  /// Optional indicator of the subject's presence during verification (e.g., "Physical", "Digital").
  String? get subjectPresence => throw _privateConstructorUsedError;

  /// Optional indicator of the document's presence during verification (e.g., "Physical", "Digital").
  String? get documentPresence => throw _privateConstructorUsedError;

  /// Optional timestamp related to the evidence collection or verification.
  DateTime? get time => throw _privateConstructorUsedError;

  /// Serializes this EidasEvidence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasEvidenceCopyWith<EidasEvidence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasEvidenceCopyWith<$Res> {
  factory $EidasEvidenceCopyWith(
          EidasEvidence value, $Res Function(EidasEvidence) then) =
      _$EidasEvidenceCopyWithImpl<$Res, EidasEvidence>;
  @useResult
  $Res call(
      {String type,
      String verifier,
      List<String>? evidenceDocument,
      String? subjectPresence,
      String? documentPresence,
      DateTime? time});
}

/// @nodoc
class _$EidasEvidenceCopyWithImpl<$Res, $Val extends EidasEvidence>
    implements $EidasEvidenceCopyWith<$Res> {
  _$EidasEvidenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? verifier = null,
    Object? evidenceDocument = freezed,
    Object? subjectPresence = freezed,
    Object? documentPresence = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      verifier: null == verifier
          ? _value.verifier
          : verifier // ignore: cast_nullable_to_non_nullable
              as String,
      evidenceDocument: freezed == evidenceDocument
          ? _value.evidenceDocument
          : evidenceDocument // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      subjectPresence: freezed == subjectPresence
          ? _value.subjectPresence
          : subjectPresence // ignore: cast_nullable_to_non_nullable
              as String?,
      documentPresence: freezed == documentPresence
          ? _value.documentPresence
          : documentPresence // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EidasEvidenceImplCopyWith<$Res>
    implements $EidasEvidenceCopyWith<$Res> {
  factory _$$EidasEvidenceImplCopyWith(
          _$EidasEvidenceImpl value, $Res Function(_$EidasEvidenceImpl) then) =
      __$$EidasEvidenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String verifier,
      List<String>? evidenceDocument,
      String? subjectPresence,
      String? documentPresence,
      DateTime? time});
}

/// @nodoc
class __$$EidasEvidenceImplCopyWithImpl<$Res>
    extends _$EidasEvidenceCopyWithImpl<$Res, _$EidasEvidenceImpl>
    implements _$$EidasEvidenceImplCopyWith<$Res> {
  __$$EidasEvidenceImplCopyWithImpl(
      _$EidasEvidenceImpl _value, $Res Function(_$EidasEvidenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? verifier = null,
    Object? evidenceDocument = freezed,
    Object? subjectPresence = freezed,
    Object? documentPresence = freezed,
    Object? time = freezed,
  }) {
    return _then(_$EidasEvidenceImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      verifier: null == verifier
          ? _value.verifier
          : verifier // ignore: cast_nullable_to_non_nullable
              as String,
      evidenceDocument: freezed == evidenceDocument
          ? _value._evidenceDocument
          : evidenceDocument // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      subjectPresence: freezed == subjectPresence
          ? _value.subjectPresence
          : subjectPresence // ignore: cast_nullable_to_non_nullable
              as String?,
      documentPresence: freezed == documentPresence
          ? _value.documentPresence
          : documentPresence // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasEvidenceImpl implements _EidasEvidence {
  const _$EidasEvidenceImpl(
      {required this.type,
      required this.verifier,
      final List<String>? evidenceDocument,
      this.subjectPresence,
      this.documentPresence,
      this.time})
      : _evidenceDocument = evidenceDocument;

  factory _$EidasEvidenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasEvidenceImplFromJson(json);

  /// The type of evidence provided (e.g., "DocumentVerification", "IdentityVerification"). REQUIRED.
  @override
  final String type;

  /// Identifier of the entity that verified the evidence. REQUIRED.
  @override
  final String verifier;

  /// Optional list of identifiers or references to evidence documents.
  final List<String>? _evidenceDocument;

  /// Optional list of identifiers or references to evidence documents.
  @override
  List<String>? get evidenceDocument {
    final value = _evidenceDocument;
    if (value == null) return null;
    if (_evidenceDocument is EqualUnmodifiableListView)
      return _evidenceDocument;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Optional indicator of the subject's presence during verification (e.g., "Physical", "Digital").
  @override
  final String? subjectPresence;

  /// Optional indicator of the document's presence during verification (e.g., "Physical", "Digital").
  @override
  final String? documentPresence;

  /// Optional timestamp related to the evidence collection or verification.
  @override
  final DateTime? time;

  @override
  String toString() {
    return 'EidasEvidence(type: $type, verifier: $verifier, evidenceDocument: $evidenceDocument, subjectPresence: $subjectPresence, documentPresence: $documentPresence, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasEvidenceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.verifier, verifier) ||
                other.verifier == verifier) &&
            const DeepCollectionEquality()
                .equals(other._evidenceDocument, _evidenceDocument) &&
            (identical(other.subjectPresence, subjectPresence) ||
                other.subjectPresence == subjectPresence) &&
            (identical(other.documentPresence, documentPresence) ||
                other.documentPresence == documentPresence) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      verifier,
      const DeepCollectionEquality().hash(_evidenceDocument),
      subjectPresence,
      documentPresence,
      time);

  /// Create a copy of EidasEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasEvidenceImplCopyWith<_$EidasEvidenceImpl> get copyWith =>
      __$$EidasEvidenceImplCopyWithImpl<_$EidasEvidenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasEvidenceImplToJson(
      this,
    );
  }
}

abstract class _EidasEvidence implements EidasEvidence {
  const factory _EidasEvidence(
      {required final String type,
      required final String verifier,
      final List<String>? evidenceDocument,
      final String? subjectPresence,
      final String? documentPresence,
      final DateTime? time}) = _$EidasEvidenceImpl;

  factory _EidasEvidence.fromJson(Map<String, dynamic> json) =
      _$EidasEvidenceImpl.fromJson;

  /// The type of evidence provided (e.g., "DocumentVerification", "IdentityVerification"). REQUIRED.
  @override
  String get type;

  /// Identifier of the entity that verified the evidence. REQUIRED.
  @override
  String get verifier;

  /// Optional list of identifiers or references to evidence documents.
  @override
  List<String>? get evidenceDocument;

  /// Optional indicator of the subject's presence during verification (e.g., "Physical", "Digital").
  @override
  String? get subjectPresence;

  /// Optional indicator of the document's presence during verification (e.g., "Physical", "Digital").
  @override
  String? get documentPresence;

  /// Optional timestamp related to the evidence collection or verification.
  @override
  DateTime? get time;

  /// Create a copy of EidasEvidence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasEvidenceImplCopyWith<_$EidasEvidenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
