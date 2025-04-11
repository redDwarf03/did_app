import 'dart:async';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:did_app/application/session/provider.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/ui/views/credential/credential_list_screen.dart';
import 'package:did_app/ui/views/document/document_detail_screen.dart';
import 'package:did_app/ui/views/document/document_list_screen.dart';
import 'package:did_app/ui/views/document/document_versions_screen.dart';
import 'package:did_app/ui/views/identity/create_identity_screen.dart';
import 'package:did_app/ui/views/identity/identity_details_screen.dart';
import 'package:did_app/ui/views/identity/identity_screen.dart';
import 'package:did_app/ui/views/main/main_screen.dart';
import 'package:did_app/ui/views/verification/certificate_details_screen.dart';
import 'package:did_app/ui/views/verification/certificate_renewal_screen.dart';
import 'package:did_app/ui/views/verification/certificates_dashboard_screen.dart';
import 'package:did_app/ui/views/verification/verification_screen.dart';
import 'package:did_app/ui/views/verification/verification_start_screen.dart';
import 'package:did_app/ui/views/verification/verification_success_screen.dart';
import 'package:did_app/ui/views/welcome/welcome_screen.dart';
import 'package:did_app/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:did_app/ui/views/verification/verification_process_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the service locator
  await setupServiceLocator();

  runApp(
    ProviderScope(
      observers: [
        aedappfm.ProvidersLogger(),
      ],
      child: const ProvidersInitialization(child: MyApp()),
    ),
  );
}

/// Eagerly initializes providers for app startup
class ProvidersInitialization extends ConsumerWidget {
  const ProvidersInitialization({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize session provider
    ref.watch(sessionNotifierProvider);
    return child;
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    // Optional: Start UCO price subscription if needed
    unawaited(
      ref
          .read(
            aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO.notifier,
          )
          .startSubscription(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Router configuration
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/identity',
          builder: (context, state) => const IdentityScreen(),
        ),
        GoRoute(
          path: '/identity/create',
          name: 'createIdentity',
          builder: (context, state) => const CreateIdentityScreen(),
        ),
        GoRoute(
          path: '/identity/:address',
          name: 'identityDetails',
          builder: (context, state) {
            final address = state.pathParameters['address']!;
            return IdentityDetailsScreen(address: address);
          },
        ),
        GoRoute(
          path: '/verification/certificates',
          builder: (context, state) => const CertificatesDashboardScreen(),
        ),
        GoRoute(
          path: '/verification/certificate/details',
          builder: (context, state) {
            final certificate = state.extra! as VerificationCertificate;
            return CertificateDetailsScreen(certificate: certificate);
          },
        ),
        GoRoute(
          path: '/verification/success',
          name: 'verificationSuccess',
          builder: (context, state) {
            final certificate = state.extra! as VerificationCertificate;
            return VerificationSuccessScreen(certificate: certificate);
          },
        ),
        GoRoute(
          path: '/verification/start',
          name: 'verificationStart',
          builder: (context, state) => const VerificationStartScreen(),
        ),
        GoRoute(
          path: '/verification/renew',
          name: 'verificationRenew',
          builder: (context, state) {
            final certificate = state.extra as VerificationCertificate?;
            return CertificateRenewalScreen(certificate: certificate);
          },
        ),
        GoRoute(
          path: '/verification/process',
          name: 'verificationProcess',
          builder: (context, state) => const VerificationScreen(),
        ),
        GoRoute(
          path: '/documents',
          name: 'documents',
          builder: (context, state) => const DocumentListScreen(),
        ),
        GoRoute(
          path: '/document/:id',
          builder: (context, state) {
            final documentId = state.pathParameters['id']!;
            return DocumentDetailScreen(documentId: documentId);
          },
        ),
        GoRoute(
          path: '/document/:id/versions',
          builder: (context, state) {
            final documentId = state.pathParameters['id']!;
            return DocumentVersionsScreen(documentId: documentId);
          },
        ),
        // Nouvelles routes pour les attestations (Verifiable Credentials)
        GoRoute(
          path: '/credentials',
          name: 'credentials',
          builder: (context, state) => const CredentialListScreen(),
        ),
        // Autres routes à ajouter au besoin
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Archethic Digital Identity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        aedappfm.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
