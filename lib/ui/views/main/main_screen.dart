import 'package:did_app/application/session/provider.dart';
import 'package:did_app/ui/views/credential/credential_list_screen.dart';
import 'package:did_app/ui/views/document/document_list_screen.dart';
import 'package:did_app/ui/views/identity/identity_screen.dart';
import 'package:did_app/ui/views/verification/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Main application screen with bottom navigation
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.path;

    if (location == '/main') {
      setState(() => _selectedIndex = 0);
    } else if (location.startsWith('/main/identity')) {
      setState(() => _selectedIndex = 1);
    } else if (location.startsWith('/main/credential')) {
      setState(() => _selectedIndex = 2);
    } else if (location.startsWith('/main/documents')) {
      setState(() => _selectedIndex = 3);
    } else if (location.startsWith('/main/verification')) {
      setState(() => _selectedIndex = 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(
      sessionNotifierProvider.select((session) => session.isConnected),
    );
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: widget.child ?? _buildScreen(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              GoRouter.of(context).go('/main');
              break;
            case 1:
              GoRouter.of(context).go('/main/identity');
              break;
            case 2:
              GoRouter.of(context).go('/main/credential');
              break;
            case 3:
              GoRouter.of(context).go('/main/documents');
              break;
            case 4:
              GoRouter.of(context).go('/main/verification');
              break;
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: localizations.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.badge_outlined),
            selectedIcon: const Icon(Icons.badge),
            label: localizations.navIdentity,
          ),
          NavigationDestination(
            icon: const Icon(Icons.card_membership_outlined),
            selectedIcon: const Icon(Icons.card_membership),
            label: localizations.navCredentials,
          ),
          NavigationDestination(
            icon: const Icon(Icons.folder_outlined),
            selectedIcon: const Icon(Icons.folder),
            label: localizations.navDocuments,
          ),
          NavigationDestination(
            icon: const Icon(Icons.verified_user_outlined),
            selectedIcon: const Icon(Icons.verified_user),
            label: localizations.navVerification,
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(int index) {
    final localizations = AppLocalizations.of(context)!;
    switch (index) {
      case 0:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              Text(
                localizations.didWalletTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.didWalletSubtitle,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      case 1:
        return const IdentityScreen();
      case 2:
        return const CredentialListScreen();
      case 3:
        return const DocumentListScreen();
      case 4:
        return const VerificationScreen();
      default:
        return Center(child: Text(localizations.pageNotFound));
    }
  }
}
