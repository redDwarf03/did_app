import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

/// Setup the service locator for dependency injection
Future<void> setupServiceLocator() async {
  // Unregister LogManager if it's already registered
  if (aedappfm.sl.isRegistered<aedappfm.LogManager>()) {
    await aedappfm.sl.unregister<aedappfm.LogManager>();
  }

  // Register LogManager
  aedappfm.sl.registerLazySingleton<aedappfm.LogManager>(
    () => aedappfm.LogManager(url: ''),
  );

  // Add other services as needed
}
