// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$credentialNotifierHash() =>
    r'e1c843f86976b960315067a52cbf6975cddd3dd5';

/// Provider for the StateNotifier that manages W3C Credentials.
/// StateNotifier for managing W3C Verifiable Credentials and Presentations.
/// Interacts with the [CredentialRepository] to perform CRUD operations
/// and presentation creation.
///
/// Copied from [CredentialNotifier].
@ProviderFor(CredentialNotifier)
final credentialNotifierProvider =
    NotifierProvider<CredentialNotifier, CredentialState>.internal(
  CredentialNotifier.new,
  name: r'credentialNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$credentialNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CredentialNotifier = Notifier<CredentialState>;
String _$simplifiedCredentialsNotifierHash() =>
    r'a3851759e21c605c13caa954db7b6077d49efd41';

/// Notifier class for simplified credential operations.
/// Manages the state of internal, simplified credentials.
///
/// Copied from [SimplifiedCredentialsNotifier].
@ProviderFor(SimplifiedCredentialsNotifier)
final simplifiedCredentialsNotifierProvider = AutoDisposeNotifierProvider<
    SimplifiedCredentialsNotifier, SimplifiedCredentialsState>.internal(
  SimplifiedCredentialsNotifier.new,
  name: r'simplifiedCredentialsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$simplifiedCredentialsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SimplifiedCredentialsNotifier
    = AutoDisposeNotifier<SimplifiedCredentialsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
