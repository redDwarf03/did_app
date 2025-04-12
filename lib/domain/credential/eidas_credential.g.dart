// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eidas_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EidasCredentialImpl _$$EidasCredentialImplFromJson(
        Map<String, dynamic> json) =>
    _$EidasCredentialImpl(
      id: json['id'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      issuer: EidasIssuer.fromJson(json['issuer']),
      issuanceDate: DateTime.parse(json['issuanceDate'] as String),
      credentialSubject: json['credentialSubject'] as Map<String, dynamic>,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      credentialSchema: json['credentialSchema'] == null
          ? null
          : EidasCredentialSchema.fromJson(
              json['credentialSchema'] as Map<String, dynamic>),
      credentialStatus: json['credentialStatus'] == null
          ? null
          : EidasCredentialStatus.fromJson(
              json['credentialStatus'] as Map<String, dynamic>),
      proof: json['proof'] == null
          ? null
          : EidasProof.fromJson(json['proof'] as Map<String, dynamic>),
      evidence: (json['evidence'] as List<dynamic>?)
          ?.map((e) => EidasEvidence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EidasCredentialImplToJson(
        _$EidasCredentialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'issuer': instance.issuer,
      'issuanceDate': instance.issuanceDate.toIso8601String(),
      'credentialSubject': instance.credentialSubject,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'credentialSchema': instance.credentialSchema,
      'credentialStatus': instance.credentialStatus,
      'proof': instance.proof,
      'evidence': instance.evidence,
    };

_$EidasIssuerImpl _$$EidasIssuerImplFromJson(Map<String, dynamic> json) =>
    _$EidasIssuerImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String?,
      organizationType: json['organizationType'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      address: json['address'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EidasIssuerImplToJson(_$EidasIssuerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'url': instance.url,
      'organizationType': instance.organizationType,
      'registrationNumber': instance.registrationNumber,
      'address': instance.address,
    };

_$EidasCredentialSchemaImpl _$$EidasCredentialSchemaImplFromJson(
        Map<String, dynamic> json) =>
    _$EidasCredentialSchemaImpl(
      id: json['id'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$EidasCredentialSchemaImplToJson(
        _$EidasCredentialSchemaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$EidasCredentialStatusImpl _$$EidasCredentialStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$EidasCredentialStatusImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      statusPurpose: json['statusPurpose'] as String?,
      statusListIndex: (json['statusListIndex'] as num?)?.toInt(),
      statusListCredential: json['statusListCredential'] as String?,
    );

Map<String, dynamic> _$$EidasCredentialStatusImplToJson(
        _$EidasCredentialStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'statusPurpose': instance.statusPurpose,
      'statusListIndex': instance.statusListIndex,
      'statusListCredential': instance.statusListCredential,
    };

_$EidasProofImpl _$$EidasProofImplFromJson(Map<String, dynamic> json) =>
    _$EidasProofImpl(
      type: json['type'] as String,
      created: DateTime.parse(json['created'] as String),
      verificationMethod: json['verificationMethod'] as String,
      proofPurpose: json['proofPurpose'] as String,
      proofValue: json['proofValue'] as String,
      challenge: json['challenge'] as String?,
      domain: json['domain'] as String?,
      jws: json['jws'] as String?,
    );

Map<String, dynamic> _$$EidasProofImplToJson(_$EidasProofImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.created.toIso8601String(),
      'verificationMethod': instance.verificationMethod,
      'proofPurpose': instance.proofPurpose,
      'proofValue': instance.proofValue,
      'challenge': instance.challenge,
      'domain': instance.domain,
      'jws': instance.jws,
    };

_$EidasEvidenceImpl _$$EidasEvidenceImplFromJson(Map<String, dynamic> json) =>
    _$EidasEvidenceImpl(
      type: json['type'] as String,
      verifier: json['verifier'] as String,
      evidenceDocument: (json['evidenceDocument'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subjectPresence: json['subjectPresence'] as String?,
      documentPresence: json['documentPresence'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$EidasEvidenceImplToJson(_$EidasEvidenceImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'verifier': instance.verifier,
      'evidenceDocument': instance.evidenceDocument,
      'subjectPresence': instance.subjectPresence,
      'documentPresence': instance.documentPresence,
      'time': instance.time?.toIso8601String(),
    };
