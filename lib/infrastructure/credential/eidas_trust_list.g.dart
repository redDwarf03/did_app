// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eidas_trust_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrustedIssuerImpl _$$TrustedIssuerImplFromJson(Map<String, dynamic> json) =>
    _$TrustedIssuerImpl(
      did: json['did'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      serviceType: json['serviceType'] as String,
      trustLevel: $enumDecode(_$TrustLevelEnumMap, json['trustLevel']),
      validUntil: DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$$TrustedIssuerImplToJson(_$TrustedIssuerImpl instance) =>
    <String, dynamic>{
      'did': instance.did,
      'name': instance.name,
      'country': instance.country,
      'serviceType': instance.serviceType,
      'trustLevel': _$TrustLevelEnumMap[instance.trustLevel]!,
      'validUntil': instance.validUntil.toIso8601String(),
    };

const _$TrustLevelEnumMap = {
  TrustLevel.low: 'low',
  TrustLevel.substantial: 'substantial',
  TrustLevel.high: 'high',
};
