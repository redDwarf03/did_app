import 'package:did_app/application/session/provider.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/ui/views/auth/login_screen.dart';
import 'package:did_app/ui/views/auth/secure_auth_screen.dart';
import 'package:did_app/ui/views/credential/credential_detail_screen.dart'
    as credential_detail;
import 'package:did_app/ui/views/credential/credential_list_screen.dart';
import 'package:did_app/ui/views/credential/credential_status_verification_screen.dart';
import 'package:did_app/ui/views/credential/status_list_dashboard_screen.dart';
import 'package:did_app/ui/views/credential/status_list_info_screen.dart';
import 'package:did_app/ui/views/document/document_detail_screen.dart';
import 'package:did_app/ui/views/document/document_list_screen.dart';
import 'package:did_app/ui/views/document/document_versions_screen.dart';
import 'package:did_app/ui/views/home_screen.dart';
import 'package:did_app/ui/views/identity/create_identity_screen.dart';
import 'package:did_app/ui/views/identity/identity_details_screen.dart';
import 'package:did_app/ui/views/identity/identity_screen.dart';
import 'package:did_app/ui/views/main/main_screen.dart';
import 'package:did_app/ui/views/splash_screen.dart';
import 'package:did_app/ui/views/verification/certificate_details_screen.dart';
import 'package:did_app/ui/views/verification/certificate_renewal_screen.dart';
import 'package:did_app/ui/views/verification/certificates_dashboard_screen.dart';
import 'package:did_app/ui/views/verification/verification_process_screen.dart';
import 'package:did_app/ui/views/verification/verification_screen.dart';
import 'package:did_app/ui/views/verification/verification_start_screen.dart';
import 'package:did_app/ui/views/verification/verification_success_screen.dart';
import 'package:did_app/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
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
          path: SplashScreen.routerPage,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: WelcomeScreen.routerPage,
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
              builder: (context, state) => const IdentityScreen(),
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
                  builder: (context, state) => const VerificationStartScreen(),
                ),
                GoRoute(
                  path: 'process/:processIdentifier',
                  name: 'verificationProcess',
                  builder: (context, state) {
                    final verificationProcess =
                        state.extra as VerificationProcess?;
                    if (verificationProcess == null) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Error')),
                        body: const Center(
                          child: Text('Verification process data not found.'),
                        ),
                      );
                    }
                    return VerificationProcessScreen(
                      verificationProcess: verificationProcess,
                    );
                  },
                ),
                GoRoute(
                  path: 'success',
                  builder: (context, state) => VerificationSuccessScreen(
                    certificate: VerificationCertificate(
                      id: 'sample-id',
                      issuer: 'Sample Authority',
                      issuedAt: DateTime.now(),
                      expiresAt: DateTime.now().add(const Duration(days: 365)),
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
    );
  },
);

extension ContextRouteExtension on BuildContext {
  void popOrGo(String routerPage) {
    if (canPop()) {
      pop();
    } else {
      go(routerPage);
    }
  }
}
