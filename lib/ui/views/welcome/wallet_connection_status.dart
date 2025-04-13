import 'dart:developer';
import 'package:did_app/application/session/provider.dart';
import 'package:did_app/application/session/state.dart';
import 'package:did_app/features/identity/domain/repositories/digital_identity_repository.dart';
import 'package:did_app/ui/widgets/account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart' as l10n;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:did_app/features/identity/data/repositories/awc_digital_identity_repository.dart';
import 'package:did_app/features/identity/domain/models/user_identity_details.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';

/// Widget displaying the current wallet connection status
class WalletConnectionStatus extends ConsumerWidget {
  const WalletConnectionStatus({super.key});

  // Define the service name constant
  static const String _dappServiceName = 'dapp_template';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use prefixed localization class
    final t = l10n.AppLocalizations.of(context)!;
    // Correct provider name confirmed by user
    final session = ref.watch(sessionNotifierProvider); // Use Session class

    // Display connection status based on Session.walletConnectionState
    return _buildConnectionStatus(context, session, t, ref);

    // Identity info will be shown in a dialog now
    /*
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildConnectionStatus(context, session, t, ref),
        if (session.isConnected)
          digitalIdentityRepoAsyncValue.when(
            loading: () => _buildLoadingIndicator(context, t),
            error: (error, stack) => _buildErrorWidget(context, error, t, ref),
            data: (repository) => _buildIdentityInfo(context, repository, t, ref),
          ),
      ],
    );
    */
  }

  // Updated to use Session and ArchethicDappConnectionState
  Widget _buildConnectionStatus(BuildContext context, Session session,
      l10n.AppLocalizations t, WidgetRef ref) {
    // Use session.walletConnectionState.maybeWhen or similar
    return session.walletConnectionState.maybeWhen(
      connected: () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show minimal info: account name/widget and an info button
          Flexible(
            // Allow AccountWidget to shrink if needed
            child: AccountWidget(), // Removed address/name params
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip:
                t.showIdentityDetails, // Add tooltip using localization key
            onPressed: () => _showIdentityDialog(context, ref, t),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: t.disconnect, // Use existing key if available, or add new
            onPressed: () => ref
                .read(sessionNotifierProvider.notifier)
                .cancelConnection(), // Use correct method
          ),
        ],
      ),
      disconnected: () => ElevatedButton(
        onPressed: () =>
            ref.read(sessionNotifierProvider.notifier).connectWallet(),
        child: Text(t.connectWallet),
      ),
      connecting: () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2)),
            const SizedBox(width: 8),
            Text(t.connecting), // Use existing key if available
          ],
        ),
      ),
      orElse: () => const SizedBox.shrink(), // Default empty state
    );
  }

  // --- Dialog Implementation ---

  void _showIdentityDialog(
      BuildContext context, WidgetRef ref, l10n.AppLocalizations t) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Use a specific widget for the dialog content
        return AlertDialog(
          title: Text(t.identityDetailsTitle), // Add localization key
          content: SizedBox(
            width: double.maxFinite, // Take available width
            child: _IdentityDialogContent(ref: ref, t: t), // Pass ref and t
          ),
          actions: [
            TextButton(
              child: Text(t.closeButton), // Add localization key
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
}

// --- New Widget for Dialog Content ---

class _IdentityDialogContent extends ConsumerWidget {
  final WidgetRef ref; // Receive ref
  final l10n.AppLocalizations t; // Receive t

  const _IdentityDialogContent({required this.ref, required this.t});

  @override
  Widget build(BuildContext context, WidgetRef _) {
    // Use local ref (_) if outer ref is sufficient
    final digitalIdentityRepoAsyncValue =
        ref.watch(digitalIdentityRepositoryProvider);

    return digitalIdentityRepoAsyncValue.when(
      loading: () => _buildLoadingIndicator(context, t),
      error: (error, stack) => _buildErrorWidget(context, error, t, ref),
      data: (repository) => _buildIdentityInfo(context, repository, t, ref),
    );
  }

  // --- Helper Methods (Copied and adapted from WalletConnectionStatus) ---
  // These can remain largely the same, just ensure they use the passed `t` and `ref`

  Widget _buildLoadingIndicator(BuildContext context, l10n.AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            t.loadingIdentity,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error,
      l10n.AppLocalizations t, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            t.errorLoadingIdentity,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(digitalIdentityRepositoryProvider);
            },
            child: Text(t.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityInfo(
      BuildContext context,
      DigitalIdentityRepository repository,
      l10n.AppLocalizations t,
      WidgetRef ref) {
    return StreamBuilder<UserIdentityDetails?>(
      stream: repository.watchCurrentUserIdentity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return _buildLoadingIndicator(context, t);
        }
        if (snapshot.hasError) {
          return _buildErrorWidget(context, snapshot.error!, t, ref);
        }
        final identityDetails = snapshot.data;
        if (identityDetails == null) {
          return _buildNoIdentityWidget(context, t);
        }
        return _buildIdentityDetails(context, identityDetails, repository, t);
      },
    );
  }

  Widget _buildNoIdentityWidget(BuildContext context, l10n.AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_off_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            t.noIdentityFound,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityDetails(
    BuildContext context,
    UserIdentityDetails details,
    DigitalIdentityRepository repository,
    l10n.AppLocalizations t,
  ) {
    return SingleChildScrollView(
      // Make dialog content scrollable if needed
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0), // Adjust padding for dialog
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.yourIdentity,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(context, t.didLabel, details.did),
            const SizedBox(height: 8),
            _buildDetailRow(context, t.selectedAddressLabel,
                details.selectedAddress ?? t.notAvailable),
            const Divider(height: 32),
            _buildServiceStatus(context, details, repository, t),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        SelectableText(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'monospace',
              ),
        ),
      ],
    );
  }

  Widget _buildServiceStatus(
    BuildContext context,
    UserIdentityDetails details,
    DigitalIdentityRepository repository,
    l10n.AppLocalizations t,
  ) {
    final bool isServiceInitialized = details.availableServices
        .contains(WalletConnectionStatus._dappServiceName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.serviceStatusFor(WalletConnectionStatus._dappServiceName),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(
              isServiceInitialized
                  ? Icons.check_circle_outline
                  : Icons.highlight_off,
              color: isServiceInitialized
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isServiceInitialized
                    ? t.serviceInitializedStatus
                    : t.serviceNotInitializedStatus,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isServiceInitialized
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          ],
        ),
        if (!isServiceInitialized) ...[
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_link),
              label: Text(t.initializeServiceButton),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(t.initializingService(
                          WalletConnectionStatus._dappServiceName))),
                );
                try {
                  final result = await repository.addDappService(
                      serviceName: WalletConnectionStatus._dappServiceName);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            t.serviceInitializationSuccess(result.serviceName)),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text(t.serviceInitializationError(e.toString())),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                  log('Error initializing service: $e'); // Now log should be defined
                }
              },
            ),
          ),
        ],
      ],
    );
  }
}
