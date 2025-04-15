// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eidas_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EidasStateImpl _$$EidasStateImplFromJson(Map<String, dynamic> json) =>
    _$EidasStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
      isEudiWalletAvailable: json['isEudiWalletAvailable'] as bool? ?? false,
      verificationResult: json['verificationResult'] == null
          ? null
          : VerificationResult.fromJson(
              json['verificationResult'] as Map<String, dynamic>),
      revocationStatus: json['revocationStatus'] == null
          ? null
          : RevocationStatus.fromJson(
              json['revocationStatus'] as Map<String, dynamic>),
      lastSyncDate: json['lastSyncDate'] == null
          ? null
          : DateTime.parse(json['lastSyncDate'] as String),
      trustListReport: json['trustListReport'] as Map<String, dynamic>?,
      interoperabilityReport:
          json['interoperabilityReport'] as Map<String, dynamic>?,
      trustedIssuers: (json['trustedIssuers'] as List<dynamic>?)
              ?.map((e) => TrustedIssuer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedTrustLevel:
          $enumDecodeNullable(_$TrustLevelEnumMap, json['selectedTrustLevel']),
      selectedCountry: json['selectedCountry'] as String?,
    );

Map<String, dynamic> _$$EidasStateImplToJson(_$EidasStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'errorMessage': instance.errorMessage,
      'isEudiWalletAvailable': instance.isEudiWalletAvailable,
      'verificationResult': instance.verificationResult,
      'revocationStatus': instance.revocationStatus,
      'lastSyncDate': instance.lastSyncDate?.toIso8601String(),
      'trustListReport': instance.trustListReport,
      'interoperabilityReport': instance.interoperabilityReport,
      'trustedIssuers': instance.trustedIssuers,
      'selectedTrustLevel': _$TrustLevelEnumMap[instance.selectedTrustLevel],
      'selectedCountry': instance.selectedCountry,
    };

const _$TrustLevelEnumMap = {
  TrustLevel.low: 'low',
  TrustLevel.substantial: 'substantial',
  TrustLevel.high: 'high',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eidasNotifierHash() => r'd5ac15e3c89bf8705d9eb1a853cf5ee3b768f456';

/// Provider for the StateNotifier managing eIDAS-related state and logic.
///
/// Copied from [EidasNotifier].
@ProviderFor(EidasNotifier)
final eidasNotifierProvider =
    AutoDisposeNotifierProvider<EidasNotifier, EidasState>.internal(
  EidasNotifier.new,
  name: r'eidasNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eidasNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EidasNotifier = AutoDisposeNotifier<EidasState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
