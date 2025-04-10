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
  /// Unique identifier of the identity on the blockchain
  String get identityAddress => throw _privateConstructorUsedError;

  /// The public name of the identity
  String get displayName => throw _privateConstructorUsedError;

  /// Personal information (encrypted when stored)
  PersonalInfo get personalInfo => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Verification status of the identity
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

  /// Unique identifier of the identity on the blockchain
  @override
  final String identityAddress;

  /// The public name of the identity
  @override
  final String displayName;

  /// Personal information (encrypted when stored)
  @override
  final PersonalInfo personalInfo;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  /// Verification status of the identity
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

  /// Unique identifier of the identity on the blockchain
  @override
  String get identityAddress;

  /// The public name of the identity
  @override
  String get displayName;

  /// Personal information (encrypted when stored)
  @override
  PersonalInfo get personalInfo;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// Verification status of the identity
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
  /// Full legal name
  String get fullName => throw _privateConstructorUsedError;

  /// Email address
  String get email => throw _privateConstructorUsedError;

  /// Phone number with country code
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Date of birth
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;

  /// Nationality
  String? get nationality => throw _privateConstructorUsedError;

  /// Physical address
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

  /// Full legal name
  @override
  final String fullName;

  /// Email address
  @override
  final String email;

  /// Phone number with country code
  @override
  final String? phoneNumber;

  /// Date of birth
  @override
  final DateTime? dateOfBirth;

  /// Nationality
  @override
  final String? nationality;

  /// Physical address
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

  /// Full legal name
  @override
  String get fullName;

  /// Email address
  @override
  String get email;

  /// Phone number with country code
  @override
  String? get phoneNumber;

  /// Date of birth
  @override
  DateTime? get dateOfBirth;

  /// Nationality
  @override
  String? get nationality;

  /// Physical address
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
  /// Street address including number
  String get street => throw _privateConstructorUsedError;

  /// City name
  String get city => throw _privateConstructorUsedError;

  /// State/province/region
  String? get state => throw _privateConstructorUsedError;

  /// Postal/ZIP code
  String get postalCode => throw _privateConstructorUsedError;

  /// Country
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

  /// Street address including number
  @override
  final String street;

  /// City name
  @override
  final String city;

  /// State/province/region
  @override
  final String? state;

  /// Postal/ZIP code
  @override
  final String postalCode;

  /// Country
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

  /// Street address including number
  @override
  String get street;

  /// City name
  @override
  String get city;

  /// State/province/region
  @override
  String? get state;

  /// Postal/ZIP code
  @override
  String get postalCode;

  /// Country
  @override
  String get country;

  /// Create a copy of PhysicalAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhysicalAddressImplCopyWith<_$PhysicalAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
