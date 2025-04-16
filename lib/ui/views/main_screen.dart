import 'package:did_app/ui/views/credential/credential_list_screen.dart';
import 'package:did_app/ui/views/credential/eidas_interop_screen.dart';
import 'package:did_app/ui/views/document/document_list_screen.dart';
import 'package:did_app/ui/views/identity/identity_screen.dart';
import 'package:did_app/ui/views/verification/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Main screen with tabbed navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    IdentityScreen(),
    VerificationScreen(),
    DocumentListScreen(),
    CredentialListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: l10n.identityBottomNavLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.verified_user),
            label: l10n.verificationBottomNavLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.description),
            label: l10n.documentsBottomNavLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.badge),
            label: l10n.credentialsBottomNavLabel,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                l10n.drawerHeaderTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(l10n.identityBottomNavLabel),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: Text(l10n.verificationBottomNavLabel),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(l10n.documentsBottomNavLabel),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: Text(l10n.credentialsBottomNavLabel),
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.euro),
              title: Text(l10n.eidasInteropTitle),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EidasInteropScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.settingsDrawerLabel),
              onTap: () {
                // TODO: Navigate to settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(l10n.helpDrawerLabel),
              onTap: () {
                // TODO: Navigate to help page
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(l10n.drawerHeaderTitle),
      ),
    );
  }
}
