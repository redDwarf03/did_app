// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verificationNotifierHash() =>
    r'6c7a3cd23c8ae604e29ca9212bb1fc001c3e2283';

/// Interacts with the [VerificationRepository] to load, start, and progress
/// through verification steps.
///
/// Copied from [VerificationNotifier].
@ProviderFor(VerificationNotifier)
final verificationNotifierProvider = AutoDisposeNotifierProvider<
    VerificationNotifier, VerificationState>.internal(
  VerificationNotifier.new,
  name: r'verificationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verificationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VerificationNotifier = AutoDisposeNotifier<VerificationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
