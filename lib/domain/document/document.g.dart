// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      id: json['id'] as String,
      type: $enumDecode(_$DocumentTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String?,
      issuer: json['issuer'] as String,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      version: (json['version'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      verificationStatus: $enumDecode(
          _$DocumentVerificationStatusEnumMap, json['verificationStatus']),
      encryptedStoragePath: json['encryptedStoragePath'] as String,
      documentHash: json['documentHash'] as String,
      encryptionIV: json['encryptionIV'] as String,
      issuerSignature: json['issuerSignature'] as String?,
      issuerAddress: json['issuerAddress'] as String?,
      blockchainTxId: json['blockchainTxId'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      ownerIdentityId: json['ownerIdentityId'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isShareable: json['isShareable'] as bool? ?? false,
      eidasLevel:
          $enumDecodeNullable(_$EidasLevelEnumMap, json['eidasLevel']) ??
              EidasLevel.low,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$DocumentTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'issuer': instance.issuer,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'version': instance.version,
      'metadata': instance.metadata,
      'verificationStatus':
          _$DocumentVerificationStatusEnumMap[instance.verificationStatus]!,
      'encryptedStoragePath': instance.encryptedStoragePath,
      'documentHash': instance.documentHash,
      'encryptionIV': instance.encryptionIV,
      'issuerSignature': instance.issuerSignature,
      'issuerAddress': instance.issuerAddress,
      'blockchainTxId': instance.blockchainTxId,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'ownerIdentityId': instance.ownerIdentityId,
      'tags': instance.tags,
      'isShareable': instance.isShareable,
      'eidasLevel': _$EidasLevelEnumMap[instance.eidasLevel]!,
    };

const _$DocumentTypeEnumMap = {
  DocumentType.nationalId: 'nationalId',
  DocumentType.passport: 'passport',
  DocumentType.drivingLicense: 'drivingLicense',
  DocumentType.diploma: 'diploma',
  DocumentType.certificate: 'certificate',
  DocumentType.addressProof: 'addressProof',
  DocumentType.bankDocument: 'bankDocument',
  DocumentType.medicalRecord: 'medicalRecord',
  DocumentType.corporateDocument: 'corporateDocument',
  DocumentType.other: 'other',
};

const _$DocumentVerificationStatusEnumMap = {
  DocumentVerificationStatus.unverified: 'unverified',
  DocumentVerificationStatus.pending: 'pending',
  DocumentVerificationStatus.verified: 'verified',
  DocumentVerificationStatus.rejected: 'rejected',
  DocumentVerificationStatus.expired: 'expired',
};

const _$EidasLevelEnumMap = {
  EidasLevel.low: 'low',
  EidasLevel.substantial: 'substantial',
  EidasLevel.high: 'high',
};

_$DocumentVersionImpl _$$DocumentVersionImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentVersionImpl(
      id: json['id'] as String,
      versionNumber: (json['versionNumber'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      documentHash: json['documentHash'] as String,
      encryptedStoragePath: json['encryptedStoragePath'] as String,
      encryptionIV: json['encryptionIV'] as String,
      blockchainTxId: json['blockchainTxId'] as String?,
      changeNote: json['changeNote'] as String?,
    );

Map<String, dynamic> _$$DocumentVersionImplToJson(
        _$DocumentVersionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'versionNumber': instance.versionNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'documentHash': instance.documentHash,
      'encryptedStoragePath': instance.encryptedStoragePath,
      'encryptionIV': instance.encryptionIV,
      'blockchainTxId': instance.blockchainTxId,
      'changeNote': instance.changeNote,
    };

_$DocumentShareImpl _$$DocumentShareImplFromJson(Map<String, dynamic> json) =>
    _$DocumentShareImpl(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      documentTitle: json['documentTitle'] as String,
      recipientId: json['recipientId'] as String?,
      recipientDescription: json['recipientDescription'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      shareUrl: json['shareUrl'] as String,
      accessCode: json['accessCode'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      maxAccessCount: (json['maxAccessCount'] as num?)?.toInt(),
      accessCount: (json['accessCount'] as num?)?.toInt() ?? 0,
      accessType:
          $enumDecode(_$DocumentShareAccessTypeEnumMap, json['accessType']),
      lastAccessedAt: json['lastAccessedAt'] == null
          ? null
          : DateTime.parse(json['lastAccessedAt'] as String),
    );

Map<String, dynamic> _$$DocumentShareImplToJson(_$DocumentShareImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'documentTitle': instance.documentTitle,
      'recipientId': instance.recipientId,
      'recipientDescription': instance.recipientDescription,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'shareUrl': instance.shareUrl,
      'accessCode': instance.accessCode,
      'isActive': instance.isActive,
      'maxAccessCount': instance.maxAccessCount,
      'accessCount': instance.accessCount,
      'accessType': _$DocumentShareAccessTypeEnumMap[instance.accessType]!,
      'lastAccessedAt': instance.lastAccessedAt?.toIso8601String(),
    };

const _$DocumentShareAccessTypeEnumMap = {
  DocumentShareAccessType.readOnly: 'readOnly',
  DocumentShareAccessType.download: 'download',
  DocumentShareAccessType.verify: 'verify',
  DocumentShareAccessType.fullAccess: 'fullAccess',
};
