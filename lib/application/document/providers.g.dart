// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentNotifierHash() => r'21efb75d35a564df37098b70dcc524170ac76fdf';

/// Provider for the [DocumentNotifier] which manages the [DocumentState].
/// Manages the state and orchestrates operations related to user documents.
///
/// Interacts with the [DocumentRepository] to load, add, update, delete,
/// share, and manage document versions and access.
///
/// Copied from [DocumentNotifier].
@ProviderFor(DocumentNotifier)
final documentNotifierProvider =
    AutoDisposeNotifierProvider<DocumentNotifier, DocumentState>.internal(
  DocumentNotifier.new,
  name: r'documentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$documentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DocumentNotifier = AutoDisposeNotifier<DocumentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
