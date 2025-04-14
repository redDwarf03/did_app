import 'package:did_app/application/auth/biometric_auth_provider.dart';
import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for configuring and managing secure authentication methods
class SecureAuthScreen extends ConsumerStatefulWidget {
  const SecureAuthScreen({super.key});

  @override
  ConsumerState<SecureAuthScreen> createState() => _SecureAuthScreenState();
}

class _SecureAuthScreenState extends ConsumerState<SecureAuthScreen> {
  // Controllers for PIN code and email
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;
  bool _isTesting = false;

  @override
  void dispose() {
    _pinController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(biometricAuthStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.secureAuthMenuTitle),
      ),
      body: _isTesting
          ? _buildTestingAuthentication(l10n)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(l10n),
                  const SizedBox(height: 24),
                  if (_errorMessage != null) _buildErrorMessage(_errorMessage!),
                  const SizedBox(height: 16),
                  _buildBiometricSection(authState, l10n),
                  const SizedBox(height: 24),
                  _buildTwoFactorSection(authState, l10n),
                  const SizedBox(height: 24),
                  _buildPasswordlessSection(authState, l10n),
                  const SizedBox(height: 24),
                  _buildTestAuthButton(l10n),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.secureAuthMenuTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.secureAuthFeatureDesc,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricSection(
    BiometricAuthState state,
    AppLocalizations l10n,
  ) {
    final biometricType = state.currentBiometricType;
    final isEnabled = state.isBiometricEnabled;
    final isAvailable = state.status != AuthStatus.unavailable &&
        state.status != AuthStatus.notSetUp;

    // Determine icon based on biometric type
    IconData biometricIcon;
    String biometricLabel;
    switch (biometricType) {
      case BiometricType.fingerprint:
        biometricIcon = Icons.fingerprint;
        biometricLabel = 'Fingerprint';
        break;
      case BiometricType.faceId:
        biometricIcon = Icons.face;
        biometricLabel = 'Face ID';
        break;
      case BiometricType.iris:
        biometricIcon = Icons.visibility;
        biometricLabel = 'Iris Scan';
        break;
      case BiometricType.none:
        biometricIcon = Icons.security;
        biometricLabel = 'Biometrics';
        break;
    }

    return AppCard(
      title: 'Biometric Authentication',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(biometricIcon, size: 32),
            title: Text(biometricLabel),
            subtitle: Text(
              isAvailable
                  ? 'Unlock with $biometricLabel for quick and secure access'
                  : 'Biometric authentication is not available on this device',
            ),
            trailing: Switch(
              value: isEnabled && isAvailable,
              onChanged: isAvailable ? _toggleBiometricAuth : null,
            ),
          ),
          if (state.status == AuthStatus.notSetUp) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.amber),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Biometrics are not set up on your device. Please configure them in your device settings.',
                      style: TextStyle(color: Colors.amber.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTwoFactorSection(
    BiometricAuthState state,
    AppLocalizations l10n,
  ) {
    final isEnabled = state.isTwoFactorEnabled;

    return AppCard(
      title: 'Two-Factor Authentication',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.security, size: 32),
            title: Text(AppLocalizations.of(context)!.twoFactorAuth),
            subtitle: const Text(
              'Add an extra layer of security to your account',
            ),
            trailing: Switch(
              value: isEnabled,
              onChanged: _toggleTwoFactorAuth,
            ),
          ),
          if (isEnabled) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.emailForVerification,
                  hintText:
                      AppLocalizations.of(context)!.emailForVerificationHint,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => _configureMagicLink(l10n),
                child: Text(AppLocalizations.of(context)!.saveEmail),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordlessSection(
    BiometricAuthState state,
    AppLocalizations l10n,
  ) {
    final isEnabled = state.isPasswordlessEnabled;

    return AppCard(
      title: 'Passwordless Login',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.lock_open, size: 32),
            title: Text(AppLocalizations.of(context)!.passwordlessLogin),
            subtitle: const Text(
              'Sign in without passwords using secure alternatives',
            ),
            trailing: Switch(
              value: isEnabled,
              onChanged: _togglePasswordlessAuth,
            ),
          ),
          if (isEnabled) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _configureMagicLink(l10n),
                      icon: const Icon(Icons.email),
                      label: Text(
                        AppLocalizations.of(context)!.configureMagicLink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _configureNotifications(l10n),
                      icon: const Icon(Icons.notifications),
                      label: Text(
                        AppLocalizations.of(context)!.configureNotifications,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTestAuthButton(AppLocalizations l10n) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _testAuthentication(l10n),
        icon: const Icon(Icons.security),
        label: Text(AppLocalizations.of(context)!.testAuthentication),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50),
        ),
      ),
    );
  }

  Widget _buildTestingAuthentication(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.security,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Please Authenticate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Authentication is required to proceed. Please verify your identity using one of the configured methods.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _authenticateWithBiometrics(l10n),
              icon: const Icon(Icons.fingerprint),
              label: Text(
                AppLocalizations.of(context)!.authenticateWithBiometrics,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 50),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _cancelAuthentication,
              icon: const Icon(Icons.cancel),
              label: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleBiometricAuth(bool enable) async {
    await ref
        .read(biometricAuthStateProvider.notifier)
        .toggleBiometricAuth(enable);
  }

  void _toggleTwoFactorAuth(bool enable) {
    ref.read(biometricAuthStateProvider.notifier).toggleTwoFactorAuth(enable);
  }

  void _togglePasswordlessAuth(bool enable) {
    ref
        .read(biometricAuthStateProvider.notifier)
        .togglePasswordlessAuth(enable);
  }

  void _configureMagicLink(AppLocalizations l10n) {
    // Logic to configure magic links
    final email = _emailController.text;
    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    // In a real implementation, register email for magic links
    setState(() {
      _errorMessage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.magicLinkConfigComplete),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _configureNotifications(AppLocalizations l10n) {
    // Logic to configure push notifications

    // In a real implementation, request permissions for notifications
    setState(() {
      _errorMessage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.notificationConfigComplete),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _testAuthentication(AppLocalizations l10n) {
    setState(() {
      _isTesting = true;
      _errorMessage = null;
    });

    final authState = ref.read(biometricAuthStateProvider);

    // Check if at least one authentication method is enabled
    if (!authState.isBiometricEnabled &&
        !authState.isTwoFactorEnabled &&
        !authState.isPasswordlessEnabled) {
      setState(() {
        _isTesting = false;
        _errorMessage = 'Please enable at least one authentication method';
      });
      return;
    }

    // If biometrics are enabled, start biometric authentication automatically
    if (authState.isBiometricEnabled) {
      _authenticateWithBiometrics(l10n);
    }
  }

  Future<void> _authenticateWithBiometrics(AppLocalizations l10n) async {
    try {
      final success = await ref
          .read(biometricAuthStateProvider.notifier)
          .authenticateWithBiometrics(
            reason: 'Authenticate to access the application',
          );

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.authenticationSuccessful),
              backgroundColor: Colors.green,
            ),
          );
          setState(() {
            _isTesting = false;
          });
        }
      } else {
        final authState = ref.read(biometricAuthStateProvider);
        setState(() {
          _errorMessage = authState.errorMessage ?? 'Authentication failed';
          _isTesting = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Authentication error: $e';
        _isTesting = false;
      });
    }
  }

  void _cancelAuthentication() {
    setState(() {
      _isTesting = false;
      _errorMessage = null;
    });
  }
}
