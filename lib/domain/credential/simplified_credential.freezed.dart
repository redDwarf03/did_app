// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simplified_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SimplifiedCredential _$SimplifiedCredentialFromJson(Map<String, dynamic> json) {
  return _SimplifiedCredential.fromJson(json);
}

/// @nodoc
mixin _$SimplifiedCredential {
  /// A unique identifier for this credential instance (e.g., a UUID or database ID).
  String get id => throw _privateConstructorUsedError;

  /// The application-specific type of the credential. See [SimplifiedCredentialType].
  SimplifiedCredentialType get type => throw _privateConstructorUsedError;

  /// An identifier (e.g., name, URI, or DID) of the entity that issued the credential.
  String get issuer => throw _privateConstructorUsedError;

  /// The date and time when the credential was issued.
  DateTime get issuanceDate => throw _privateConstructorUsedError;

  /// The date and time when the credential expires.
  DateTime get expirationDate => throw _privateConstructorUsedError;

  /// A map containing the core claims or attributes of the credential.
  /// The structure depends on the credential `type`.
  Map<String, dynamic> get attributes => throw _privateConstructorUsedError;

  /// A simple flag indicating if this credential representation has been locally verified.
  /// This does not necessarily imply full cryptographic verification according to W3C standards.
  bool get isVerified => throw _privateConstructorUsedError;

  /// Serializes this SimplifiedCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimplifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimplifiedCredentialCopyWith<SimplifiedCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimplifiedCredentialCopyWith<$Res> {
  factory $SimplifiedCredentialCopyWith(SimplifiedCredential value,
          $Res Function(SimplifiedCredential) then) =
      _$SimplifiedCredentialCopyWithImpl<$Res, SimplifiedCredential>;
  @useResult
  $Res call(
      {String id,
      SimplifiedCredentialType type,
      String issuer,
      DateTime issuanceDate,
      DateTime expirationDate,
      Map<String, dynamic> attributes,
      bool isVerified});
}

/// @nodoc
class _$SimplifiedCredentialCopyWithImpl<$Res,
        $Val extends SimplifiedCredential>
    implements $SimplifiedCredentialCopyWith<$Res> {
  _$SimplifiedCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimplifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? issuer = null,
    Object? issuanceDate = null,
    Object? expirationDate = null,
    Object? attributes = null,
    Object? isVerified = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SimplifiedCredentialType,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: null == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimplifiedCredentialImplCopyWith<$Res>
    implements $SimplifiedCredentialCopyWith<$Res> {
  factory _$$SimplifiedCredentialImplCopyWith(_$SimplifiedCredentialImpl value,
          $Res Function(_$SimplifiedCredentialImpl) then) =
      __$$SimplifiedCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SimplifiedCredentialType type,
      String issuer,
      DateTime issuanceDate,
      DateTime expirationDate,
      Map<String, dynamic> attributes,
      bool isVerified});
}

/// @nodoc
class __$$SimplifiedCredentialImplCopyWithImpl<$Res>
    extends _$SimplifiedCredentialCopyWithImpl<$Res, _$SimplifiedCredentialImpl>
    implements _$$SimplifiedCredentialImplCopyWith<$Res> {
  __$$SimplifiedCredentialImplCopyWithImpl(_$SimplifiedCredentialImpl _value,
      $Res Function(_$SimplifiedCredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SimplifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? issuer = null,
    Object? issuanceDate = null,
    Object? expirationDate = null,
    Object? attributes = null,
    Object? isVerified = null,
  }) {
    return _then(_$SimplifiedCredentialImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SimplifiedCredentialType,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: null == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SimplifiedCredentialImpl extends _SimplifiedCredential {
  const _$SimplifiedCredentialImpl(
      {required this.id,
      required this.type,
      required this.issuer,
      required this.issuanceDate,
      required this.expirationDate,
      required final Map<String, dynamic> attributes,
      this.isVerified = false})
      : _attributes = attributes,
        super._();

  factory _$SimplifiedCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimplifiedCredentialImplFromJson(json);

  /// A unique identifier for this credential instance (e.g., a UUID or database ID).
  @override
  final String id;

  /// The application-specific type of the credential. See [SimplifiedCredentialType].
  @override
  final SimplifiedCredentialType type;

  /// An identifier (e.g., name, URI, or DID) of the entity that issued the credential.
  @override
  final String issuer;

  /// The date and time when the credential was issued.
  @override
  final DateTime issuanceDate;

  /// The date and time when the credential expires.
  @override
  final DateTime expirationDate;

  /// A map containing the core claims or attributes of the credential.
  /// The structure depends on the credential `type`.
  final Map<String, dynamic> _attributes;

  /// A map containing the core claims or attributes of the credential.
  /// The structure depends on the credential `type`.
  @override
  Map<String, dynamic> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  /// A simple flag indicating if this credential representation has been locally verified.
  /// This does not necessarily imply full cryptographic verification according to W3C standards.
  @override
  @JsonKey()
  final bool isVerified;

  @override
  String toString() {
    return 'SimplifiedCredential(id: $id, type: $type, issuer: $issuer, issuanceDate: $issuanceDate, expirationDate: $expirationDate, attributes: $attributes, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimplifiedCredentialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.issuanceDate, issuanceDate) ||
                other.issuanceDate == issuanceDate) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      issuer,
      issuanceDate,
      expirationDate,
      const DeepCollectionEquality().hash(_attributes),
      isVerified);

  /// Create a copy of SimplifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimplifiedCredentialImplCopyWith<_$SimplifiedCredentialImpl>
      get copyWith =>
          __$$SimplifiedCredentialImplCopyWithImpl<_$SimplifiedCredentialImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimplifiedCredentialImplToJson(
      this,
    );
  }
}

abstract class _SimplifiedCredential extends SimplifiedCredential {
  const factory _SimplifiedCredential(
      {required final String id,
      required final SimplifiedCredentialType type,
      required final String issuer,
      required final DateTime issuanceDate,
      required final DateTime expirationDate,
      required final Map<String, dynamic> attributes,
      final bool isVerified}) = _$SimplifiedCredentialImpl;
  const _SimplifiedCredential._() : super._();

  factory _SimplifiedCredential.fromJson(Map<String, dynamic> json) =
      _$SimplifiedCredentialImpl.fromJson;

  /// A unique identifier for this credential instance (e.g., a UUID or database ID).
  @override
  String get id;

  /// The application-specific type of the credential. See [SimplifiedCredentialType].
  @override
  SimplifiedCredentialType get type;

  /// An identifier (e.g., name, URI, or DID) of the entity that issued the credential.
  @override
  String get issuer;

  /// The date and time when the credential was issued.
  @override
  DateTime get issuanceDate;

  /// The date and time when the credential expires.
  @override
  DateTime get expirationDate;

  /// A map containing the core claims or attributes of the credential.
  /// The structure depends on the credential `type`.
  @override
  Map<String, dynamic> get attributes;

  /// A simple flag indicating if this credential representation has been locally verified.
  /// This does not necessarily imply full cryptographic verification according to W3C standards.
  @override
  bool get isVerified;

  /// Create a copy of SimplifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimplifiedCredentialImplCopyWith<_$SimplifiedCredentialImpl>
      get copyWith => throw _privateConstructorUsedError;
}
