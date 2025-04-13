import 'package:did_app/application/auth/biometric_auth_provider.dart';
import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:did_app/ui/views/auth/secure_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Login screen with support for different authentication methods
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(biometricAuthStateProvider);
    final isBiometricAvailable = authState.status != AuthStatus.unavailable &&
        authState.status != AuthStatus.notSetUp;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(l10n),
                const SizedBox(height: 40),
                if (_errorMessage != null) _buildErrorMessage(),
                const SizedBox(height: 24),
                _buildEmailField(l10n),
                const SizedBox(height: 16),
                _buildPasswordField(l10n),
                const SizedBox(height: 16),
                _buildRememberMeAndForgotPassword(l10n),
                const SizedBox(height: 24),
                _buildLoginButton(l10n),
                const SizedBox(height: 16),
                if (isBiometricAvailable)
                  _buildBiometricLoginButton(
                    authState.currentBiometricType,
                    l10n,
                  ),
                const SizedBox(height: 24),
                _buildDivider(l10n),
                const SizedBox(height: 24),
                _buildPasswordlessOptions(l10n),
                const SizedBox(height: 32),
                _buildSecureSettingsButton(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        const Icon(
          Icons.security,
          size: 64,
          color: Colors.blue,
        ),
        const SizedBox(height: 24),
        Text(
          l10n.secureLogin,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.secureAuthFeatureDesc,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(AppLocalizations l10n) {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: l10n.emailLabel,
        hintText: l10n.exampleEmail,
        prefixIcon: const Icon(Icons.email),
        border: const OutlineInputBorder(),
      ),
      enabled: !_isLoading,
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: l10n.password,
        hintText: l10n.passwordHint,
        prefixIcon: const Icon(Icons.lock),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      enabled: !_isLoading,
    );
  }

  Widget _buildRememberMeAndForgotPassword(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                if (!_isLoading) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                }
              },
            ),
            Text(l10n.rememberMe),
          ],
        ),
        TextButton(
          onPressed: _isLoading ? null : () => _forgotPassword(l10n),
          child: Text(l10n.forgotPassword),
        ),
      ],
    );
  }

  Widget _buildLoginButton(AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _login(l10n),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(l10n.loginTitle),
    );
  }

  Widget _buildBiometricLoginButton(
    BiometricType biometricType,
    AppLocalizations l10n,
  ) {
    IconData icon;
    String label;

    switch (biometricType) {
      case BiometricType.fingerprint:
        icon = Icons.fingerprint;
        label = 'Login with Fingerprint';
        break;
      case BiometricType.faceId:
        icon = Icons.face;
        label = 'Login with Face ID';
        break;
      case BiometricType.iris:
        icon = Icons.visibility;
        label = 'Login with Iris Scan';
        break;
      case BiometricType.none:
      default:
        icon = Icons.security;
        label = l10n.biometricsLogin;
        break;
    }

    return OutlinedButton.icon(
      onPressed: _isLoading ? null : () => _loginWithBiometrics(l10n),
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _buildDivider(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(l10n.or, style: TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildPasswordlessOptions(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: _isLoading ? null : () => _sendMagicLink(l10n),
          icon: const Icon(Icons.link),
          label: Text(l10n.loginWithMagicLink),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _isLoading ? null : () => _sendNotification(l10n),
          icon: const Icon(Icons.notifications),
          label: Text(l10n.loginWithPushNotification),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSecureSettingsButton(AppLocalizations l10n) {
    return TextButton(
      onPressed: _openSecureSettings,
      child: Text(l10n.secureAuthMenuTitle),
    );
  }

  Future<void> _login(AppLocalizations l10n) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Email and password are required';
      });
      return;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, accept any email with password "password"
      if (password == 'password') {
        // Authentication successful
        _navigateToHome(l10n);
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Login error: $e';
      });
    }
  }

  Future<void> _loginWithBiometrics(AppLocalizations l10n) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await ref
          .read(biometricAuthStateProvider.notifier)
          .authenticateWithBiometrics(
            reason: 'Authenticate to access your account',
          );

      if (success) {
        _navigateToHome(l10n);
      } else {
        final authState = ref.read(biometricAuthStateProvider);
        setState(() {
          _isLoading = false;
          _errorMessage =
              authState.errorMessage ?? 'Biometric authentication failed';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Authentication error: $e';
      });
    }
  }

  Future<void> _sendMagicLink(AppLocalizations l10n) async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email to receive a magic link';
      });
      return;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate sending a magic link
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.magicLinkSent(email)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error sending magic link: $e';
      });
    }
  }

  Future<void> _sendNotification(AppLocalizations l10n) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate sending a notification
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.loginNotificationSent),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error sending notification: $e';
      });
    }
  }

  void _forgotPassword(AppLocalizations l10n) {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email to reset your password';
      });
      return;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.passwordResetSent(email)),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _openSecureSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecureAuthScreen(),
      ),
    );
  }

  void _navigateToHome(AppLocalizations l10n) {
    // In a real app, navigate to the home screen
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.loginSuccessful),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
