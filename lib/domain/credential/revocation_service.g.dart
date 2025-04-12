// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revocation_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevocationResultImpl _$$RevocationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$RevocationResultImpl(
      credentialId: json['credentialId'] as String,
      success: json['success'] as bool,
      errorMessage: json['errorMessage'] as String?,
      details: json['details'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$RevocationResultImplToJson(
        _$RevocationResultImpl instance) =>
    <String, dynamic>{
      'credentialId': instance.credentialId,
      'success': instance.success,
      'errorMessage': instance.errorMessage,
      'details': instance.details,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$RevocationHistoryEntryImpl _$$RevocationHistoryEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$RevocationHistoryEntryImpl(
      credentialId: json['credentialId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      action: $enumDecode(_$RevocationActionEnumMap, json['action']),
      reason: $enumDecodeNullable(_$RevocationReasonEnumMap, json['reason']),
      details: json['details'] as String?,
      actor: json['actor'] as String,
    );

Map<String, dynamic> _$$RevocationHistoryEntryImplToJson(
        _$RevocationHistoryEntryImpl instance) =>
    <String, dynamic>{
      'credentialId': instance.credentialId,
      'timestamp': instance.timestamp.toIso8601String(),
      'action': _$RevocationActionEnumMap[instance.action]!,
      'reason': _$RevocationReasonEnumMap[instance.reason],
      'details': instance.details,
      'actor': instance.actor,
    };

const _$RevocationActionEnumMap = {
  RevocationAction.revoke: 'revoke',
  RevocationAction.unrevoke: 'unrevoke',
};

const _$RevocationReasonEnumMap = {
  RevocationReason.compromised: 'compromised',
  RevocationReason.superseded: 'superseded',
  RevocationReason.noLongerValid: 'noLongerValid',
  RevocationReason.issuerRevoked: 'issuerRevoked',
  RevocationReason.other: 'other',
};
