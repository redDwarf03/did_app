// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simplified_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimplifiedCredentialImpl _$$SimplifiedCredentialImplFromJson(
        Map<String, dynamic> json) =>
    _$SimplifiedCredentialImpl(
      id: json['id'] as String,
      type: $enumDecode(_$SimplifiedCredentialTypeEnumMap, json['type']),
      issuer: json['issuer'] as String,
      issuanceDate: DateTime.parse(json['issuanceDate'] as String),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      attributes: json['attributes'] as Map<String, dynamic>,
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$$SimplifiedCredentialImplToJson(
        _$SimplifiedCredentialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SimplifiedCredentialTypeEnumMap[instance.type]!,
      'issuer': instance.issuer,
      'issuanceDate': instance.issuanceDate.toIso8601String(),
      'expirationDate': instance.expirationDate.toIso8601String(),
      'attributes': instance.attributes,
      'isVerified': instance.isVerified,
    };

const _$SimplifiedCredentialTypeEnumMap = {
  SimplifiedCredentialType.identity: 'identity',
  SimplifiedCredentialType.diploma: 'diploma',
  SimplifiedCredentialType.certificate: 'certificate',
  SimplifiedCredentialType.membership: 'membership',
  SimplifiedCredentialType.license: 'license',
  SimplifiedCredentialType.healthCard: 'healthCard',
  SimplifiedCredentialType.custom: 'custom',
};
