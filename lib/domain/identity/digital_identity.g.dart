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
