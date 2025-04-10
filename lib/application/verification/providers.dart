import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/domain/verification/verification_repository.dart';
import 'package:did_app/infrastructure/verification/mock_verification_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the verification repository
final verificationRepositoryProvider = Provider<VerificationRepository>((ref) {
  // TODO: Replace mock implementation with real KYC/AML verification service
  // This should integrate with a real verification provider that offers KYC/AML services
  // and follows eIDAS 2.0 standards for identity verification
  return MockVerificationRepository();
});

/// State class for the verification process
class VerificationState {
  const VerificationState({
    this.verificationProcess,
    this.isLoading = false,
    this.errorMessage,
    this.currentStepIndex = 0,
  });

  /// The current verification process
  final VerificationProcess? verificationProcess;

  /// Loading state
  final bool isLoading;

  /// Error message if any
  final String? errorMessage;

  /// Current step being worked on
  final int currentStepIndex;

  /// Get the current step
  VerificationStep? get currentStep {
    if (verificationProcess == null ||
        verificationProcess!.steps.isEmpty ||
        currentStepIndex >= verificationProcess!.steps.length) {
      return null;
    }

    return verificationProcess!.steps[currentStepIndex];
  }

  /// Check if the verification is completed
  bool get isVerificationCompleted {
    return verificationProcess?.status == VerificationStatus.completed;
  }

  /// Get the certificate if verification is completed
  VerificationCertificate? get certificate {
    return verificationProcess?.certificate;
  }

  /// Copy with method for immutability
  VerificationState copyWith({
    VerificationProcess? verificationProcess,
    bool? isLoading,
    String? errorMessage,
    int? currentStepIndex,
  }) {
    return VerificationState(
      verificationProcess: verificationProcess ?? this.verificationProcess,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
    );
  }
}

/// Provider for managing verification processes
final verificationNotifierProvider =
    StateNotifierProvider<VerificationNotifier, VerificationState>((ref) {
  return VerificationNotifier(ref);
});

/// Notifier for managing verification states
class VerificationNotifier extends StateNotifier<VerificationState> {
  VerificationNotifier(this.ref) : super(const VerificationState());

  final Ref ref;

  /// Load verification process for an identity
  Future<void> loadVerification(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(verificationRepositoryProvider);
      final verification =
          await repository.getVerificationProcess(identityAddress);

      // If there's a verification process, find the current step
      int currentStepIndex = 0;
      if (verification != null && verification.steps.isNotEmpty) {
        // Find the first incomplete step
        for (int i = 0; i < verification.steps.length; i++) {
          final step = verification.steps[i];
          if (step.status != VerificationStepStatus.completed) {
            currentStepIndex = i;
            break;
          }
        }
      }

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: currentStepIndex,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load verification: ${e.toString()}',
      );
    }
  }

  /// Start a new verification process
  Future<void> startVerification(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(verificationRepositoryProvider);

      // Check if there's already a verification
      final hasActive = await repository.hasActiveVerification(identityAddress);
      if (hasActive) {
        // Load the existing verification
        await loadVerification(identityAddress);
        return;
      }

      // Start a new verification
      final verification = await repository.startVerification(identityAddress);

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: 0,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to start verification: ${e.toString()}',
      );
    }
  }

  /// Start a new verification with a specific level
  Future<void> startVerificationWithLevel(dynamic verificationLevel) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(verificationRepositoryProvider);
      // TODO: Get identity address from session or wallet connection
      // This is currently hardcoded but should come from the authenticated user's session
      final identityAddress =
          "current_user_address"; // In a real app, get from session

      // Check if there's already a verification
      final hasActive = await repository.hasActiveVerification(identityAddress);
      if (hasActive) {
        // Load the existing verification
        await loadVerification(identityAddress);
        return;
      }

      // Start a new verification
      final verification = await repository.startVerification(identityAddress);

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: 0,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to start verification: ${e.toString()}',
      );
    }
  }

  /// Start a renewal process
  Future<void> startRenewal({String? previousCertificateId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(verificationRepositoryProvider);
      final identityAddress =
          "current_user_address"; // In a real app, get from session

      // Check if there's already a verification
      final hasActive = await repository.hasActiveVerification(identityAddress);
      if (hasActive) {
        // Load the existing verification
        await loadVerification(identityAddress);
        return;
      }

      // Start a new verification (for renewal)
      final verification = await repository.startVerification(identityAddress);

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: 0,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to start renewal: ${e.toString()}',
      );
    }
  }

  /// Submit a verification step
  Future<void> submitVerificationStep(List<String> documentPaths) async {
    if (state.verificationProcess == null || state.currentStep == null) {
      state = state.copyWith(
        errorMessage: 'No active verification process',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(verificationRepositoryProvider);
      final verificationId = state.verificationProcess!.id;
      final stepId = state.currentStep!.id;

      // Submit the step
      final updatedVerification = await repository.submitVerificationStep(
        verificationId: verificationId,
        stepId: stepId,
        documentPaths: documentPaths,
      );

      // Move to the next incomplete step if available
      int nextStepIndex = state.currentStepIndex;
      if (updatedVerification.steps.length > state.currentStepIndex + 1) {
        nextStepIndex = state.currentStepIndex + 1;
      }

      state = state.copyWith(
        verificationProcess: updatedVerification,
        currentStepIndex: nextStepIndex,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to submit verification step: ${e.toString()}',
      );
    }
  }

  /// Move to a specific step
  void setCurrentStep(int stepIndex) {
    if (state.verificationProcess == null ||
        stepIndex < 0 ||
        stepIndex >= state.verificationProcess!.steps.length) {
      return;
    }

    state = state.copyWith(currentStepIndex: stepIndex);
  }

  /// Cancel an active verification process
  Future<void> cancelVerification() async {
    if (state.verificationProcess == null) {
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(verificationRepositoryProvider);
      await repository.cancelVerification(state.verificationProcess!.id);

      state = const VerificationState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to cancel verification: ${e.toString()}',
      );
    }
  }

  /// Check if a verification has been updated and refresh if needed
  Future<void> refreshVerification() async {
    if (state.verificationProcess == null) {
      return;
    }

    final identityAddress = state.verificationProcess!.identityAddress;
    await loadVerification(identityAddress);
  }

  /// Get verification certificate for an identity
  Future<VerificationCertificate?> getVerificationCertificate(
      String identityAddress) async {
    try {
      final repository = ref.read(verificationRepositoryProvider);
      return await repository.getVerificationCertificate(identityAddress);
    } catch (e) {
      return null;
    }
  }
}
