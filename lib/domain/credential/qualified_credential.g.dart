// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualified_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QualifiedCredentialImpl _$$QualifiedCredentialImplFromJson(
        Map<String, dynamic> json) =>
    _$QualifiedCredentialImpl(
      credential:
          Credential.fromJson(json['credential'] as Map<String, dynamic>),
      assuranceLevel:
          $enumDecode(_$AssuranceLevelEnumMap, json['assuranceLevel']),
      signatureType:
          $enumDecode(_$QualifiedSignatureTypeEnumMap, json['signatureType']),
      qualifiedTrustServiceProviderId:
          json['qualifiedTrustServiceProviderId'] as String,
      certificationDate: DateTime.parse(json['certificationDate'] as String),
      certificationExpiryDate:
          DateTime.parse(json['certificationExpiryDate'] as String),
      certificationCountry: json['certificationCountry'] as String,
      qualifiedTrustRegistryUrl: json['qualifiedTrustRegistryUrl'] as String,
      qualifiedCertificateId: json['qualifiedCertificateId'] as String,
      qualifiedAttributes: json['qualifiedAttributes'] as Map<String, dynamic>,
      qualifiedProof: json['qualifiedProof'] as String,
    );

Map<String, dynamic> _$$QualifiedCredentialImplToJson(
        _$QualifiedCredentialImpl instance) =>
    <String, dynamic>{
      'credential': instance.credential,
      'assuranceLevel': _$AssuranceLevelEnumMap[instance.assuranceLevel]!,
      'signatureType': _$QualifiedSignatureTypeEnumMap[instance.signatureType]!,
      'qualifiedTrustServiceProviderId':
          instance.qualifiedTrustServiceProviderId,
      'certificationDate': instance.certificationDate.toIso8601String(),
      'certificationExpiryDate':
          instance.certificationExpiryDate.toIso8601String(),
      'certificationCountry': instance.certificationCountry,
      'qualifiedTrustRegistryUrl': instance.qualifiedTrustRegistryUrl,
      'qualifiedCertificateId': instance.qualifiedCertificateId,
      'qualifiedAttributes': instance.qualifiedAttributes,
      'qualifiedProof': instance.qualifiedProof,
    };

const _$AssuranceLevelEnumMap = {
  AssuranceLevel.low: 'low',
  AssuranceLevel.substantial: 'substantial',
  AssuranceLevel.high: 'high',
};

const _$QualifiedSignatureTypeEnumMap = {
  QualifiedSignatureType.qes: 'qes',
  QualifiedSignatureType.qeseal: 'qeseal',
  QualifiedSignatureType.qwac: 'qwac',
};

_$QualifiedTrustServiceImpl _$$QualifiedTrustServiceImplFromJson(
        Map<String, dynamic> json) =>
    _$QualifiedTrustServiceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      country: json['country'] as String,
      status: json['status'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      serviceUrl: json['serviceUrl'] as String,
      qualifiedCertificates: (json['qualifiedCertificates'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      assuranceLevel:
          $enumDecode(_$AssuranceLevelEnumMap, json['assuranceLevel']),
    );

Map<String, dynamic> _$$QualifiedTrustServiceImplToJson(
        _$QualifiedTrustServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'country': instance.country,
      'status': instance.status,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'serviceUrl': instance.serviceUrl,
      'qualifiedCertificates': instance.qualifiedCertificates,
      'assuranceLevel': _$AssuranceLevelEnumMap[instance.assuranceLevel]!,
    };
