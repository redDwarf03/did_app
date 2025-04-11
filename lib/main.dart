import 'dart:async';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:did_app/application/session/provider.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/ui/common/responsive_width_container.dart';
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
import 'package:did_app/ui/views/auth/login_screen.dart';
import 'package:did_app/ui/views/auth/secure_auth_screen.dart';
import 'package:did_app/ui/views/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:did_app/ui/views/credential/status_list_dashboard_screen.dart';
import 'package:did_app/ui/views/credential/credential_status_verification_screen.dart';
import 'package:did_app/ui/views/credential/status_list_info_screen.dart';

void main() async {
  // Initialize app-wide services
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Open Hive boxes
  await Hive.openBox<Map<dynamic, dynamic>>('revocation_history');
  await Hive.openBox<Map<dynamic, dynamic>>('status_list_cache');

  // Run the app
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

    return ResponsiveWidthContainer(
      child: MaterialApp.router(
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
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/secure_auth',
              builder: (context, state) => const SecureAuthScreen(),
            ),
            GoRoute(
              path: '/status_list/dashboard',
              builder: (context, state) => const StatusListDashboardScreen(),
            ),
            GoRoute(
              path: '/status_list/info',
              builder: (context, state) => const StatusList2021InfoScreen(),
            ),
            GoRoute(
              path: '/credential/verify/:credentialId',
              builder: (context, state) => CredentialStatusVerificationScreen(
                credentialId: state.pathParameters['credentialId']!,
              ),
            ),
            ShellRoute(
              builder: (context, state, child) {
                return MainScreen(child: child);
              },
              routes: [
                GoRoute(
                  path: '/main',
                  builder: (context, state) => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          size: 80,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'DID Wallet',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Votre portefeuille d\'identité numérique',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GoRoute(
                  path: '/main/identity',
                  builder: (context, state) => const IdentityScreen(),
                  routes: [
                    GoRoute(
                      path: 'createIdentity',
                      name: 'createIdentity',
                      builder: (context, state) => const CreateIdentityScreen(),
                    ),
                    GoRoute(
                      path: 'identityDetails/:address',
                      name: 'identityDetails',
                      builder: (context, state) => IdentityDetailsScreen(
                        address: state.pathParameters['address'],
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: '/main/verification',
                  name: 'verification',
                  builder: (context, state) => const VerificationScreen(),
                  routes: [
                    GoRoute(
                      path: 'start',
                      name: 'verificationStart',
                      builder: (context, state) =>
                          const VerificationStartScreen(),
                    ),
                    GoRoute(
                      path: 'process/:processIdentifier',
                      name: 'verificationProcess',
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
                  path: '/main/documents',
                  name: 'documents',
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
                  path: '/main/credential',
                  builder: (context, state) => const CredentialListScreen(),
                  routes: [
                    GoRoute(
                      path: 'detail/:credentialId',
                      builder: (context, state) =>
                          credential_detail.CredentialDetailScreen(
                        credentialId: state.pathParameters['credentialId']!,
                      ),
                    ),
                    GoRoute(
                      path: 'verify/:credentialId',
                      builder: (context, state) =>
                          CredentialStatusVerificationScreen(
                        credentialId: state.pathParameters['credentialId']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void loadDefaultProvidersData(WidgetRef ref) {
  ref.read(identityNotifierProvider.notifier).refreshIdentity();
  ref.read(documentNotifierProvider.notifier).loadDocuments('all');
  ref.read(credentialNotifierProvider.notifier).loadCredentials();
}
