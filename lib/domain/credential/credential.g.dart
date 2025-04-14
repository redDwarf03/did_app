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
          const <String>['https://www.w3.org/ns/credentials/v2'],
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
      context: (json['@context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['https://www.w3.org/2018/credentials/v1'],
      id: json['id'] as String?,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      holder: json['holder'] as String,
      verifiableCredentials: (json['verifiableCredential'] as List<dynamic>?)
          ?.map((e) => Credential.fromJson(e as Map<String, dynamic>))
          .toList(),
      revealedAttributes:
          (json['revealedAttributes'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      predicates: (json['predicates'] as List<dynamic>?)
          ?.map((e) => CredentialPredicate.fromJson(e as Map<String, dynamic>))
          .toList(),
      proof: json['proof'] as Map<String, dynamic>,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      challenge: json['challenge'] as String?,
      domain: json['domain'] as String?,
    );

Map<String, dynamic> _$$CredentialPresentationImplToJson(
        _$CredentialPresentationImpl instance) =>
    <String, dynamic>{
      '@context': instance.context,
      'id': instance.id,
      'type': instance.type,
      'holder': instance.holder,
      'verifiableCredential': instance.verifiableCredentials,
      'revealedAttributes': instance.revealedAttributes,
      'predicates': instance.predicates,
      'proof': instance.proof,
      'created': instance.created?.toIso8601String(),
      'challenge': instance.challenge,
      'domain': instance.domain,
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
      proofPurpose: json['proofPurpose'] as String,
      verificationMethod: json['verificationMethod'] as String,
      proofValue: json['proofValue'] as String,
      domain: json['domain'] as String?,
      challenge: json['challenge'] as String?,
    );

Map<String, dynamic> _$$ProofImplToJson(_$ProofImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.created.toIso8601String(),
      'proofPurpose': instance.proofPurpose,
      'verificationMethod': instance.verificationMethod,
      'proofValue': instance.proofValue,
      'domain': instance.domain,
      'challenge': instance.challenge,
    };

_$CredentialStatusImpl _$$CredentialStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialStatusImpl(
      id: json['id'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$CredentialStatusImplToJson(
        _$CredentialStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$CredentialSchemaImpl _$$CredentialSchemaImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialSchemaImpl(
      id: json['id'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$CredentialSchemaImplToJson(
        _$CredentialSchemaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$CredentialPredicateValueImpl _$$CredentialPredicateValueImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialPredicateValueImpl(
      attributeName: json['attributeName'] as String,
      predicateType: $enumDecode(_$PredicateTypeEnumMap, json['predicateType']),
      value: json['value'],
    );

Map<String, dynamic> _$$CredentialPredicateValueImplToJson(
        _$CredentialPredicateValueImpl instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'predicateType': _$PredicateTypeEnumMap[instance.predicateType]!,
      'value': instance.value,
    };
