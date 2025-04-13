import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:did_app/application/session/provider.dart'; // Provider for session state
// Import SessionState if needed to access specific fields
// import 'package:did_app/application/session/session_state.dart';

class AccountWidget extends ConsumerWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionNotifierProvider);

    // --- Adjust this logic based on your actual SessionState class ---
    if (sessionState.isConnected) {
      // Assuming SessionState has isConnected and account properties

      final displayName = sessionState.nameAccount;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.account_circle, size: 20, color: Colors.green),
          const SizedBox(width: 8),
          Flexible(
            // Use Flexible to prevent overflow
            child: Text(
              displayName,
              style: Theme.of(context).textTheme.titleSmall,
              overflow: TextOverflow.ellipsis, // Handle long names/addresses
            ),
          ),
        ],
      );
    } else {
      // Not connected or account info not available in state
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.link_off, size: 20),
          const SizedBox(width: 8),
          Text(
            'Not Connected', // Or use translations: AppLocalizations.of(context)!.notConnected
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }
  }
}
