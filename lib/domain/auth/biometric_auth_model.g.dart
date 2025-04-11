// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BiometricAuthStateImpl _$$BiometricAuthStateImplFromJson(
        Map<String, dynamic> json) =>
    _$BiometricAuthStateImpl(
      availableBiometrics: (json['availableBiometrics'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$BiometricTypeEnumMap, e))
              .toList() ??
          const [],
      currentBiometricType: $enumDecodeNullable(
              _$BiometricTypeEnumMap, json['currentBiometricType']) ??
          BiometricType.none,
      status: $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ??
          AuthStatus.notAuthenticated,
      errorMessage: json['errorMessage'] as String?,
      isBiometricEnabled: json['isBiometricEnabled'] as bool? ?? false,
      isTwoFactorEnabled: json['isTwoFactorEnabled'] as bool? ?? false,
      isPasswordlessEnabled: json['isPasswordlessEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$BiometricAuthStateImplToJson(
        _$BiometricAuthStateImpl instance) =>
    <String, dynamic>{
      'availableBiometrics': instance.availableBiometrics
          .map((e) => _$BiometricTypeEnumMap[e]!)
          .toList(),
      'currentBiometricType':
          _$BiometricTypeEnumMap[instance.currentBiometricType]!,
      'status': _$AuthStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'isBiometricEnabled': instance.isBiometricEnabled,
      'isTwoFactorEnabled': instance.isTwoFactorEnabled,
      'isPasswordlessEnabled': instance.isPasswordlessEnabled,
    };

const _$BiometricTypeEnumMap = {
  BiometricType.fingerprint: 'fingerprint',
  BiometricType.faceId: 'faceId',
  BiometricType.iris: 'iris',
  BiometricType.none: 'none',
};

const _$AuthStatusEnumMap = {
  AuthStatus.notAuthenticated: 'notAuthenticated',
  AuthStatus.authenticating: 'authenticating',
  AuthStatus.authenticated: 'authenticated',
  AuthStatus.failed: 'failed',
  AuthStatus.unavailable: 'unavailable',
  AuthStatus.notSetUp: 'notSetUp',
};
