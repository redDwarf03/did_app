// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revocation_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevocationStatusImpl _$$RevocationStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$RevocationStatusImpl(
      isRevoked: json['isRevoked'] as bool,
      message: json['message'] as String,
      lastChecked: DateTime.parse(json['lastChecked'] as String),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$RevocationStatusImplToJson(
        _$RevocationStatusImpl instance) =>
    <String, dynamic>{
      'isRevoked': instance.isRevoked,
      'message': instance.message,
      'lastChecked': instance.lastChecked.toIso8601String(),
      'error': instance.error,
    };
