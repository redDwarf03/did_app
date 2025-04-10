import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
        // Back button with confirmation dialog
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _confirmCancelVerification(context),
        ),
        actions: [
          // Help button
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Help',
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: verificationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildVerificationProcessView(context, verificationState),
    );
  }

  // Main verification process view
  Widget _buildVerificationProcessView(
    BuildContext context,
    VerificationState state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status card
          _buildStatusCard(context),
          const SizedBox(height: 24),

          // Progress indicator
          _buildProgressIndicator(state.currentStepIndex),
          const SizedBox(height: 24),

          // Step content - this would be filled with actual verification step screens
          Expanded(
            child: _buildPlaceholderStepContent(
                context, state.currentStepIndex, state.currentStep),
          ),
        ],
      ),
    );
  }

  // Display verification status
  Widget _buildStatusCard(BuildContext context) {
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
                    _getStatusText(verificationProcess.status),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _getStatusDescription(verificationProcess.status),
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
  Widget _buildProgressIndicator(int currentStepIndex) {
    final steps = verificationProcess.steps;

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
          value: (currentStepIndex + 1) / steps.length,
          backgroundColor: Colors.grey.withOpacity(0.3),
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
  ) {
    // Use the current step if provided from state, or determine step based on currentStepIndex
    final step = currentStep ??
        (currentStepIndex < verificationProcess.steps.length
            ? verificationProcess.steps[currentStepIndex]
            : null);

    if (step == null) {
      return const Center(
        child: Text('No step information available.'),
      );
    }

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    _getStepTitle(step.type),
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
                    _getStepStatusText(step.status),
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
                'This is a placeholder for the verification step content.\n'
                'In a real implementation, this would be replaced with specific UI for each step type.',
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
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => _mockStepSubmission(context, step.id),
                  child: const Text('Submit'),
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
        return Colors.red[300]!;
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

  String _getStatusText(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.notStarted:
        return 'Not Started';
      case VerificationStatus.inProgress:
        return 'In Progress';
      case VerificationStatus.pendingReview:
        return 'Pending Review';
      case VerificationStatus.completed:
        return 'Completed';
      case VerificationStatus.rejected:
        return 'Rejected';
      case VerificationStatus.expired:
        return 'Expired';
    }
  }

  String _getStatusDescription(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.notStarted:
        return 'Your verification process is ready to begin.';
      case VerificationStatus.inProgress:
        return 'Complete all required steps to verify your identity.';
      case VerificationStatus.pendingReview:
        return 'Your information is being reviewed by our verification team.';
      case VerificationStatus.completed:
        return 'Your identity has been successfully verified.';
      case VerificationStatus.rejected:
        return 'Your verification was rejected. Please check the reason and try again.';
      case VerificationStatus.expired:
        return 'Your verification has expired. Please start a new verification.';
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

  String _getStepTitle(VerificationStepType type) {
    switch (type) {
      case VerificationStepType.emailVerification:
        return 'Email Verification';
      case VerificationStepType.phoneVerification:
        return 'Phone Verification';
      case VerificationStepType.idDocumentVerification:
        return 'ID Document Verification';
      case VerificationStepType.addressVerification:
        return 'Address Verification';
      case VerificationStepType.livenessCheck:
        return 'Liveness Check';
      case VerificationStepType.biometricVerification:
        return 'Biometric Verification';
      case VerificationStepType.additionalDocuments:
        return 'Additional Documents';
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

  String _getStepStatusText(VerificationStepStatus status) {
    switch (status) {
      case VerificationStepStatus.notStarted:
        return 'Not Started';
      case VerificationStepStatus.inProgress:
        return 'In Progress';
      case VerificationStepStatus.completed:
        return 'Completed';
      case VerificationStepStatus.rejected:
        return 'Rejected';
      case VerificationStepStatus.actionRequired:
        return 'Action Required';
    }
  }

  // Display confirmation dialog before cancelling verification
  void _confirmCancelVerification(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Verification?'),
        content: const Text(
          'Are you sure you want to cancel the verification process? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No, Continue'),
          ),
          TextButton(
            onPressed: () {
              // Close all screens until we reach the main screen
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close verification process screen

              // Optional: You can also cancel the verification request on the server
              // ref.read(verificationNotifierProvider.notifier).cancelVerification();
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  // Show help dialog with information about the verification process
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verification Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'About Identity Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This process verifies your identity according to KYC/AML regulations. Complete all steps to obtain a verified digital identity certificate.',
              ),
              SizedBox(height: 16),
              Text(
                'Need Assistance?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'If you encounter any issues during the verification process, please contact our support team at support@example.com',
              ),
            ],
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
  void _mockStepSubmission(BuildContext context, String stepId) {
    // In a real app, this would call the verification notifier to submit the step
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Step Submission'),
        content: const Text(
            'In a real implementation, this would submit the step data to the verification service.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
