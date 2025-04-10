import 'dart:async';
import 'dart:math';

import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

/// Phone verification step component for verification process
class PhoneVerificationStep extends ConsumerStatefulWidget {
  const PhoneVerificationStep({
    super.key,
    required this.step,
  });

  final VerificationStep step;

  @override
  ConsumerState<PhoneVerificationStep> createState() =>
      _PhoneVerificationStepState();
}

class _PhoneVerificationStepState extends ConsumerState<PhoneVerificationStep> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _phoneSubmitted = false;
  bool _codeSent = false;
  bool _isSubmitting = false;
  bool _isResending = false;
  Timer? _timer;
  int _remainingTime = 0;

  // For international phone number handling
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');
  String _completePhoneNumber = '';

  // Random generator for mock verification code
  final _random = Random();
  late String _mockVerificationCode;

  @override
  void initState() {
    super.initState();
    // Generate a random 6-digit verification code for mock testing
    _mockVerificationCode = _generateRandomCode();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// Generate a random verification code
  String _generateRandomCode() {
    return (_random.nextInt(900000) + 100000).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone Verification',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'We need to verify your phone number to proceed with the identity verification process.',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          if (!_phoneSubmitted) ...[
            // Phone number input
            _buildPhoneInput(),
            const SizedBox(height: 24),

            // Submit phone button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitPhoneNumber,
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(
                    _isSubmitting ? 'Sending...' : 'Send verification code'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ] else if (!_codeSent) ...[
            // Phone number display
            _buildPhoneNumberDisplay(),
            const SizedBox(height: 24),

            // Send code button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isResending ? null : _sendVerificationCode,
                icon: _isResending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.sms),
                label: Text(_isResending
                    ? 'Sending code...'
                    : 'Send verification code'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Change phone number option
            TextButton.icon(
              onPressed: _resetPhoneSubmission,
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Change phone number'),
            ),
          ] else ...[
            // Phone number display
            _buildPhoneNumberDisplay(),
            const SizedBox(height: 24),

            // Code verification form
            Text(
              'Enter the 6-digit verification code sent to $_completePhoneNumber',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // For mock demonstration, show the code
            if (_mockVerificationCode.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.yellow[600]!),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Demo: Your verification code is $_mockVerificationCode',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Code entry field
            TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Verification Code',
                hintText: '6-digit code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the verification code';
                }
                if (value.length < 6) {
                  return 'Please enter all 6 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Resend code option
            if (_remainingTime > 0)
              Text(
                'Resend code in $_remainingTime seconds',
                style: const TextStyle(color: Colors.grey),
              )
            else
              TextButton.icon(
                onPressed: _isResending ? null : _sendVerificationCode,
                icon: _isResending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh, size: 16),
                label: const Text('Resend Code'),
              ),
            const SizedBox(height: 16),

            // Verify button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _verifyCode,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Verify'),
              ),
            ),

            // Change phone number option
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _resetPhoneSubmission,
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Change phone number'),
            ),
          ],
        ],
      ),
    );
  }

  /// Build the phone number input field
  Widget _buildPhoneInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          setState(() {
            _phoneNumber = number;
          });
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: _phoneNumber,
        textFieldController: _phoneController,
        formatInput: true,
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputDecoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: 'Phone Number',
        ),
        onSaved: (PhoneNumber number) {
          setState(() {
            _phoneNumber = number;
          });
        },
      ),
    );
  }

  /// Build the phone number display after submission
  Widget _buildPhoneNumberDisplay() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.phone_android,
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Phone number to verify',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  _completePhoneNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Submit the phone number for verification
  Future<void> _submitPhoneNumber() async {
    final phoneValid = _phoneController.text.isNotEmpty;

    if (phoneValid) {
      setState(() {
        _isSubmitting = true;
      });

      // Get the complete phone number with country code
      _completePhoneNumber = _phoneNumber.phoneNumber ?? '';

      // Simulate network request delay
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _phoneSubmitted = true;
        _isSubmitting = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Reset the phone submission state
  void _resetPhoneSubmission() {
    setState(() {
      _phoneSubmitted = false;
      _codeSent = false;
      _remainingTime = 0;
      _timer?.cancel();
    });
  }

  /// Send a verification code to the user's phone
  Future<void> _sendVerificationCode() async {
    setState(() {
      _isResending = true;
    });

    // Simulate network request delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate a new verification code
    _mockVerificationCode = _generateRandomCode();

    // In a real app, this would send an actual SMS
    // For demo purposes, we just set the state
    setState(() {
      _codeSent = true;
      _isResending = false;
      _remainingTime = 60; // 60 second cooldown for resend
    });

    // Start countdown timer
    _startResendTimer();

    // Show a snackbar to confirm
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code sent via SMS'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Start the resend timer countdown
  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  /// Verify the entered code
  Future<void> _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Check if the entered code matches the mock code
      final enteredCode = _codeController.text.trim();

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      if (enteredCode == _mockVerificationCode) {
        // Code is valid, simulate submission to the blockchain
        // In a real app, this would interact with the actual verification process

        // Submit verification step
        await ref
            .read(verificationNotifierProvider.notifier)
            .submitVerificationStep([_completePhoneNumber, enteredCode]);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phone number successfully verified'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Invalid code
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid verification code. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }
}
