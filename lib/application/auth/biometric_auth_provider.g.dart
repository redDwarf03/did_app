// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$biometricAuthNotifierHash() =>
    r'24b8bb8728914ddf48214a89c59031a96db50c4f';

/// Provides the [BiometricAuthNotifier] and its state [BiometricAuthState].
///
/// This is the main provider to interact with for biometric authentication features
/// in the UI layer. It manages the overall state, including availability,
/// enabled status, and authentication results.
/// Manages the state and logic for biometric authentication within the application.
///
/// It interacts with the [BiometricAuthService] to check availability and perform
/// authentication, and updates the [BiometricAuthState] accordingly.
///
/// Copied from [BiometricAuthNotifier].
@ProviderFor(BiometricAuthNotifier)
final biometricAuthNotifierProvider =
    NotifierProvider<BiometricAuthNotifier, BiometricAuthState>.internal(
  BiometricAuthNotifier.new,
  name: r'biometricAuthNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$biometricAuthNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BiometricAuthNotifier = Notifier<BiometricAuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
