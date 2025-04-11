import 'package:did_app/application/identity/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for creating a new digital identity
class CreateIdentityScreen extends ConsumerStatefulWidget {
  const CreateIdentityScreen({super.key});

  @override
  ConsumerState<CreateIdentityScreen> createState() =>
      _CreateIdentityScreenState();
}

class _CreateIdentityScreenState extends ConsumerState<CreateIdentityScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _displayName = '';
  String _fullName = '';
  String _email = '';
  String? _phoneNumber;
  DateTime? _dateOfBirth;
  String? _nationality;

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    // Watch identity state to get loading status and errors
    final identityState = ref.watch(identityNotifierProvider);

    // If identity was created successfully, show success dialog and return
    if (!_isSubmitting && identityState.identity != null) {
      // Call in post-frame callback to avoid build during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Identity Created'),
            content: const Text(
              'Your digital identity has been successfully created on the Archethic blockchain.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Return to previous screen
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }

    // If there is an error while submitting, show error
    if (_isSubmitting && identityState.errorMessage != null) {
      // Reset submitting state
      _isSubmitting = false;

      // Show error in snackbar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${identityState.errorMessage}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Digital Identity'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Basic Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Display name field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  helperText: 'Public name for your identity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a display name';
                  }
                  return null;
                },
                onSaved: (value) => _displayName = value!,
              ),
              const SizedBox(height: 16),

              // Full name field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Legal Name',
                  helperText: 'As it appears on your official documents',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) => _fullName = value!,
              ),
              const SizedBox(height: 16),

              // Email field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  helperText: 'Required for verification',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  // Simple email validation
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16),

              // Phone number field (optional)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number (Optional)',
                  helperText: 'Include country code',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 24),

              const Divider(),
              const SizedBox(height: 24),

              const Text(
                'Additional Information (Optional)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Date of Birth Picker
              GestureDetector(
                onTap: () => _selectDateOfBirth(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      helperText: 'Optional',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _dateOfBirth != null
                          ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                          : '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nationality field (optional)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nationality (Optional)',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _nationality = value,
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: identityState.isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: identityState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Create Digital Identity',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Privacy notice
              const Text(
                'Your information will be encrypted and stored securely on the '
                'Archethic blockchain. You maintain complete control over who can access your data.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Open date picker for selecting date of birth
  Future<void> _selectDateOfBirth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  /// Handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSubmitting = true;
      });

      // Call the identity provider to create the identity
      ref.read(identityNotifierProvider.notifier).createIdentity(
            displayName: _displayName,
            fullName: _fullName,
            email: _email,
            phoneNumber: _phoneNumber,
            dateOfBirth: _dateOfBirth,
            nationality: _nationality,
          );
    }
  }
}
