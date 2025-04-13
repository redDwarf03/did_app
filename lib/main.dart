import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:did_app/router/router.dart';
import 'package:did_app/ui/common/responsive_width_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Open Hive boxes
  await Hive.openBox<Map<dynamic, dynamic>>('revocation_history');
  await Hive.openBox<Map<dynamic, dynamic>>('status_list_cache');

  // Run the app
  runApp(
    ProviderScope(
      observers: [
        aedappfm.ProvidersLogger(),
      ],
      child: const ProvidersInitialization(child: MainApp()),
    ),
  );
}

/// Eagerly initializes providers (https://riverpod.dev/docs/essentials/eager_initialization).
///
/// Add Watch here for any provider you want to init when app is displayed.
/// Those providers will be kept alive during application lifetime.
class ProvidersInitialization extends ConsumerWidget {
  const ProvidersInitialization({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ResponsiveWidthContainer(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'DID App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          aedappfm.AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
