import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Address verification step component for verification process
class AddressVerificationStep extends StatefulWidget {
  const AddressVerificationStep({
    super.key,
    required this.step,
  });

  final VerificationStep step;

  @override
  State<AddressVerificationStep> createState() =>
      _AddressVerificationStepState();
}

class _AddressVerificationStepState extends State<AddressVerificationStep> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Placeholder implementation - to be completed with actual functionality
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address Verification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please upload proof of your address (utility bill, bank statement, etc.)',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement document upload functionality
            },
            child: Text(l10n.uploadDocument),
          ),
        ),
      ],
    );
  }
}
