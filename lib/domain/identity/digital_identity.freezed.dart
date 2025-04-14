// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DigitalIdentity _$DigitalIdentityFromJson(Map<String, dynamic> json) {
  return _DigitalIdentity.fromJson(json);
}

/// @nodoc
mixin _$DigitalIdentity {
  /// The unique identifier for this identity, typically a Decentralized Identifier (DID)
  /// or a blockchain address.
  /// This serves as the primary key for the identity on the underlying platform.
  String get identityAddress => throw _privateConstructorUsedError;

  /// A user-chosen public name or alias associated with the identity.
  /// Typically displayed publicly but does not contain sensitive PII.
  String get displayName => throw _privateConstructorUsedError;

  /// The timestamp when this identity was first created.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The timestamp of the last modification to this identity.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// The current verification status of the identity, reflecting the level of
  /// trust and verification performed.
  /// This status is often linked to KYC/AML regulatory requirements.
  IdentityVerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;

  /// Serializes this DigitalIdentity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DigitalIdentity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DigitalIdentityCopyWith<DigitalIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalIdentityCopyWith<$Res> {
  factory $DigitalIdentityCopyWith(
          DigitalIdentity value, $Res Function(DigitalIdentity) then) =
      _$DigitalIdentityCopyWithImpl<$Res, DigitalIdentity>;
  @useResult
  $Res call(
      {String identityAddress,
      String displayName,
      DateTime createdAt,
      DateTime updatedAt,
      IdentityVerificationStatus verificationStatus});
}

/// @nodoc
class _$DigitalIdentityCopyWithImpl<$Res, $Val extends DigitalIdentity>
    implements $DigitalIdentityCopyWith<$Res> {
  _$DigitalIdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DigitalIdentity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityAddress = null,
    Object? displayName = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? verificationStatus = null,
  }) {
    return _then(_value.copyWith(
      identityAddress: null == identityAddress
          ? _value.identityAddress
          : identityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as IdentityVerificationStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalIdentityImplCopyWith<$Res>
    implements $DigitalIdentityCopyWith<$Res> {
  factory _$$DigitalIdentityImplCopyWith(_$DigitalIdentityImpl value,
          $Res Function(_$DigitalIdentityImpl) then) =
      __$$DigitalIdentityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identityAddress,
      String displayName,
      DateTime createdAt,
      DateTime updatedAt,
      IdentityVerificationStatus verificationStatus});
}

/// @nodoc
class __$$DigitalIdentityImplCopyWithImpl<$Res>
    extends _$DigitalIdentityCopyWithImpl<$Res, _$DigitalIdentityImpl>
    implements _$$DigitalIdentityImplCopyWith<$Res> {
  __$$DigitalIdentityImplCopyWithImpl(
      _$DigitalIdentityImpl _value, $Res Function(_$DigitalIdentityImpl) _then)
      : super(_value, _then);

  /// Create a copy of DigitalIdentity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityAddress = null,
    Object? displayName = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? verificationStatus = null,
  }) {
    return _then(_$DigitalIdentityImpl(
      identityAddress: null == identityAddress
          ? _value.identityAddress
          : identityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as IdentityVerificationStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalIdentityImpl implements _DigitalIdentity {
  const _$DigitalIdentityImpl(
      {required this.identityAddress,
      required this.displayName,
      required this.createdAt,
      required this.updatedAt,
      this.verificationStatus = IdentityVerificationStatus.unverified});

  factory _$DigitalIdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalIdentityImplFromJson(json);

  /// The unique identifier for this identity, typically a Decentralized Identifier (DID)
  /// or a blockchain address.
  /// This serves as the primary key for the identity on the underlying platform.
  @override
  final String identityAddress;

  /// A user-chosen public name or alias associated with the identity.
  /// Typically displayed publicly but does not contain sensitive PII.
  @override
  final String displayName;

  /// The timestamp when this identity was first created.
  @override
  final DateTime createdAt;

  /// The timestamp of the last modification to this identity.
  @override
  final DateTime updatedAt;

  /// The current verification status of the identity, reflecting the level of
  /// trust and verification performed.
  /// This status is often linked to KYC/AML regulatory requirements.
  @override
  @JsonKey()
  final IdentityVerificationStatus verificationStatus;

  @override
  String toString() {
    return 'DigitalIdentity(identityAddress: $identityAddress, displayName: $displayName, createdAt: $createdAt, updatedAt: $updatedAt, verificationStatus: $verificationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalIdentityImpl &&
            (identical(other.identityAddress, identityAddress) ||
                other.identityAddress == identityAddress) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, identityAddress, displayName,
      createdAt, updatedAt, verificationStatus);

  /// Create a copy of DigitalIdentity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalIdentityImplCopyWith<_$DigitalIdentityImpl> get copyWith =>
      __$$DigitalIdentityImplCopyWithImpl<_$DigitalIdentityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalIdentityImplToJson(
      this,
    );
  }
}

abstract class _DigitalIdentity implements DigitalIdentity {
  const factory _DigitalIdentity(
          {required final String identityAddress,
          required final String displayName,
          required final DateTime createdAt,
          required final DateTime updatedAt,
          final IdentityVerificationStatus verificationStatus}) =
      _$DigitalIdentityImpl;

  factory _DigitalIdentity.fromJson(Map<String, dynamic> json) =
      _$DigitalIdentityImpl.fromJson;

  /// The unique identifier for this identity, typically a Decentralized Identifier (DID)
  /// or a blockchain address.
  /// This serves as the primary key for the identity on the underlying platform.
  @override
  String get identityAddress;

  /// A user-chosen public name or alias associated with the identity.
  /// Typically displayed publicly but does not contain sensitive PII.
  @override
  String get displayName;

  /// The timestamp when this identity was first created.
  @override
  DateTime get createdAt;

  /// The timestamp of the last modification to this identity.
  @override
  DateTime get updatedAt;

  /// The current verification status of the identity, reflecting the level of
  /// trust and verification performed.
  /// This status is often linked to KYC/AML regulatory requirements.
  @override
  IdentityVerificationStatus get verificationStatus;

  /// Create a copy of DigitalIdentity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DigitalIdentityImplCopyWith<_$DigitalIdentityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
