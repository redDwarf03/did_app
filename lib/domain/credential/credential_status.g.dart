// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CredentialStatusImpl _$$CredentialStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialStatusImpl(
      credentialId: json['credentialId'] as String,
      status: $enumDecode(_$CredentialStatusTypeEnumMap, json['status']),
      lastChecked: DateTime.parse(json['lastChecked'] as String),
      revokedAt: json['revokedAt'] == null
          ? null
          : DateTime.parse(json['revokedAt'] as String),
      revocationReason: $enumDecodeNullable(
          _$RevocationReasonEnumMap, json['revocationReason']),
      revocationDetails: json['revocationDetails'] as String?,
      statusListUrl: json['statusListUrl'] as String,
      statusListIndex: (json['statusListIndex'] as num).toInt(),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      nextCheck: DateTime.parse(json['nextCheck'] as String),
    );

Map<String, dynamic> _$$CredentialStatusImplToJson(
        _$CredentialStatusImpl instance) =>
    <String, dynamic>{
      'credentialId': instance.credentialId,
      'status': _$CredentialStatusTypeEnumMap[instance.status]!,
      'lastChecked': instance.lastChecked.toIso8601String(),
      'revokedAt': instance.revokedAt?.toIso8601String(),
      'revocationReason': _$RevocationReasonEnumMap[instance.revocationReason],
      'revocationDetails': instance.revocationDetails,
      'statusListUrl': instance.statusListUrl,
      'statusListIndex': instance.statusListIndex,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'nextCheck': instance.nextCheck.toIso8601String(),
    };

const _$CredentialStatusTypeEnumMap = {
  CredentialStatusType.valid: 'valid',
  CredentialStatusType.revoked: 'revoked',
  CredentialStatusType.expired: 'expired',
  CredentialStatusType.unknown: 'unknown',
};

const _$RevocationReasonEnumMap = {
  RevocationReason.compromised: 'compromised',
  RevocationReason.superseded: 'superseded',
  RevocationReason.noLongerValid: 'noLongerValid',
  RevocationReason.issuerRevoked: 'issuerRevoked',
  RevocationReason.other: 'other',
};

_$StatusListImpl _$$StatusListImplFromJson(Map<String, dynamic> json) =>
    _$StatusListImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      statuses: (json['statuses'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as bool),
      ),
      size: (json['size'] as num).toInt(),
      version: json['version'] as String,
    );

Map<String, dynamic> _$$StatusListImplToJson(_$StatusListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'statuses': instance.statuses.map((k, e) => MapEntry(k.toString(), e)),
      'size': instance.size,
      'version': instance.version,
    };

_$StatusCheckResultImpl _$$StatusCheckResultImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusCheckResultImpl(
      credentialId: json['credentialId'] as String,
      status: $enumDecode(_$CredentialStatusTypeEnumMap, json['status']),
      checkedAt: DateTime.parse(json['checkedAt'] as String),
      details: json['details'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$StatusCheckResultImplToJson(
        _$StatusCheckResultImpl instance) =>
    <String, dynamic>{
      'credentialId': instance.credentialId,
      'status': _$CredentialStatusTypeEnumMap[instance.status]!,
      'checkedAt': instance.checkedAt.toIso8601String(),
      'details': instance.details,
      'error': instance.error,
    };
