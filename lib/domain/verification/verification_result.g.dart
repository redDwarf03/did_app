// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationResultImpl _$$VerificationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationResultImpl(
      isValid: json['isValid'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$VerificationResultImplToJson(
        _$VerificationResultImpl instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'message': instance.message,
    };
