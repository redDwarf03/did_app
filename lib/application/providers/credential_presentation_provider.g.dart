// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_presentation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$credentialPresentationNotifierHash() =>
    r'eaefc6b62f243901a06c8ba3be7cbbc47c6b6432';

/// Manages the state and orchestrates operations related to creating and verifying
/// Verifiable Presentations ([CredentialPresentation]).
///
/// Interacts with identity, credential, and qualification services.
///
/// Copied from [CredentialPresentationNotifier].
@ProviderFor(CredentialPresentationNotifier)
final credentialPresentationNotifierProvider = AutoDisposeNotifierProvider<
    CredentialPresentationNotifier, CredentialPresentationState>.internal(
  CredentialPresentationNotifier.new,
  name: r'credentialPresentationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$credentialPresentationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CredentialPresentationNotifier
    = AutoDisposeNotifier<CredentialPresentationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
