import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';

/// Liveness verification step component for verification process
class LivenessVerificationStep extends StatefulWidget {
  const LivenessVerificationStep({
    super.key,
    required this.step,
  });

  final VerificationStep step;

  @override
  State<LivenessVerificationStep> createState() =>
      _LivenessVerificationStepState();
}

class _LivenessVerificationStepState extends State<LivenessVerificationStep> {
  @override
  Widget build(BuildContext context) {
    // Placeholder implementation - to be completed with actual functionality
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Liveness Verification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please take a selfie to verify your identity.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement selfie capture functionality
            },
            child: const Text('Take Selfie'),
          ),
        ),
      ],
    );
  }
}
