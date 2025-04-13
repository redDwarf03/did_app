import 'dart:developer';

import 'package:did_app/application/session/provider.dart';
import 'package:did_app/features/identity/data/repositories/awc_digital_identity_repository.dart';
import 'package:did_app/features/identity/domain/models/user_identity_details.dart';
import 'package:did_app/features/identity/domain/repositories/digital_identity_repository.dart';
import 'package:did_app/ui/widgets/account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget displaying the current wallet connection status
class WalletConnectionStatus extends ConsumerWidget {
  const WalletConnectionStatus({super.key});

  // Define the service name constant
  static const String _dappServiceName = 'dapp_template';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildConnectionStatus(context, ref);
  }

  Widget _buildConnectionStatus(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    return session.walletConnectionState.maybeWhen(
      connected: () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: AccountWidget(),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: localizations.showIdentityDetails,
            onPressed: () => _showIdentityDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: localizations.disconnect,
            onPressed: () =>
                ref.read(sessionNotifierProvider.notifier).cancelConnection(),
          ),
        ],
      ),
      disconnected: () => ElevatedButton(
        onPressed: () =>
            ref.read(sessionNotifierProvider.notifier).connectWallet(),
        child: Text(localizations.connectWallet),
      ),
      connecting: () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            Text(localizations.connecting),
          ],
        ),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }

  void _showIdentityDialog(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizations.identityDetailsTitle),
          content: const SizedBox(
            width: double.maxFinite,
            child: _IdentityDialogContent(),
          ),
          actions: [
            TextButton(
              child: Text(localizations.closeButton),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _IdentityDialogContent extends ConsumerWidget {
  const _IdentityDialogContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final digitalIdentityRepoAsyncValue =
        ref.watch(digitalIdentityRepositoryProvider);

    return digitalIdentityRepoAsyncValue.when(
      loading: () => _buildLoadingIndicator(context),
      error: (error, stack) => _buildErrorWidget(context, error, ref),
      data: (repository) => _buildIdentityInfo(context, repository, ref),
    );
  }

  Widget _buildLoadingIndicator(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(strokeWidth: 1),
          const SizedBox(height: 16),
          Text(
            localizations.loadingIdentity,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(
    BuildContext context,
    Object error,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
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
            localizations.errorLoadingIdentity,
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
            child: Text(localizations.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityInfo(
    BuildContext context,
    DigitalIdentityRepository repository,
    WidgetRef ref,
  ) {
    return StreamBuilder<UserIdentityDetails?>(
      stream: repository.watchCurrentUserIdentity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return _buildLoadingIndicator(context);
        }
        if (snapshot.hasError) {
          return _buildErrorWidget(context, snapshot.error!, ref);
        }
        final identityDetails = snapshot.data;
        if (identityDetails == null) {
          return _buildNoIdentityWidget(
            context,
          );
        }
        return _buildIdentityDetails(context, identityDetails, repository);
      },
    );
  }

  Widget _buildNoIdentityWidget(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
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
            localizations.noIdentityFound,
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
  ) {
    final localizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.yourIdentity,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(context, localizations.didLabel, details.did),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              localizations.selectedAddressLabel,
              details.selectedAddress ?? localizations.notAvailable,
            ),
            const Divider(height: 32),
            _buildServiceStatus(context, details, repository),
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
  ) {
    final localizations = AppLocalizations.of(context)!;
    final isServiceInitialized = details.availableServices
        .contains(WalletConnectionStatus._dappServiceName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          localizations
              .serviceStatusFor(WalletConnectionStatus._dappServiceName),
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
                    ? localizations.serviceInitializedStatus
                    : localizations.serviceNotInitializedStatus,
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
              label: Text(localizations.initializeServiceButton),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      localizations.initializingService(
                        WalletConnectionStatus._dappServiceName,
                      ),
                    ),
                  ),
                );
                try {
                  final result = await repository.addDappService(
                    serviceName: WalletConnectionStatus._dappServiceName,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          localizations
                              .serviceInitializationSuccess(result.serviceName),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          localizations
                              .serviceInitializationError(e.toString()),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                  log('Error initializing service: $e');
                }
              },
            ),
          ),
        ],
      ],
    );
  }
}
