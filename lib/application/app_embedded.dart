import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_embedded.g.dart';

/// Provider to check if app is embedded in another application
/// This is determined by checking if URL contains 'isEmbedded' query parameter
@Riverpod(keepAlive: true)
bool isAppEmbedded(Ref ref) {
  return Uri.base.queryParameters.containsKey('isEmbedded');
}
