import 'package:did_app/application/identity/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final localizations = AppLocalizations.of(context)!;

    // If identity was created successfully, show success dialog and return
    if (!_isSubmitting && identityState.identity != null) {
      // Call in post-frame callback to avoid build during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(localizations.identityCreatedDialogTitle),
            content: Text(localizations.identityCreatedDialogContent),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Return to previous screen
                },
                child: Text(localizations.okButton),
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
            content: Text(
              localizations.genericErrorMessage(identityState.errorMessage!),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.createIdentityScreenTitle),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.basicInfoTitleForm,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Display name field
              TextFormField(
                decoration: InputDecoration(
                  labelText: localizations.displayNameLabel,
                  helperText: localizations.displayNameHelperText,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.displayNameValidationError;
                  }
                  return null;
                },
                onSaved: (value) => _displayName = value!,
              ),
              const SizedBox(height: 16),

              // Full name field
              TextFormField(
                decoration: InputDecoration(
                  labelText: localizations.fullNameLabel,
                  helperText: localizations.fullNameHelperText,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.fullNameValidationError;
                  }
                  return null;
                },
                onSaved: (value) => _fullName = value!,
              ),
              const SizedBox(height: 16),

              // Email field
              TextFormField(
                decoration: InputDecoration(
                  labelText: localizations.emailLabel,
                  helperText: localizations.emailHelperText,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.emailValidationErrorRequired;
                  }

                  // Simple email validation
                  if (!value.contains('@') || !value.contains('.')) {
                    return localizations.emailValidationErrorInvalid;
                  }

                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16),

              // Phone number field (optional)
              TextFormField(
                decoration: InputDecoration(
                  labelText: localizations.phoneLabel,
                  helperText: localizations.phoneHelperText,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 24),

              const Divider(),
              const SizedBox(height: 24),

              Text(
                localizations.additionalInfoTitleForm,
                style: const TextStyle(
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
                    decoration: InputDecoration(
                      labelText: localizations.dobLabel,
                      helperText: localizations.dobHelperText,
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
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
                decoration: InputDecoration(
                  labelText: localizations.nationalityLabel,
                  border: const OutlineInputBorder(),
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
                      : Text(
                          localizations.createIdentityButtonForm,
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Privacy notice
              Text(
                localizations.privacyNotice,
                style: const TextStyle(
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
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSubmitting = true;
      });

      // Call the identity provider to create the identity
      final newIdentity =
          await ref.read(identityNotifierProvider.notifier).createIdentity(
                displayName: _displayName,
                fullName: _fullName,
                email: _email,
                phoneNumber: _phoneNumber,
                dateOfBirth: _dateOfBirth,
                nationality: _nationality,
              );

      if (newIdentity != null && mounted) {
        context.go('/main/credential');
      }
    }
  }
}
