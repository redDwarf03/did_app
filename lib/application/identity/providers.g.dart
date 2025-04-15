// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$identityNotifierHash() => r'8619083607de5eacc99e55154a08a2b65edea60e';

/// Provides the [IdentityNotifier] instance to the application.
///
/// This StateNotifierProvider allows widgets to listen to changes in the [IdentityState]
/// and access the [IdentityNotifier] to trigger identity-related actions.
/// Manages the state ([IdentityState]) and orchestrates operations related to
/// the user's core digital identity profile ([DigitalIdentity]).
///
/// This StateNotifier acts as the primary interface for the UI layer to interact
/// with identity management features. It uses the [IdentityRepository] provided
/// by [identityRepositoryProvider] to perform actions like checking for an existing
/// identity, creating a new one, updating it, and refreshing the data.
///
/// Copied from [IdentityNotifier].
@ProviderFor(IdentityNotifier)
final identityNotifierProvider =
    NotifierProvider<IdentityNotifier, IdentityState>.internal(
  IdentityNotifier.new,
  name: r'identityNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$identityNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IdentityNotifier = Notifier<IdentityState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
