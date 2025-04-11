import 'package:did_app/application/session/provider.dart';
import 'package:did_app/ui/views/credential/credential_list_screen.dart';
import 'package:did_app/ui/views/document/document_list_screen.dart';
import 'package:did_app/ui/views/identity/identity_screen.dart';
import 'package:did_app/ui/views/verification/verification_screen.dart';
import 'package:did_app/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
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
    // Détecter l'onglet actif en fonction de l'URL actuelle
    final location = GoRouterState.of(context).uri.path;

    if (location == '/main') {
      setState(() => _selectedIndex = 0);
    } else if (location.startsWith('/main/identity')) {
      setState(() => _selectedIndex = 1);
    } else if (location.startsWith('/main/credentials')) {
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

    return Scaffold(
      body: widget.child ?? _buildScreen(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Utiliser la navigation par URL, mais sans remplacer le MainScreen
          switch (index) {
            case 0:
              GoRouter.of(context).go('/main');
              break;
            case 1:
              GoRouter.of(context).go('/main/identity');
              break;
            case 2:
              GoRouter.of(context).go('/main/credentials');
              break;
            case 3:
              GoRouter.of(context).go('/main/documents');
              break;
            case 4:
              GoRouter.of(context).go('/main/verification');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: 'Identité',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_membership_outlined),
            selectedIcon: Icon(Icons.card_membership),
            label: 'Attestations',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Documents',
          ),
          NavigationDestination(
            icon: Icon(Icons.verified_user_outlined),
            selectedIcon: Icon(Icons.verified_user),
            label: 'Vérification',
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const Center(
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
        return const Center(child: Text('Page non trouvée'));
    }
  }
}
