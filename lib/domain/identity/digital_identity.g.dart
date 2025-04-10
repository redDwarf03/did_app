// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DigitalIdentityImpl _$$DigitalIdentityImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalIdentityImpl(
      identityAddress: json['identityAddress'] as String,
      displayName: json['displayName'] as String,
      personalInfo:
          PersonalInfo.fromJson(json['personalInfo'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      verificationStatus: $enumDecodeNullable(
              _$IdentityVerificationStatusEnumMap,
              json['verificationStatus']) ??
          IdentityVerificationStatus.unverified,
    );

Map<String, dynamic> _$$DigitalIdentityImplToJson(
        _$DigitalIdentityImpl instance) =>
    <String, dynamic>{
      'identityAddress': instance.identityAddress,
      'displayName': instance.displayName,
      'personalInfo': instance.personalInfo,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'verificationStatus':
          _$IdentityVerificationStatusEnumMap[instance.verificationStatus]!,
    };

const _$IdentityVerificationStatusEnumMap = {
  IdentityVerificationStatus.unverified: 'unverified',
  IdentityVerificationStatus.basicVerified: 'basicVerified',
  IdentityVerificationStatus.fullyVerified: 'fullyVerified',
  IdentityVerificationStatus.pending: 'pending',
  IdentityVerificationStatus.rejected: 'rejected',
};

_$PersonalInfoImpl _$$PersonalInfoImplFromJson(Map<String, dynamic> json) =>
    _$PersonalInfoImpl(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      nationality: json['nationality'] as String?,
      address: json['address'] == null
          ? null
          : PhysicalAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PersonalInfoImplToJson(_$PersonalInfoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'nationality': instance.nationality,
      'address': instance.address,
    };

_$PhysicalAddressImpl _$$PhysicalAddressImplFromJson(
        Map<String, dynamic> json) =>
    _$PhysicalAddressImpl(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$$PhysicalAddressImplToJson(
        _$PhysicalAddressImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
    };
