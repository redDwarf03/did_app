import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Screen that guides the user through the verification process steps
class VerificationProcessScreen extends ConsumerWidget {
  const VerificationProcessScreen({
    super.key,
    required this.verificationProcess,
  });
  final VerificationProcess verificationProcess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            tooltip: l10n.verificationProcessHelpTooltip,
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
    final statusColor = _getStatusColor(verificationProcess.status);

    return Card(
      elevation: 2,
      color: statusColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: statusColor.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _getStatusIcon(verificationProcess.status),
              color: statusColor,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getStatusText(verificationProcess.status, l10n),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _getStatusDescription(verificationProcess.status, l10n),
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
    final steps = verificationProcess.steps;
    final progress =
        (steps.isEmpty) ? 0.0 : (currentStepIndex + 1) / steps.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step ${currentStepIndex + 1} of ${steps.length}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.withOpacity(0.3),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Start"),
            Text("Complete"),
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
    // Use the current step if provided from state, or determine step based on currentStepIndex
    final step = currentStep ??
        (currentStepIndex < verificationProcess.steps.length
            ? verificationProcess.steps[currentStepIndex]
            : null);

    if (step == null) {
      return Center(
        child: Text("No step information available"),
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
                    color: _getStepStatusColor(step.status).withOpacity(0.1),
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
            Center(
              child: Text(
                "Complete this step according to the instructions",
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _confirmCancelVerification(context),
                  child: Text(l10n.closeButton),
                ),
                ElevatedButton(
                  onPressed: () => _mockStepSubmission(context, step.id),
                  child: Text(l10n.submitButton ?? "Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Color _getStatusColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.notStarted:
        return Colors.grey;
      case VerificationStatus.inProgress:
        return Colors.blue;
      case VerificationStatus.pendingReview:
        return Colors.orange;
      case VerificationStatus.completed:
        return Colors.green;
      case VerificationStatus.rejected:
        return Colors.red;
      case VerificationStatus.expired:
        return Colors.red[300] ?? Colors.red;
    }
  }

  IconData _getStatusIcon(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.notStarted:
        return Icons.hourglass_empty;
      case VerificationStatus.inProgress:
        return Icons.pending_actions;
      case VerificationStatus.pendingReview:
        return Icons.assignment_ind;
      case VerificationStatus.completed:
        return Icons.check_circle;
      case VerificationStatus.rejected:
        return Icons.cancel;
      case VerificationStatus.expired:
        return Icons.timer_off;
    }
  }

  String _getStatusText(VerificationStatus status, AppLocalizations l10n) {
    switch (status) {
      case VerificationStatus.notStarted:
        return l10n.verificationStatusUnverified;
      case VerificationStatus.inProgress:
        return l10n.verificationInProgress;
      case VerificationStatus.pendingReview:
        return l10n.verificationStatusPending;
      case VerificationStatus.completed:
        return l10n.verificationStatusVerified;
      case VerificationStatus.rejected:
        return l10n.verificationStatusRejectedDetail;
      case VerificationStatus.expired:
        return l10n.verificationStatusExpiredDetail;
    }
  }

  String _getStatusDescription(
      VerificationStatus status, AppLocalizations l10n) {
    switch (status) {
      case VerificationStatus.notStarted:
        return l10n.verificationMessageUnverified;
      case VerificationStatus.inProgress:
        return l10n.verificationMessagePending;
      case VerificationStatus.pendingReview:
        return l10n.verificationMessagePending;
      case VerificationStatus.completed:
        return l10n.verificationMessageFullyVerified;
      case VerificationStatus.rejected:
        return l10n.verificationMessageRejected;
      case VerificationStatus.expired:
        return "Your verification has expired. Please request a new verification.";
    }
  }

  IconData _getStepIcon(VerificationStepType type) {
    switch (type) {
      case VerificationStepType.emailVerification:
        return Icons.email;
      case VerificationStepType.phoneVerification:
        return Icons.phone;
      case VerificationStepType.idDocumentVerification:
        return Icons.badge;
      case VerificationStepType.addressVerification:
        return Icons.home;
      case VerificationStepType.livenessCheck:
        return Icons.face;
      case VerificationStepType.biometricVerification:
        return Icons.fingerprint;
      case VerificationStepType.additionalDocuments:
        return Icons.description;
    }
  }

  String _getStepTitle(VerificationStepType type, AppLocalizations l10n) {
    switch (type) {
      case VerificationStepType.emailVerification:
        return "Email Verification";
      case VerificationStepType.phoneVerification:
        return "Phone Verification";
      case VerificationStepType.idDocumentVerification:
        return "ID Document Verification";
      case VerificationStepType.addressVerification:
        return "Address Verification";
      case VerificationStepType.livenessCheck:
        return "Liveness Check";
      case VerificationStepType.biometricVerification:
        return "Biometric Verification";
      case VerificationStepType.additionalDocuments:
        return "Additional Documents";
    }
  }

  Color _getStepStatusColor(VerificationStepStatus status) {
    switch (status) {
      case VerificationStepStatus.notStarted:
        return Colors.grey;
      case VerificationStepStatus.inProgress:
        return Colors.blue;
      case VerificationStepStatus.completed:
        return Colors.green;
      case VerificationStepStatus.rejected:
        return Colors.red;
      case VerificationStepStatus.actionRequired:
        return Colors.orange;
    }
  }

  String _getStepStatusText(
      VerificationStepStatus status, AppLocalizations l10n) {
    switch (status) {
      case VerificationStepStatus.notStarted:
        return "Not Started";
      case VerificationStepStatus.inProgress:
        return "In Progress";
      case VerificationStepStatus.completed:
        return "Completed";
      case VerificationStepStatus.rejected:
        return "Rejected";
      case VerificationStepStatus.actionRequired:
        return "Action Required";
    }
  }

  // Display confirmation dialog before cancelling verification
  void _confirmCancelVerification(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Verification?"),
        content: Text(
            "If you cancel now, your progress will be lost. Do you want to continue with verification?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Continue Verification"),
          ),
          TextButton(
            onPressed: () {
              // Close all screens until we reach the main screen
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close verification process screen

              // Optional: You can also cancel the verification request on the server
              // ref.read(verificationNotifierProvider.notifier).cancelVerification();
            },
            child: Text("Cancel Verification"),
          ),
        ],
      ),
    );
  }

  // Show help dialog with information about the verification process
  void _showHelpDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verification Help"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "About Verification",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Identity verification ensures the security and compliance of your digital identity. Complete all steps to verify your identity.",
              ),
              const SizedBox(height: 16),
              Text(
                "Need Assistance?",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "If you encounter any issues during the verification process, please contact our support team for assistance.",
              ),
            ],
          ),
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

  // Mock submission of a step
  void _mockStepSubmission(BuildContext context, String stepId) {
    final l10n = AppLocalizations.of(context)!;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(l10n.verificationInProgress),
          ],
        ),
      ),
    );

    // Simulate network delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog

      // In a real app, this would call the verification notifier to submit the step
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.verificationResultDialogTitle),
          content: Text(
              "Step submitted successfully. You can now proceed to the next step."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.closeButton),
            ),
          ],
        ),
      );
    });
  }
}
