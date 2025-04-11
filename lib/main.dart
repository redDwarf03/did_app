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
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/application/session/provider.dart';
import 'package:did_app/ui/views/credential/credential_detail_screen.dart'
    as credential_detail;
import 'package:did_app/ui/views/credential/eidas_interop_screen.dart';
import 'package:did_app/ui/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize providers
    loadDefaultProvidersData(ref);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: '/',
        redirect: (context, state) {
          final sessionState = ref.read(sessionNotifierProvider);
          if (state.uri.path != '/welcome' &&
              state.uri.path != '/' &&
              !sessionState.isConnected) {
            return '/welcome';
          }
          if (state.uri.path == '/welcome' && sessionState.isConnected) {
            return '/main';
          }
          return null;
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: '/welcome',
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
            path: '/main',
            builder: (context, state) => const MainScreen(),
            routes: [
              GoRoute(
                path: 'identity',
                builder: (context, state) => const IdentityScreen(),
                routes: [
                  GoRoute(
                    path: 'createIdentity',
                    builder: (context, state) => const CreateIdentityScreen(),
                  ),
                  GoRoute(
                    path: 'identityDetails',
                    builder: (context, state) => IdentityDetailsScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: 'verification',
                builder: (context, state) => const VerificationScreen(),
                routes: [
                  GoRoute(
                    path: 'start',
                    builder: (context, state) =>
                        const VerificationStartScreen(),
                  ),
                  GoRoute(
                    path: 'process/:processIdentifier',
                    builder: (context, state) => VerificationProcessScreen(
                      verificationProcess: VerificationProcess.fromJson(
                        state.uri.queryParameters,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'success',
                    builder: (context, state) => VerificationSuccessScreen(
                      certificate: VerificationCertificate(
                        id: 'sample-id',
                        issuer: 'Sample Authority',
                        issuedAt: DateTime.now(),
                        expiresAt:
                            DateTime.now().add(const Duration(days: 365)),
                        eidasLevel: EidasLevel.substantial,
                        signature: 'sample-signature',
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'dashboard',
                    builder: (context, state) =>
                        const CertificatesDashboardScreen(),
                  ),
                  GoRoute(
                    path: 'certificate-display',
                    builder: (context, state) {
                      return CertificateDetailsScreen(
                        certificate: VerificationCertificate(
                          id: 'sample-id',
                          issuer: 'Sample Authority',
                          issuedAt: DateTime.now(),
                          expiresAt:
                              DateTime.now().add(const Duration(days: 365)),
                          eidasLevel: EidasLevel.substantial,
                          signature: 'sample-signature',
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'certificate/renewal',
                    builder: (context, state) {
                      return CertificateRenewalScreen(
                        certificate: VerificationCertificate(
                          id: 'sample-id',
                          issuer: 'Sample Authority',
                          issuedAt: DateTime.now(),
                          expiresAt:
                              DateTime.now().add(const Duration(days: 365)),
                          eidasLevel: EidasLevel.substantial,
                          signature: 'sample-signature',
                        ),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'documents',
                builder: (context, state) => const DocumentListScreen(),
                routes: [
                  GoRoute(
                    path: 'detail/:documentId',
                    builder: (context, state) => DocumentDetailScreen(
                      documentId: state.pathParameters['documentId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'versions/:documentId',
                    builder: (context, state) => DocumentVersionsScreen(
                      documentId: state.pathParameters['documentId']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'credentials',
                builder: (context, state) => const CredentialListScreen(),
                routes: [
                  GoRoute(
                    path: 'detail/:credentialId',
                    builder: (context, state) {
                      final id = state.pathParameters['credentialId']!;
                      return credential_detail.CredentialDetailScreen(
                        credentialId: id,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'eidas',
                    builder: (context, state) => const EidasInteropScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void loadDefaultProvidersData(WidgetRef ref) {
  ref.read(identityNotifierProvider.notifier).refreshIdentity();
  ref.read(documentNotifierProvider.notifier).loadDocuments('all');
  ref.read(credentialNotifierProvider.notifier).loadCredentials();
}
