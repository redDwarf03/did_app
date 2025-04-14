import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provider for the secure storage instance.
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  // Options can be configured here if needed (e.g., AndroidOptions, IOSOptions)
  return const FlutterSecureStorage();
});
