// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$credentialStatusNotifierHash() =>
    r'e8b2d09248b4d21bc670f6ab432c8407f6e0e5ba';

/// StateNotifier responsible for managing the credential status checking process.
///
/// It orchestrates status checks for single or multiple credentials,
/// handles refreshing status lists, manages the state ([CredentialStatusState]),
/// and provides helper methods related to credential validity and renewal.
///
/// Copied from [CredentialStatusNotifier].
@ProviderFor(CredentialStatusNotifier)
final credentialStatusNotifierProvider = AutoDisposeNotifierProvider<
    CredentialStatusNotifier, CredentialStatusState>.internal(
  CredentialStatusNotifier.new,
  name: r'credentialStatusNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$credentialStatusNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CredentialStatusNotifier = AutoDisposeNotifier<CredentialStatusState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
