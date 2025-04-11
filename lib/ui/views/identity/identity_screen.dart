import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen that displays the user's digital identity or options to create one
class IdentityScreen extends ConsumerWidget {
  const IdentityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identityState = ref.watch(identityNotifierProvider);

    // This is a tab in the main navigation, don't show the back button
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Identity'),
        automaticallyImplyLeading: false,
      ),
      body: identityState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, identityState),
    );
  }

  Widget _buildContent(BuildContext context, IdentityState state) {
    if (state.identity != null) {
      return _buildIdentityView(context, state.identity!);
    } else {
      return _buildNoIdentityView(context);
    }
  }

  Widget _buildIdentityView(BuildContext context, DigitalIdentity identity) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Identity card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    identity.displayName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getVerificationColor(identity.verificationStatus)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getVerificationIcon(identity.verificationStatus),
                          size: 16,
                          color: _getVerificationColor(
                            identity.verificationStatus,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getVerificationLabel(identity.verificationStatus),
                          style: TextStyle(
                            color: _getVerificationColor(
                              identity.verificationStatus,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to identity details screen
                      context.pushNamed(
                        'identityDetails',
                        pathParameters: {
                          'address': identity.identityAddress,
                        },
                      );
                    },
                    icon: const Icon(Icons.info_outline),
                    label: const Text('View Identity Details'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick actions
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildQuickActionCard(
            context,
            Icons.verified_user_outlined,
            'Verify Identity',
            'Complete verification to access more features',
            () => context.pushNamed('verificationStart'),
            identity.verificationStatus ==
                    IdentityVerificationStatus.unverified ||
                identity.verificationStatus ==
                    IdentityVerificationStatus.rejected,
          ),
          const SizedBox(height: 16),
          _buildQuickActionCard(
            context,
            Icons.folder_outlined,
            'Manage Documents',
            'Store and share your documents securely',
            () => context.pushNamed('documents'),
            true,
          ),
          const SizedBox(height: 16),
          _buildQuickActionCard(
            context,
            Icons.edit_outlined,
            'Edit Identity',
            'Update your personal information',
            () {
              // To be implemented
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit identity feature coming soon'),
                ),
              );
            },
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildNoIdentityView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_outline,
              size: 80,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 24),
            const Text(
              'Create Your Digital Identity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "You don't have a digital identity yet. Create one to access all features of this application.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to create identity screen
                context.pushNamed('createIdentity');
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Identity'),
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
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    VoidCallback onTap,
    bool isEnabled,
  ) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isEnabled
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color:
                      isEnabled ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isEnabled ? null : Colors.grey,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: isEnabled ? Colors.grey : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isEnabled ? null : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getVerificationIcon(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return Icons.cancel_outlined;
      case IdentityVerificationStatus.basicVerified:
        return Icons.check_circle_outline;
      case IdentityVerificationStatus.fullyVerified:
        return Icons.verified_user;
      case IdentityVerificationStatus.pending:
        return Icons.pending_outlined;
      case IdentityVerificationStatus.rejected:
        return Icons.error_outline;
    }
  }

  String _getVerificationLabel(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return 'Not Verified';
      case IdentityVerificationStatus.basicVerified:
        return 'Basic Verification';
      case IdentityVerificationStatus.fullyVerified:
        return 'Fully Verified';
      case IdentityVerificationStatus.pending:
        return 'Verification Pending';
      case IdentityVerificationStatus.rejected:
        return 'Verification Rejected';
    }
  }

  Color _getVerificationColor(IdentityVerificationStatus status) {
    switch (status) {
      case IdentityVerificationStatus.unverified:
        return Colors.grey;
      case IdentityVerificationStatus.basicVerified:
        return Colors.blue;
      case IdentityVerificationStatus.fullyVerified:
        return Colors.green;
      case IdentityVerificationStatus.pending:
        return Colors.orange;
      case IdentityVerificationStatus.rejected:
        return Colors.red;
    }
  }
}
