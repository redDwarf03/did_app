// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CredentialImpl _$$CredentialImplFromJson(Map<String, dynamic> json) =>
    _$CredentialImpl(
      id: json['id'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      issuer: json['issuer'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      subject: json['subject'] as String?,
      issuanceDate: DateTime.parse(json['issuanceDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      statusListUrl: json['statusListUrl'] as String?,
      statusListIndex: (json['statusListIndex'] as num?)?.toInt(),
      verificationStatus: $enumDecodeNullable(
              _$VerificationStatusEnumMap, json['verificationStatus']) ??
          VerificationStatus.unverified,
      credentialSchema: json['credentialSchema'] as Map<String, dynamic>?,
      status: json['status'] as Map<String, dynamic>?,
      supportsZkp: json['supportsZkp'] as bool? ?? false,
      credentialSubject: json['credentialSubject'] as Map<String, dynamic>,
      context: (json['@context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      proof: json['proof'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$CredentialImplToJson(_$CredentialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'issuer': instance.issuer,
      'name': instance.name,
      'description': instance.description,
      'subject': instance.subject,
      'issuanceDate': instance.issuanceDate.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'statusListUrl': instance.statusListUrl,
      'statusListIndex': instance.statusListIndex,
      'verificationStatus':
          _$VerificationStatusEnumMap[instance.verificationStatus]!,
      'credentialSchema': instance.credentialSchema,
      'status': instance.status,
      'supportsZkp': instance.supportsZkp,
      'credentialSubject': instance.credentialSubject,
      '@context': instance.context,
      'proof': instance.proof,
    };

const _$VerificationStatusEnumMap = {
  VerificationStatus.unverified: 'unverified',
  VerificationStatus.verified: 'verified',
  VerificationStatus.invalid: 'invalid',
  VerificationStatus.expired: 'expired',
  VerificationStatus.revoked: 'revoked',
};

_$CredentialPresentationImpl _$$CredentialPresentationImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialPresentationImpl(
      id: json['id'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      verifiableCredentials: (json['verifiableCredentials'] as List<dynamic>)
          .map((e) => Credential.fromJson(e as Map<String, dynamic>))
          .toList(),
      challenge: json['challenge'] as String?,
      domain: json['domain'] as String?,
      revealedAttributes:
          (json['revealedAttributes'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      proof: json['proof'] as Map<String, dynamic>,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$$CredentialPresentationImplToJson(
        _$CredentialPresentationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'verifiableCredentials': instance.verifiableCredentials,
      'challenge': instance.challenge,
      'domain': instance.domain,
      'revealedAttributes': instance.revealedAttributes,
      'proof': instance.proof,
      'created': instance.created.toIso8601String(),
    };

_$CredentialPredicateImpl _$$CredentialPredicateImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialPredicateImpl(
      credentialId: json['credentialId'] as String,
      attribute: json['attribute'] as String,
      attributeName: json['attributeName'] as String,
      predicate: json['predicate'] as String,
      predicateType: $enumDecode(_$PredicateTypeEnumMap, json['predicateType']),
      value: json['value'],
    );

Map<String, dynamic> _$$CredentialPredicateImplToJson(
        _$CredentialPredicateImpl instance) =>
    <String, dynamic>{
      'credentialId': instance.credentialId,
      'attribute': instance.attribute,
      'attributeName': instance.attributeName,
      'predicate': instance.predicate,
      'predicateType': _$PredicateTypeEnumMap[instance.predicateType]!,
      'value': instance.value,
    };

const _$PredicateTypeEnumMap = {
  PredicateType.greaterThan: 'greaterThan',
  PredicateType.greaterThanOrEqual: 'greaterThanOrEqual',
  PredicateType.lessThan: 'lessThan',
  PredicateType.lessThanOrEqual: 'lessThanOrEqual',
  PredicateType.equal: 'equal',
};

_$ProofImpl _$$ProofImplFromJson(Map<String, dynamic> json) => _$ProofImpl(
      type: json['type'] as String,
      created: DateTime.parse(json['created'] as String),
      verificationMethod: json['verificationMethod'] as String,
      proofValue: json['proofValue'] as String,
    );

Map<String, dynamic> _$$ProofImplToJson(_$ProofImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.created.toIso8601String(),
      'verificationMethod': instance.verificationMethod,
      'proofValue': instance.proofValue,
    };
