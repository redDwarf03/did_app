// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationProcessImpl _$$VerificationProcessImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationProcessImpl(
      id: json['id'] as String,
      identityAddress: json['identityAddress'] as String,
      status: $enumDecode(_$VerificationStatusEnumMap, json['status']),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => VerificationStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      certificate: json['certificate'] == null
          ? null
          : VerificationCertificate.fromJson(
              json['certificate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VerificationProcessImplToJson(
        _$VerificationProcessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identityAddress': instance.identityAddress,
      'status': _$VerificationStatusEnumMap[instance.status]!,
      'steps': instance.steps,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'completedAt': instance.completedAt?.toIso8601String(),
      'certificate': instance.certificate,
    };

const _$VerificationStatusEnumMap = {
  VerificationStatus.notStarted: 'notStarted',
  VerificationStatus.inProgress: 'inProgress',
  VerificationStatus.pendingReview: 'pendingReview',
  VerificationStatus.completed: 'completed',
  VerificationStatus.rejected: 'rejected',
  VerificationStatus.expired: 'expired',
};

_$VerificationStepImpl _$$VerificationStepImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationStepImpl(
      id: json['id'] as String,
      type: $enumDecode(_$VerificationStepTypeEnumMap, json['type']),
      status: $enumDecode(_$VerificationStepStatusEnumMap, json['status']),
      order: (json['order'] as num).toInt(),
      description: json['description'] as String,
      instructions: json['instructions'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      documentPaths: (json['documentPaths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$VerificationStepImplToJson(
        _$VerificationStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$VerificationStepTypeEnumMap[instance.type]!,
      'status': _$VerificationStepStatusEnumMap[instance.status]!,
      'order': instance.order,
      'description': instance.description,
      'instructions': instance.instructions,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'documentPaths': instance.documentPaths,
    };

const _$VerificationStepTypeEnumMap = {
  VerificationStepType.emailVerification: 'emailVerification',
  VerificationStepType.phoneVerification: 'phoneVerification',
  VerificationStepType.idDocumentVerification: 'idDocumentVerification',
  VerificationStepType.addressVerification: 'addressVerification',
  VerificationStepType.livenessCheck: 'livenessCheck',
  VerificationStepType.biometricVerification: 'biometricVerification',
  VerificationStepType.additionalDocuments: 'additionalDocuments',
};

const _$VerificationStepStatusEnumMap = {
  VerificationStepStatus.notStarted: 'notStarted',
  VerificationStepStatus.inProgress: 'inProgress',
  VerificationStepStatus.completed: 'completed',
  VerificationStepStatus.rejected: 'rejected',
  VerificationStepStatus.actionRequired: 'actionRequired',
};

_$VerificationCertificateImpl _$$VerificationCertificateImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationCertificateImpl(
      id: json['id'] as String,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      issuer: json['issuer'] as String,
      signature: json['signature'] as String,
      eidasLevel:
          $enumDecodeNullable(_$EidasLevelEnumMap, json['eidasLevel']) ??
              EidasLevel.low,
    );

Map<String, dynamic> _$$VerificationCertificateImplToJson(
        _$VerificationCertificateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'issuer': instance.issuer,
      'signature': instance.signature,
      'eidasLevel': _$EidasLevelEnumMap[instance.eidasLevel]!,
    };

const _$EidasLevelEnumMap = {
  EidasLevel.low: 'low',
  EidasLevel.substantial: 'substantial',
  EidasLevel.high: 'high',
};
