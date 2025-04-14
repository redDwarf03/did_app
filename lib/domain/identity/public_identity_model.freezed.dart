// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_identity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublicIdentityModel _$PublicIdentityModelFromJson(Map<String, dynamic> json) {
  return _PublicIdentityModel.fromJson(json);
}

/// @nodoc
mixin _$PublicIdentityModel {
  /// The unique blockchain address or Decentralized Identifier (DID) for this identity.
  String get address => throw _privateConstructorUsedError;

  /// The primary, potentially private or internal, name associated with the identity.
  String get name => throw _privateConstructorUsedError;

  /// An optional publicly visible name or alias for the identity.
  String? get publicName => throw _privateConstructorUsedError;

  /// A URL or reference to an image representing the identity profile.
  String? get profileImage => throw _privateConstructorUsedError;

  /// The timestamp when this identity record was created.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// A list of service endpoints associated with this identity.
  /// See [IdentityService].
  List<IdentityService> get services => throw _privateConstructorUsedError;

  /// Serializes this PublicIdentityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicIdentityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicIdentityModelCopyWith<PublicIdentityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicIdentityModelCopyWith<$Res> {
  factory $PublicIdentityModelCopyWith(
          PublicIdentityModel value, $Res Function(PublicIdentityModel) then) =
      _$PublicIdentityModelCopyWithImpl<$Res, PublicIdentityModel>;
  @useResult
  $Res call(
      {String address,
      String name,
      String? publicName,
      String? profileImage,
      DateTime createdAt,
      List<IdentityService> services});
}

/// @nodoc
class _$PublicIdentityModelCopyWithImpl<$Res, $Val extends PublicIdentityModel>
    implements $PublicIdentityModelCopyWith<$Res> {
  _$PublicIdentityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicIdentityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? publicName = freezed,
    Object? profileImage = freezed,
    Object? createdAt = null,
    Object? services = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      publicName: freezed == publicName
          ? _value.publicName
          : publicName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<IdentityService>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublicIdentityModelImplCopyWith<$Res>
    implements $PublicIdentityModelCopyWith<$Res> {
  factory _$$PublicIdentityModelImplCopyWith(_$PublicIdentityModelImpl value,
          $Res Function(_$PublicIdentityModelImpl) then) =
      __$$PublicIdentityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String name,
      String? publicName,
      String? profileImage,
      DateTime createdAt,
      List<IdentityService> services});
}

/// @nodoc
class __$$PublicIdentityModelImplCopyWithImpl<$Res>
    extends _$PublicIdentityModelCopyWithImpl<$Res, _$PublicIdentityModelImpl>
    implements _$$PublicIdentityModelImplCopyWith<$Res> {
  __$$PublicIdentityModelImplCopyWithImpl(_$PublicIdentityModelImpl _value,
      $Res Function(_$PublicIdentityModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublicIdentityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? publicName = freezed,
    Object? profileImage = freezed,
    Object? createdAt = null,
    Object? services = null,
  }) {
    return _then(_$PublicIdentityModelImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      publicName: freezed == publicName
          ? _value.publicName
          : publicName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<IdentityService>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublicIdentityModelImpl extends _PublicIdentityModel {
  const _$PublicIdentityModelImpl(
      {required this.address,
      required this.name,
      this.publicName,
      this.profileImage,
      required this.createdAt,
      final List<IdentityService> services = const []})
      : _services = services,
        super._();

  factory _$PublicIdentityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicIdentityModelImplFromJson(json);

  /// The unique blockchain address or Decentralized Identifier (DID) for this identity.
  @override
  final String address;

  /// The primary, potentially private or internal, name associated with the identity.
  @override
  final String name;

  /// An optional publicly visible name or alias for the identity.
  @override
  final String? publicName;

  /// A URL or reference to an image representing the identity profile.
  @override
  final String? profileImage;

  /// The timestamp when this identity record was created.
  @override
  final DateTime createdAt;

  /// A list of service endpoints associated with this identity.
  /// See [IdentityService].
  final List<IdentityService> _services;

  /// A list of service endpoints associated with this identity.
  /// See [IdentityService].
  @override
  @JsonKey()
  List<IdentityService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'PublicIdentityModel(address: $address, name: $name, publicName: $publicName, profileImage: $profileImage, createdAt: $createdAt, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicIdentityModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.publicName, publicName) ||
                other.publicName == publicName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, publicName,
      profileImage, createdAt, const DeepCollectionEquality().hash(_services));

  /// Create a copy of PublicIdentityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicIdentityModelImplCopyWith<_$PublicIdentityModelImpl> get copyWith =>
      __$$PublicIdentityModelImplCopyWithImpl<_$PublicIdentityModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicIdentityModelImplToJson(
      this,
    );
  }
}

abstract class _PublicIdentityModel extends PublicIdentityModel {
  const factory _PublicIdentityModel(
      {required final String address,
      required final String name,
      final String? publicName,
      final String? profileImage,
      required final DateTime createdAt,
      final List<IdentityService> services}) = _$PublicIdentityModelImpl;
  const _PublicIdentityModel._() : super._();

  factory _PublicIdentityModel.fromJson(Map<String, dynamic> json) =
      _$PublicIdentityModelImpl.fromJson;

  /// The unique blockchain address or Decentralized Identifier (DID) for this identity.
  @override
  String get address;

  /// The primary, potentially private or internal, name associated with the identity.
  @override
  String get name;

  /// An optional publicly visible name or alias for the identity.
  @override
  String? get publicName;

  /// A URL or reference to an image representing the identity profile.
  @override
  String? get profileImage;

  /// The timestamp when this identity record was created.
  @override
  DateTime get createdAt;

  /// A list of service endpoints associated with this identity.
  /// See [IdentityService].
  @override
  List<IdentityService> get services;

  /// Create a copy of PublicIdentityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicIdentityModelImplCopyWith<_$PublicIdentityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IdentityService _$IdentityServiceFromJson(Map<String, dynamic> json) {
  return _IdentityService.fromJson(json);
}

/// @nodoc
mixin _$IdentityService {
  /// A unique identifier for the service endpoint within the context of the identity.
  /// Often formatted as `did:example:123#service-1`.
  String get id => throw _privateConstructorUsedError;

  /// The type of the service endpoint (e.g., "VerifiableCredentialService", "DIDCommMessaging").
  /// Standardized types are recommended for interoperability.
  String get type => throw _privateConstructorUsedError;

  /// The URL or URI where the service can be accessed.
  String get endpoint => throw _privateConstructorUsedError;

  /// Serializes this IdentityService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IdentityService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IdentityServiceCopyWith<IdentityService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentityServiceCopyWith<$Res> {
  factory $IdentityServiceCopyWith(
          IdentityService value, $Res Function(IdentityService) then) =
      _$IdentityServiceCopyWithImpl<$Res, IdentityService>;
  @useResult
  $Res call({String id, String type, String endpoint});
}

/// @nodoc
class _$IdentityServiceCopyWithImpl<$Res, $Val extends IdentityService>
    implements $IdentityServiceCopyWith<$Res> {
  _$IdentityServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IdentityService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? endpoint = null,
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
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IdentityServiceImplCopyWith<$Res>
    implements $IdentityServiceCopyWith<$Res> {
  factory _$$IdentityServiceImplCopyWith(_$IdentityServiceImpl value,
          $Res Function(_$IdentityServiceImpl) then) =
      __$$IdentityServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String type, String endpoint});
}

/// @nodoc
class __$$IdentityServiceImplCopyWithImpl<$Res>
    extends _$IdentityServiceCopyWithImpl<$Res, _$IdentityServiceImpl>
    implements _$$IdentityServiceImplCopyWith<$Res> {
  __$$IdentityServiceImplCopyWithImpl(
      _$IdentityServiceImpl _value, $Res Function(_$IdentityServiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of IdentityService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? endpoint = null,
  }) {
    return _then(_$IdentityServiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IdentityServiceImpl implements _IdentityService {
  const _$IdentityServiceImpl(
      {required this.id, required this.type, required this.endpoint});

  factory _$IdentityServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdentityServiceImplFromJson(json);

  /// A unique identifier for the service endpoint within the context of the identity.
  /// Often formatted as `did:example:123#service-1`.
  @override
  final String id;

  /// The type of the service endpoint (e.g., "VerifiableCredentialService", "DIDCommMessaging").
  /// Standardized types are recommended for interoperability.
  @override
  final String type;

  /// The URL or URI where the service can be accessed.
  @override
  final String endpoint;

  @override
  String toString() {
    return 'IdentityService(id: $id, type: $type, endpoint: $endpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdentityServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, endpoint);

  /// Create a copy of IdentityService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IdentityServiceImplCopyWith<_$IdentityServiceImpl> get copyWith =>
      __$$IdentityServiceImplCopyWithImpl<_$IdentityServiceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IdentityServiceImplToJson(
      this,
    );
  }
}

abstract class _IdentityService implements IdentityService {
  const factory _IdentityService(
      {required final String id,
      required final String type,
      required final String endpoint}) = _$IdentityServiceImpl;

  factory _IdentityService.fromJson(Map<String, dynamic> json) =
      _$IdentityServiceImpl.fromJson;

  /// A unique identifier for the service endpoint within the context of the identity.
  /// Often formatted as `did:example:123#service-1`.
  @override
  String get id;

  /// The type of the service endpoint (e.g., "VerifiableCredentialService", "DIDCommMessaging").
  /// Standardized types are recommended for interoperability.
  @override
  String get type;

  /// The URL or URI where the service can be accessed.
  @override
  String get endpoint;

  /// Create a copy of IdentityService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IdentityServiceImplCopyWith<_$IdentityServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
