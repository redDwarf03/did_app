// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_list_2021.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatusList2021CredentialImpl _$$StatusList2021CredentialImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusList2021CredentialImpl(
      id: json['id'] as String,
      context:
          (json['@context'] as List<dynamic>).map((e) => e as String).toList(),
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      issuer: json['issuer'] as String,
      issuanceDate: DateTime.parse(json['issuanceDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      description: json['description'] as String?,
      credentialSubject: StatusList2021Subject.fromJson(
          json['credentialSubject'] as Map<String, dynamic>),
      proof:
          StatusList2021Proof.fromJson(json['proof'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatusList2021CredentialImplToJson(
        _$StatusList2021CredentialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      '@context': instance.context,
      'type': instance.type,
      'issuer': instance.issuer,
      'issuanceDate': instance.issuanceDate.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'description': instance.description,
      'credentialSubject': instance.credentialSubject,
      'proof': instance.proof,
    };

_$StatusList2021SubjectImpl _$$StatusList2021SubjectImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusList2021SubjectImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      statusPurpose: $enumDecode(_$StatusPurposeEnumMap, json['statusPurpose']),
      encoding: json['encoding'] as String? ?? 'base64url',
      encodedList: json['encodedList'] as String,
    );

Map<String, dynamic> _$$StatusList2021SubjectImplToJson(
        _$StatusList2021SubjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'statusPurpose': _$StatusPurposeEnumMap[instance.statusPurpose]!,
      'encoding': instance.encoding,
      'encodedList': instance.encodedList,
    };

const _$StatusPurposeEnumMap = {
  StatusPurpose.revocation: 'revocation',
  StatusPurpose.suspension: 'suspension',
};

_$StatusList2021ProofImpl _$$StatusList2021ProofImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusList2021ProofImpl(
      type: json['type'] as String,
      created: DateTime.parse(json['created'] as String),
      verificationMethod: json['verificationMethod'] as String,
      proofPurpose: json['proofPurpose'] as String,
      proofValue: json['proofValue'] as String,
    );

Map<String, dynamic> _$$StatusList2021ProofImplToJson(
        _$StatusList2021ProofImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.created.toIso8601String(),
      'verificationMethod': instance.verificationMethod,
      'proofPurpose': instance.proofPurpose,
      'proofValue': instance.proofValue,
    };

_$StatusList2021EntryImpl _$$StatusList2021EntryImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusList2021EntryImpl(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'StatusList2021',
      statusPurpose: $enumDecode(_$StatusPurposeEnumMap, json['statusPurpose']),
      statusListCredential: json['statusListCredential'] as String,
      statusListIndex: (json['statusListIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$StatusList2021EntryImplToJson(
        _$StatusList2021EntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'statusPurpose': _$StatusPurposeEnumMap[instance.statusPurpose]!,
      'statusListCredential': instance.statusListCredential,
      'statusListIndex': instance.statusListIndex,
    };
