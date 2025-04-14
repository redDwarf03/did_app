// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eidas_trust_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrustedIssuer _$TrustedIssuerFromJson(Map<String, dynamic> json) {
  return _TrustedIssuer.fromJson(json);
}

/// @nodoc
mixin _$TrustedIssuer {
  /// Unique identifier for the issuer, often represented as a Decentralized Identifier (DID).
  String get did => throw _privateConstructorUsedError;

  /// Official name of the trusted issuer (e.g., company name).
  String get name => throw _privateConstructorUsedError;

  /// ISO 3166-1 alpha-2 country code where the issuer is based or operates.
  String get country => throw _privateConstructorUsedError;

  /// Type of trust service provided (e.g., IdentityProvider, AttributeProvider, TimestampAuthority).
  String get serviceType => throw _privateConstructorUsedError;

  /// Level of Assurance defined by eIDAS regulation for the service/issuer.
  TrustLevel get trustLevel => throw _privateConstructorUsedError;

  /// Date until which the issuer's status or service is considered valid in the trust list.
  DateTime get validUntil => throw _privateConstructorUsedError;

  /// Serializes this TrustedIssuer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrustedIssuer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrustedIssuerCopyWith<TrustedIssuer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustedIssuerCopyWith<$Res> {
  factory $TrustedIssuerCopyWith(
          TrustedIssuer value, $Res Function(TrustedIssuer) then) =
      _$TrustedIssuerCopyWithImpl<$Res, TrustedIssuer>;
  @useResult
  $Res call(
      {String did,
      String name,
      String country,
      String serviceType,
      TrustLevel trustLevel,
      DateTime validUntil});
}

/// @nodoc
class _$TrustedIssuerCopyWithImpl<$Res, $Val extends TrustedIssuer>
    implements $TrustedIssuerCopyWith<$Res> {
  _$TrustedIssuerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrustedIssuer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? did = null,
    Object? name = null,
    Object? country = null,
    Object? serviceType = null,
    Object? trustLevel = null,
    Object? validUntil = null,
  }) {
    return _then(_value.copyWith(
      did: null == did
          ? _value.did
          : did // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      trustLevel: null == trustLevel
          ? _value.trustLevel
          : trustLevel // ignore: cast_nullable_to_non_nullable
              as TrustLevel,
      validUntil: null == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrustedIssuerImplCopyWith<$Res>
    implements $TrustedIssuerCopyWith<$Res> {
  factory _$$TrustedIssuerImplCopyWith(
          _$TrustedIssuerImpl value, $Res Function(_$TrustedIssuerImpl) then) =
      __$$TrustedIssuerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String did,
      String name,
      String country,
      String serviceType,
      TrustLevel trustLevel,
      DateTime validUntil});
}

/// @nodoc
class __$$TrustedIssuerImplCopyWithImpl<$Res>
    extends _$TrustedIssuerCopyWithImpl<$Res, _$TrustedIssuerImpl>
    implements _$$TrustedIssuerImplCopyWith<$Res> {
  __$$TrustedIssuerImplCopyWithImpl(
      _$TrustedIssuerImpl _value, $Res Function(_$TrustedIssuerImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrustedIssuer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? did = null,
    Object? name = null,
    Object? country = null,
    Object? serviceType = null,
    Object? trustLevel = null,
    Object? validUntil = null,
  }) {
    return _then(_$TrustedIssuerImpl(
      did: null == did
          ? _value.did
          : did // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      trustLevel: null == trustLevel
          ? _value.trustLevel
          : trustLevel // ignore: cast_nullable_to_non_nullable
              as TrustLevel,
      validUntil: null == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrustedIssuerImpl implements _TrustedIssuer {
  const _$TrustedIssuerImpl(
      {required this.did,
      required this.name,
      required this.country,
      required this.serviceType,
      required this.trustLevel,
      required this.validUntil});

  factory _$TrustedIssuerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrustedIssuerImplFromJson(json);

  /// Unique identifier for the issuer, often represented as a Decentralized Identifier (DID).
  @override
  final String did;

  /// Official name of the trusted issuer (e.g., company name).
  @override
  final String name;

  /// ISO 3166-1 alpha-2 country code where the issuer is based or operates.
  @override
  final String country;

  /// Type of trust service provided (e.g., IdentityProvider, AttributeProvider, TimestampAuthority).
  @override
  final String serviceType;

  /// Level of Assurance defined by eIDAS regulation for the service/issuer.
  @override
  final TrustLevel trustLevel;

  /// Date until which the issuer's status or service is considered valid in the trust list.
  @override
  final DateTime validUntil;

  @override
  String toString() {
    return 'TrustedIssuer(did: $did, name: $name, country: $country, serviceType: $serviceType, trustLevel: $trustLevel, validUntil: $validUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustedIssuerImpl &&
            (identical(other.did, did) || other.did == did) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, did, name, country, serviceType, trustLevel, validUntil);

  /// Create a copy of TrustedIssuer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustedIssuerImplCopyWith<_$TrustedIssuerImpl> get copyWith =>
      __$$TrustedIssuerImplCopyWithImpl<_$TrustedIssuerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustedIssuerImplToJson(
      this,
    );
  }
}

abstract class _TrustedIssuer implements TrustedIssuer {
  const factory _TrustedIssuer(
      {required final String did,
      required final String name,
      required final String country,
      required final String serviceType,
      required final TrustLevel trustLevel,
      required final DateTime validUntil}) = _$TrustedIssuerImpl;

  factory _TrustedIssuer.fromJson(Map<String, dynamic> json) =
      _$TrustedIssuerImpl.fromJson;

  /// Unique identifier for the issuer, often represented as a Decentralized Identifier (DID).
  @override
  String get did;

  /// Official name of the trusted issuer (e.g., company name).
  @override
  String get name;

  /// ISO 3166-1 alpha-2 country code where the issuer is based or operates.
  @override
  String get country;

  /// Type of trust service provided (e.g., IdentityProvider, AttributeProvider, TimestampAuthority).
  @override
  String get serviceType;

  /// Level of Assurance defined by eIDAS regulation for the service/issuer.
  @override
  TrustLevel get trustLevel;

  /// Date until which the issuer's status or service is considered valid in the trust list.
  @override
  DateTime get validUntil;

  /// Create a copy of TrustedIssuer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrustedIssuerImplCopyWith<_$TrustedIssuerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
