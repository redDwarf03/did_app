import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/ui/views/verification/verification_process_screen.dart';
import 'package:did_app/ui/views/verification/verification_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Main screen for identity verification
class VerificationScreen extends ConsumerWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identityState = ref.watch(identityNotifierProvider);
    final verificationState = ref.watch(verificationNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    // Show loading spinner while either identity or verification is loading
    if (identityState.isLoading || verificationState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show error if there's an identity error
    if (identityState.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.identityErrorTitle),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.identityErrorTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  identityState.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(identityNotifierProvider.notifier)
                        .refreshIdentity();
                  },
                  child: Text(l10n.retryButtonVerification),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show error if there's a verification error
    if (verificationState.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.verificationErrorTitle),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.verificationErrorTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  verificationState.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (identityState.identity != null) {
                      ref
                          .read(verificationNotifierProvider.notifier)
                          .loadVerification(
                            identityState.identity!.identityAddress,
                          );
                    }
                  },
                  child: Text(l10n.retryButtonVerification),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Check if the user has an identity
    if (identityState.identity == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.identityVerificationTitle),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.blueGrey,
                  size: 80,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Create an Identity First',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'You need to create a digital identity before you can verify it. Please go to the Identity section and create your identity first.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.goBackButton),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Check if there's a verification process already
    if (verificationState.verificationProcess != null) {
      // Check if the verification is completed
      if (verificationState.isVerificationCompleted) {
        return VerificationSuccessScreen(
          certificate: verificationState.certificate!,
        );
      } else {
        // Show the verification process
        return VerificationProcessScreen(
          verificationProcess: verificationState.verificationProcess!,
        );
      }
    }

    // No verification process yet, show the start screen
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.identityVerificationTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                color: Colors.blue,
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.verifyYourIdentityTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.verifyYourIdentityDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'The verification process includes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildVerificationStep(
                context,
                l10n.verificationStepEmailPhone,
                Icons.phone_android,
              ),
              _buildVerificationStep(
                context,
                l10n.verificationStepIdDocument,
                Icons.badge,
              ),
              _buildVerificationStep(
                context,
                l10n.verificationStepAddressProof,
                Icons.home,
              ),
              _buildVerificationStep(
                context,
                l10n.verificationStepLiveness,
                Icons.face,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  _startVerificationProcess(context, ref);
                },
                icon: const Icon(Icons.verified_user),
                label: Text(l10n.startVerificationButtonMain),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a verification step item
  Widget _buildVerificationStep(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Start the verification process
  void _startVerificationProcess(BuildContext context, WidgetRef ref) {
    final identity = ref.read(identityNotifierProvider).identity!;
    ref
        .read(verificationNotifierProvider.notifier)
        .startVerification(identity.identityAddress);
  }
}
