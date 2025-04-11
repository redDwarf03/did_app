// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CredentialImpl _$$CredentialImplFromJson(Map<String, dynamic> json) =>
    _$CredentialImpl(
      id: json['id'] as String,
      type: $enumDecode(_$CredentialTypeEnumMap, json['type']),
      name: json['name'] as String,
      description: json['description'] as String?,
      issuer: json['issuer'] as String,
      issuerId: json['issuerId'] as String,
      subjectId: json['subjectId'] as String,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      claims: json['claims'] as Map<String, dynamic>,
      schemaId: json['schemaId'] as String,
      proof: CredentialProof.fromJson(json['proof'] as Map<String, dynamic>),
      revocationStatus:
          $enumDecode(_$RevocationStatusEnumMap, json['revocationStatus']),
      revocationRegistryUrl: json['revocationRegistryUrl'] as String?,
      verificationStatus: $enumDecodeNullable(
              _$VerificationStatusEnumMap, json['verificationStatus']) ??
          VerificationStatus.unverified,
      supportsZkp: json['supportsZkp'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CredentialImplToJson(_$CredentialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CredentialTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'issuer': instance.issuer,
      'issuerId': instance.issuerId,
      'subjectId': instance.subjectId,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'claims': instance.claims,
      'schemaId': instance.schemaId,
      'proof': instance.proof,
      'revocationStatus': _$RevocationStatusEnumMap[instance.revocationStatus]!,
      'revocationRegistryUrl': instance.revocationRegistryUrl,
      'verificationStatus':
          _$VerificationStatusEnumMap[instance.verificationStatus]!,
      'supportsZkp': instance.supportsZkp,
      'metadata': instance.metadata,
    };

const _$CredentialTypeEnumMap = {
  CredentialType.identity: 'identity',
  CredentialType.diploma: 'diploma',
  CredentialType.drivingLicense: 'drivingLicense',
  CredentialType.ageVerification: 'ageVerification',
  CredentialType.addressProof: 'addressProof',
  CredentialType.employmentProof: 'employmentProof',
  CredentialType.membershipCard: 'membershipCard',
  CredentialType.healthInsurance: 'healthInsurance',
  CredentialType.other: 'other',
};

const _$RevocationStatusEnumMap = {
  RevocationStatus.notRevoked: 'notRevoked',
  RevocationStatus.revoked: 'revoked',
  RevocationStatus.unknown: 'unknown',
};

const _$VerificationStatusEnumMap = {
  VerificationStatus.unverified: 'unverified',
  VerificationStatus.verified: 'verified',
  VerificationStatus.invalid: 'invalid',
  VerificationStatus.expired: 'expired',
  VerificationStatus.revoked: 'revoked',
};

_$CredentialProofImpl _$$CredentialProofImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialProofImpl(
      type: json['type'] as String,
      created: DateTime.parse(json['created'] as String),
      verificationMethod: json['verificationMethod'] as String,
      proofPurpose: json['proofPurpose'] as String,
      proofValue: json['proofValue'] as String,
    );

Map<String, dynamic> _$$CredentialProofImplToJson(
        _$CredentialProofImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.created.toIso8601String(),
      'verificationMethod': instance.verificationMethod,
      'proofPurpose': instance.proofPurpose,
      'proofValue': instance.proofValue,
    };

_$CredentialPresentationImpl _$$CredentialPresentationImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialPresentationImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      verifiableCredentials: (json['verifiableCredentials'] as List<dynamic>)
          .map((e) => Credential.fromJson(e as Map<String, dynamic>))
          .toList(),
      created: DateTime.parse(json['created'] as String),
      revealedAttributes: json['revealedAttributes'] as Map<String, dynamic>,
      predicates: (json['predicates'] as List<dynamic>?)
          ?.map((e) => CredentialPredicate.fromJson(e as Map<String, dynamic>))
          .toList(),
      proof: CredentialProof.fromJson(json['proof'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CredentialPresentationImplToJson(
        _$CredentialPresentationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'verifiableCredentials': instance.verifiableCredentials,
      'created': instance.created.toIso8601String(),
      'revealedAttributes': instance.revealedAttributes,
      'predicates': instance.predicates,
      'proof': instance.proof,
    };

_$CredentialPredicateImpl _$$CredentialPredicateImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialPredicateImpl(
      attributeName: json['attributeName'] as String,
      predicateType: $enumDecode(_$PredicateTypeEnumMap, json['predicateType']),
      value: json['value'],
    );

Map<String, dynamic> _$$CredentialPredicateImplToJson(
        _$CredentialPredicateImpl instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
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
