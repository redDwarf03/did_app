import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:did_app/application/session/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service.g.dart';

/// Provider for Archethic API service
/// This service allows interaction with the Archethic blockchain
@riverpod
ApiService apiService(Ref ref) {
  final environment = ref.watch(environmentProvider);
  return ref.watch(aedappfm.apiServiceProvider(environment));
}
