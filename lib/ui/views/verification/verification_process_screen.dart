import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen that guides the user through the verification process steps
class VerificationProcessScreen extends ConsumerStatefulWidget {
  const VerificationProcessScreen({
    super.key,
    required this.verificationProcess,
  });
  final VerificationProcess verificationProcess;

  @override
  ConsumerState<VerificationProcessScreen> createState() =>
      _VerificationProcessScreenState();
}

class _VerificationProcessScreenState
    extends ConsumerState<VerificationProcessScreen> {
  @override
  Widget build(BuildContext context) {
    // Watch the verification state to get currentStepIndex and isLoading
    final verificationState = ref.watch(verificationNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navVerification),
        // Back button with confirmation dialog
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _confirmCancelVerification(context),
        ),
        actions: [
          // Help button
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Process Help',
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: verificationState.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.verificationInProgress),
                ],
              ),
            )
          : _buildVerificationProcessView(context, verificationState, l10n),
    );
  }

  // Main verification process view
  Widget _buildVerificationProcessView(
    BuildContext context,
    VerificationState state,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status card
          _buildStatusCard(context, l10n),
          const SizedBox(height: 24),

          // Progress indicator
          _buildProgressIndicator(state.currentStepIndex, l10n),
          const SizedBox(height: 24),

          // Step content - this would be filled with actual verification step screens
          Expanded(
            child: _buildPlaceholderStepContent(
              context,
              state.currentStepIndex,
              state.currentStep,
              l10n,
            ),
          ),
        ],
      ),
    );
  }

  // Display verification status
  Widget _buildStatusCard(BuildContext context, AppLocalizations l10n) {
    final statusColor = _getStatusColor(widget.verificationProcess.status);

    return Card(
      elevation: 2,
      color: statusColor.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _getStatusIcon(widget.verificationProcess.status),
              color: statusColor,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getStatusText(widget.verificationProcess.status, l10n),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _getStatusDescription(
                      widget.verificationProcess.status,
                      l10n,
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show progress through steps
  Widget _buildProgressIndicator(int currentStepIndex, AppLocalizations l10n) {
    final steps = widget.verificationProcess.steps;
    final progress =
        (steps.isEmpty) ? 0.0 : (currentStepIndex + 1) / steps.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step ${currentStepIndex + 1} of ${steps.length}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.withValues(alpha: 0.3),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Start'),
            Text('Complete'),
          ],
        ),
      ],
    );
  }

  // Placeholder step content
  Widget _buildPlaceholderStepContent(
    BuildContext context,
    int currentStepIndex,
    VerificationStep? currentStep,
    AppLocalizations l10n,
  ) {
    // Use widget.verificationProcess
    final step = currentStep ??
        (currentStepIndex < widget.verificationProcess.steps.length
            ? widget.verificationProcess.steps[currentStepIndex]
            : null);

    if (step == null) {
      return const Center(
        child: Text('No step information available'),
      );
    }

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step title
            Row(
              children: [
                Icon(
                  _getStepIcon(step.type),
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getStepTitle(step.type, l10n),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _getStepStatusColor(step.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStepStatusText(step.status, l10n),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getStepStatusColor(step.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Step description
            Text(step.description),
            const SizedBox(height: 8),
            Text(step.instructions),
            const SizedBox(height: 24),

            // Placeholder content
            const Center(
              child: Text(
                'Complete this step according to the instructions',
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _showStepHelp(context, step),
                  child: const Text('Help'),
                ),
                ElevatedButton(
                  onPressed: () => _mockStepSubmission(l10n, currentStepIndex),
                  child: Text(l10n.submitButton ?? 'Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Show step-specific help
  void _showStepHelp(BuildContext context, VerificationStep step) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Help for: ${_getStepTitle(step.type, AppLocalizations.of(context)!)}',
        ),
        content: SingleChildScrollView(
          child: Text(
            'Help text for step ${step.id}' ??
                'No specific help available for this step.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Mock submission of a step
  void _mockStepSubmission(AppLocalizations l10n, int currentStepIndex) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Simulate network delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && Navigator.canPop(context)) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // TODO: Add logic to check if this is the final step
      const isFinalStep = true; // Assuming final step for this mock

      if (isFinalStep) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.go('/main/verification/success');
          }
        });
      } else {
        // --- Code for intermediate steps (if needed later) ---
        // Show intermediate step success dialog
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => AlertDialog(
              title: Text(l10n.verificationResultDialogTitle),
              content: const Text(
                'Step submitted successfully. You can now proceed to the next step.',
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(dialogContext, rootNavigator: true).pop(),
                  child: Text(l10n.closeButton),
                ),
              ],
            ),
          );
        }
        // TODO: Update state here to show the next verification step
        // Example: ref.read(verificationProcessProvider.notifier).moveToNextStep();
      }
    });
  }

  // Confirm if the user wants to cancel verification
  void _confirmCancelVerification(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.cancelVerification),
        content: Text(l10n.cancelVerificationConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/main/verification');
            },
            child: Text(l10n.confirmButton),
          ),
        ],
      ),
    );
  }

  // Show general help for the verification process
  void _showHelpDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.verificationProcessHelp),
        content: SingleChildScrollView(
          child: Text(l10n.followVerificationSteps),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  // Helper methods
  Color _getStatusColor(VerificationStatus status) {
    return switch (status) {
      VerificationStatus.notStarted => Colors.grey,
      VerificationStatus.inProgress => Colors.blue,
      VerificationStatus.pendingReview => Colors.orange,
      VerificationStatus.completed => Colors.green,
      VerificationStatus.rejected => Colors.red,
      VerificationStatus.expired => Colors.red[300] ?? Colors.red,
    };
  }

  IconData _getStatusIcon(VerificationStatus status) {
    return switch (status) {
      VerificationStatus.notStarted => Icons.hourglass_empty,
      VerificationStatus.inProgress => Icons.pending_actions,
      VerificationStatus.pendingReview => Icons.assignment_ind,
      VerificationStatus.completed => Icons.check_circle,
      VerificationStatus.rejected => Icons.cancel,
      VerificationStatus.expired => Icons.timer_off,
    };
  }

  String _getStatusText(VerificationStatus status, AppLocalizations l10n) {
    return switch (status) {
      VerificationStatus.notStarted => 'Not Started',
      VerificationStatus.inProgress => l10n.verificationStatusInProgress,
      VerificationStatus.pendingReview => 'Pending Review',
      VerificationStatus.completed => l10n.verificationStatusCompleted,
      VerificationStatus.rejected => 'Rejected',
      VerificationStatus.expired => 'Expired',
    };
  }

  String _getStatusDescription(
    VerificationStatus status,
    AppLocalizations l10n,
  ) {
    return switch (status) {
      VerificationStatus.notStarted => 'Verification has not started yet.',
      VerificationStatus.inProgress =>
        l10n.verificationStatusInProgressDescription,
      VerificationStatus.pendingReview => 'Your submission is pending review.',
      VerificationStatus.completed =>
        l10n.verificationStatusCompletedDescription,
      VerificationStatus.rejected => l10n.verificationStatusFailedDescription,
      VerificationStatus.expired => 'This verification process has expired.',
    };
  }

  IconData _getStepIcon(VerificationStepType type) {
    return switch (type) {
      VerificationStepType.emailVerification => Icons.email,
      VerificationStepType.phoneVerification => Icons.phone,
      VerificationStepType.idDocumentVerification => Icons.badge,
      VerificationStepType.addressVerification => Icons.home,
      VerificationStepType.livenessCheck => Icons.face,
      VerificationStepType.biometricVerification => Icons.fingerprint,
      VerificationStepType.additionalDocuments => Icons.description,
    };
  }

  String _getStepTitle(VerificationStepType type, AppLocalizations l10n) {
    return switch (type) {
      VerificationStepType.emailVerification => 'Email Verification',
      VerificationStepType.phoneVerification => 'Phone Verification',
      VerificationStepType.idDocumentVerification => 'ID Document Verification',
      VerificationStepType.addressVerification => 'Address Verification',
      VerificationStepType.livenessCheck => 'Liveness Check',
      VerificationStepType.biometricVerification => 'Biometric Verification',
      VerificationStepType.additionalDocuments => 'Additional Documents',
    };
  }

  Color _getStepStatusColor(VerificationStepStatus status) {
    return switch (status) {
      VerificationStepStatus.notStarted => Colors.grey,
      VerificationStepStatus.inProgress => Colors.blue,
      VerificationStepStatus.completed => Colors.green,
      VerificationStepStatus.rejected => Colors.red,
      VerificationStepStatus.actionRequired => Colors.orange,
    };
  }

  String _getStepStatusText(
    VerificationStepStatus status,
    AppLocalizations l10n,
  ) {
    return switch (status) {
      VerificationStepStatus.notStarted => 'Not Started',
      VerificationStepStatus.inProgress => l10n.stepStatusInProgress,
      VerificationStepStatus.completed => l10n.stepStatusCompleted,
      VerificationStepStatus.rejected => 'Rejected',
      VerificationStepStatus.actionRequired => 'Action Required',
    };
  }
}
