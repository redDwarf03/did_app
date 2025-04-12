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
  /// The unique identifier for this identity, often a Decentralized Identifier (DID)
  /// or a blockchain address.
  /// This serves as the primary key for the identity on the underlying platform.
  String get identityAddress => throw _privateConstructorUsedError;

  /// A user-chosen public name or alias associated with the identity.
  /// This is typically displayed publicly.
  String get displayName => throw _privateConstructorUsedError;

  /// Contains sensitive Personally Identifiable Information (PII).
  /// **Security Critical:** This data must be handled with extreme care, typically
  /// stored encrypted at rest and transmitted securely. Its processing is subject
  /// to strict privacy regulations like GDPR.
  /// See [PersonalInfo] for details.
  PersonalInfo get personalInfo => throw _privateConstructorUsedError;

  /// The timestamp when this identity was first created or registered.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// The timestamp of the last modification to any attribute of this identity.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// The current verification status of the identity, reflecting the level of
  /// trust and checks performed. See [IdentityVerificationStatus].
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
      PersonalInfo personalInfo,
      DateTime createdAt,
      DateTime updatedAt,
      IdentityVerificationStatus verificationStatus});

  $PersonalInfoCopyWith<$Res> get personalInfo;
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
    Object? personalInfo = null,
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
      personalInfo: null == personalInfo
          ? _value.personalInfo
          : personalInfo // ignore: cast_nullable_to_non_nullable
              as PersonalInfo,
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

  /// Create a copy of DigitalIdentity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonalInfoCopyWith<$Res> get personalInfo {
    return $PersonalInfoCopyWith<$Res>(_value.personalInfo, (value) {
      return _then(_value.copyWith(personalInfo: value) as $Val);
    });
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
      PersonalInfo personalInfo,
      DateTime createdAt,
      DateTime updatedAt,
      IdentityVerificationStatus verificationStatus});

  @override
  $PersonalInfoCopyWith<$Res> get personalInfo;
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
    Object? personalInfo = null,
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
      personalInfo: null == personalInfo
          ? _value.personalInfo
          : personalInfo // ignore: cast_nullable_to_non_nullable
              as PersonalInfo,
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
      required this.personalInfo,
      required this.createdAt,
      required this.updatedAt,
      this.verificationStatus = IdentityVerificationStatus.unverified});

  factory _$DigitalIdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalIdentityImplFromJson(json);

  /// The unique identifier for this identity, often a Decentralized Identifier (DID)
  /// or a blockchain address.
  /// This serves as the primary key for the identity on the underlying platform.
  @override
  final String identityAddress;

  /// A user-chosen public name or alias associated with the identity.
  /// This is typically displayed publicly.
  @override
  final String displayName;

  /// Contains sensitive Personally Identifiable Information (PII).
  /// **Security Critical:** This data must be handled with extreme care, typically
  /// stored encrypted at rest and transmitted securely. Its processing is subject
  /// to strict privacy regulations like GDPR.
  /// See [PersonalInfo] for details.
  @override
  final PersonalInfo personalInfo;

  /// The timestamp when this identity was first created or registered.
  @override
  final DateTime createdAt;

  /// The timestamp of the last modification to any attribute of this identity.
  @override
  final DateTime updatedAt;

  /// The current verification status of the identity, reflecting the level of
  /// trust and checks performed. See [IdentityVerificationStatus].
  /// This status is often linked to KYC/AML regulatory requirements.
  @override
  @JsonKey()
  final IdentityVerificationStatus verificationStatus;

  @override
  String toString() {
    return 'DigitalIdentity(identityAddress: $identityAddress, displayName: $displayName, personalInfo: $personalInfo, createdAt: $createdAt, updatedAt: $updatedAt, verificationStatus: $verificationStatus)';
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
            (identical(other.personalInfo, personalInfo) ||
                other.personalInfo == personalInfo) &&
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
      personalInfo, createdAt, updatedAt, verificationStatus);

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
          required final PersonalInfo personalInfo,
          required final DateTime createdAt,
          required final DateTime updatedAt,
          final IdentityVerificationStatus verificationStatus}) =
      _$DigitalIdentityImpl;

  factory _DigitalIdentity.fromJson(Map<String, dynamic> json) =
      _$DigitalIdentityImpl.fromJson;

  /// The unique identifier for this identity, often a Decentralized Identifier (DID)
  /// or a blockchain address.
  /// This serves as the primary key for the identity on the underlying platform.
  @override
  String get identityAddress;

  /// A user-chosen public name or alias associated with the identity.
  /// This is typically displayed publicly.
  @override
  String get displayName;

  /// Contains sensitive Personally Identifiable Information (PII).
  /// **Security Critical:** This data must be handled with extreme care, typically
  /// stored encrypted at rest and transmitted securely. Its processing is subject
  /// to strict privacy regulations like GDPR.
  /// See [PersonalInfo] for details.
  @override
  PersonalInfo get personalInfo;

  /// The timestamp when this identity was first created or registered.
  @override
  DateTime get createdAt;

  /// The timestamp of the last modification to any attribute of this identity.
  @override
  DateTime get updatedAt;

  /// The current verification status of the identity, reflecting the level of
  /// trust and checks performed. See [IdentityVerificationStatus].
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

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) {
  return _PersonalInfo.fromJson(json);
}

/// @nodoc
mixin _$PersonalInfo {
  /// The user's full legal name. Often required for KYC processes.
  String get fullName => throw _privateConstructorUsedError;

  /// The user's primary email address. Commonly used for communication and
  /// basic verification.
  String get email => throw _privateConstructorUsedError;

  /// The user's phone number, including the country code (e.g., +1, +44).
  /// Often used for multi-factor authentication or basic verification.
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// The user's date of birth. Critical for age verification and KYC compliance.
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;

  /// The user's nationality, typically represented by a country name or code (e.g., ISO 3166-1 alpha-2).
  /// Often required for KYC/AML checks.
  String? get nationality => throw _privateConstructorUsedError;

  /// The user's physical residential address. See [PhysicalAddress].
  /// Required for higher levels of identity verification (KYC).
  PhysicalAddress? get address => throw _privateConstructorUsedError;

  /// Serializes this PersonalInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalInfoCopyWith<PersonalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalInfoCopyWith<$Res> {
  factory $PersonalInfoCopyWith(
          PersonalInfo value, $Res Function(PersonalInfo) then) =
      _$PersonalInfoCopyWithImpl<$Res, PersonalInfo>;
  @useResult
  $Res call(
      {String fullName,
      String email,
      String? phoneNumber,
      DateTime? dateOfBirth,
      String? nationality,
      PhysicalAddress? address});

  $PhysicalAddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$PersonalInfoCopyWithImpl<$Res, $Val extends PersonalInfo>
    implements $PersonalInfoCopyWith<$Res> {
  _$PersonalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? dateOfBirth = freezed,
    Object? nationality = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as PhysicalAddress?,
    ) as $Val);
  }

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PhysicalAddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $PhysicalAddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PersonalInfoImplCopyWith<$Res>
    implements $PersonalInfoCopyWith<$Res> {
  factory _$$PersonalInfoImplCopyWith(
          _$PersonalInfoImpl value, $Res Function(_$PersonalInfoImpl) then) =
      __$$PersonalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String email,
      String? phoneNumber,
      DateTime? dateOfBirth,
      String? nationality,
      PhysicalAddress? address});

  @override
  $PhysicalAddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$PersonalInfoImplCopyWithImpl<$Res>
    extends _$PersonalInfoCopyWithImpl<$Res, _$PersonalInfoImpl>
    implements _$$PersonalInfoImplCopyWith<$Res> {
  __$$PersonalInfoImplCopyWithImpl(
      _$PersonalInfoImpl _value, $Res Function(_$PersonalInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? dateOfBirth = freezed,
    Object? nationality = freezed,
    Object? address = freezed,
  }) {
    return _then(_$PersonalInfoImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as PhysicalAddress?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalInfoImpl implements _PersonalInfo {
  const _$PersonalInfoImpl(
      {required this.fullName,
      required this.email,
      this.phoneNumber,
      this.dateOfBirth,
      this.nationality,
      this.address});

  factory _$PersonalInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalInfoImplFromJson(json);

  /// The user's full legal name. Often required for KYC processes.
  @override
  final String fullName;

  /// The user's primary email address. Commonly used for communication and
  /// basic verification.
  @override
  final String email;

  /// The user's phone number, including the country code (e.g., +1, +44).
  /// Often used for multi-factor authentication or basic verification.
  @override
  final String? phoneNumber;

  /// The user's date of birth. Critical for age verification and KYC compliance.
  @override
  final DateTime? dateOfBirth;

  /// The user's nationality, typically represented by a country name or code (e.g., ISO 3166-1 alpha-2).
  /// Often required for KYC/AML checks.
  @override
  final String? nationality;

  /// The user's physical residential address. See [PhysicalAddress].
  /// Required for higher levels of identity verification (KYC).
  @override
  final PhysicalAddress? address;

  @override
  String toString() {
    return 'PersonalInfo(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, nationality: $nationality, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalInfoImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, email, phoneNumber,
      dateOfBirth, nationality, address);

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      __$$PersonalInfoImplCopyWithImpl<_$PersonalInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalInfoImplToJson(
      this,
    );
  }
}

abstract class _PersonalInfo implements PersonalInfo {
  const factory _PersonalInfo(
      {required final String fullName,
      required final String email,
      final String? phoneNumber,
      final DateTime? dateOfBirth,
      final String? nationality,
      final PhysicalAddress? address}) = _$PersonalInfoImpl;

  factory _PersonalInfo.fromJson(Map<String, dynamic> json) =
      _$PersonalInfoImpl.fromJson;

  /// The user's full legal name. Often required for KYC processes.
  @override
  String get fullName;

  /// The user's primary email address. Commonly used for communication and
  /// basic verification.
  @override
  String get email;

  /// The user's phone number, including the country code (e.g., +1, +44).
  /// Often used for multi-factor authentication or basic verification.
  @override
  String? get phoneNumber;

  /// The user's date of birth. Critical for age verification and KYC compliance.
  @override
  DateTime? get dateOfBirth;

  /// The user's nationality, typically represented by a country name or code (e.g., ISO 3166-1 alpha-2).
  /// Often required for KYC/AML checks.
  @override
  String? get nationality;

  /// The user's physical residential address. See [PhysicalAddress].
  /// Required for higher levels of identity verification (KYC).
  @override
  PhysicalAddress? get address;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhysicalAddress _$PhysicalAddressFromJson(Map<String, dynamic> json) {
  return _PhysicalAddress.fromJson(json);
}

/// @nodoc
mixin _$PhysicalAddress {
  /// The street name and number, potentially including apartment or unit details.
  String get street => throw _privateConstructorUsedError;

  /// The name of the city or town.
  String get city => throw _privateConstructorUsedError;

  /// The state, province, region, or county, depending on the country's structure.
  String? get state => throw _privateConstructorUsedError;

  /// The postal code or ZIP code used for mail delivery.
  String get postalCode => throw _privateConstructorUsedError;

  /// The country, ideally represented using ISO 3166-1 alpha-2 codes (e.g., "US", "GB", "FR").
  String get country => throw _privateConstructorUsedError;

  /// Serializes this PhysicalAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhysicalAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhysicalAddressCopyWith<PhysicalAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhysicalAddressCopyWith<$Res> {
  factory $PhysicalAddressCopyWith(
          PhysicalAddress value, $Res Function(PhysicalAddress) then) =
      _$PhysicalAddressCopyWithImpl<$Res, PhysicalAddress>;
  @useResult
  $Res call(
      {String street,
      String city,
      String? state,
      String postalCode,
      String country});
}

/// @nodoc
class _$PhysicalAddressCopyWithImpl<$Res, $Val extends PhysicalAddress>
    implements $PhysicalAddressCopyWith<$Res> {
  _$PhysicalAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhysicalAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = freezed,
    Object? postalCode = null,
    Object? country = null,
  }) {
    return _then(_value.copyWith(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhysicalAddressImplCopyWith<$Res>
    implements $PhysicalAddressCopyWith<$Res> {
  factory _$$PhysicalAddressImplCopyWith(_$PhysicalAddressImpl value,
          $Res Function(_$PhysicalAddressImpl) then) =
      __$$PhysicalAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String street,
      String city,
      String? state,
      String postalCode,
      String country});
}

/// @nodoc
class __$$PhysicalAddressImplCopyWithImpl<$Res>
    extends _$PhysicalAddressCopyWithImpl<$Res, _$PhysicalAddressImpl>
    implements _$$PhysicalAddressImplCopyWith<$Res> {
  __$$PhysicalAddressImplCopyWithImpl(
      _$PhysicalAddressImpl _value, $Res Function(_$PhysicalAddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhysicalAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = freezed,
    Object? postalCode = null,
    Object? country = null,
  }) {
    return _then(_$PhysicalAddressImpl(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhysicalAddressImpl implements _PhysicalAddress {
  const _$PhysicalAddressImpl(
      {required this.street,
      required this.city,
      this.state,
      required this.postalCode,
      required this.country});

  factory _$PhysicalAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhysicalAddressImplFromJson(json);

  /// The street name and number, potentially including apartment or unit details.
  @override
  final String street;

  /// The name of the city or town.
  @override
  final String city;

  /// The state, province, region, or county, depending on the country's structure.
  @override
  final String? state;

  /// The postal code or ZIP code used for mail delivery.
  @override
  final String postalCode;

  /// The country, ideally represented using ISO 3166-1 alpha-2 codes (e.g., "US", "GB", "FR").
  @override
  final String country;

  @override
  String toString() {
    return 'PhysicalAddress(street: $street, city: $city, state: $state, postalCode: $postalCode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhysicalAddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, city, state, postalCode, country);

  /// Create a copy of PhysicalAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhysicalAddressImplCopyWith<_$PhysicalAddressImpl> get copyWith =>
      __$$PhysicalAddressImplCopyWithImpl<_$PhysicalAddressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhysicalAddressImplToJson(
      this,
    );
  }
}

abstract class _PhysicalAddress implements PhysicalAddress {
  const factory _PhysicalAddress(
      {required final String street,
      required final String city,
      final String? state,
      required final String postalCode,
      required final String country}) = _$PhysicalAddressImpl;

  factory _PhysicalAddress.fromJson(Map<String, dynamic> json) =
      _$PhysicalAddressImpl.fromJson;

  /// The street name and number, potentially including apartment or unit details.
  @override
  String get street;

  /// The name of the city or town.
  @override
  String get city;

  /// The state, province, region, or county, depending on the country's structure.
  @override
  String? get state;

  /// The postal code or ZIP code used for mail delivery.
  @override
  String get postalCode;

  /// The country, ideally represented using ISO 3166-1 alpha-2 codes (e.g., "US", "GB", "FR").
  @override
  String get country;

  /// Create a copy of PhysicalAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhysicalAddressImplCopyWith<_$PhysicalAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
