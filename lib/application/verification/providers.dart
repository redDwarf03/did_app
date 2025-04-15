import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/domain/verification/verification_repository.dart';
import 'package:did_app/infrastructure/verification/mock_verification_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.freezed.dart';
part 'providers.g.dart';
// part 'providers.g.dart'; // Uncomment if serialization needed

/// Provides an instance of [VerificationRepository].
///
/// This repository handles interactions with the underlying verification service
/// (e.g., KYC/AML provider) responsible for verifying user identity according
/// to specific processes and standards like eIDAS 2.0.
final verificationRepositoryProvider = Provider<VerificationRepository>((ref) {
  // TODO: Replace mock implementation with real KYC/AML verification service
  // This should integrate with a real verification provider that offers KYC/AML services
  // and potentially follows eIDAS 2.0 standards for identity verification.
  return MockVerificationRepository();
});

/// Represents the state of the user identity verification process.
@freezed
class VerificationState with _$VerificationState {
  /// Creates an instance of [VerificationState].
  const factory VerificationState({
    /// The ongoing or completed verification process details.
    VerificationProcess? verificationProcess,

    /// Indicates if a verification operation (load, start, submit) is in progress.
    @Default(false) bool isLoading,

    /// Holds a potential error message from the last verification operation.
    String? errorMessage,

    /// The index of the current step within the [verificationProcess.steps] list
    /// that the user is actively working on or needs to complete.
    @Default(0) int currentStepIndex,
  }) = _VerificationState;

  /// Private constructor for Freezed, enables adding custom getters/methods.
  const VerificationState._();

  /// Gets the current [VerificationStep] based on the [currentStepIndex].
  /// Returns `null` if there's no active process, steps are empty, or the index is out of bounds.
  VerificationStep? get currentStep {
    if (verificationProcess == null ||
        verificationProcess!.steps.isEmpty ||
        currentStepIndex >= verificationProcess!.steps.length) {
      return null;
    }
    return verificationProcess!.steps[currentStepIndex];
  }

  /// Checks if the overall verification process has reached the 'completed' status.
  bool get isVerificationCompleted {
    return verificationProcess?.status == VerificationStatus.completed;
  }

  /// Gets the resulting [VerificationCertificate] if the verification process is completed.
  /// Returns `null` otherwise.
  VerificationCertificate? get certificate {
    return verificationProcess?.certificate;
  }
}

/// Interacts with the [VerificationRepository] to load, start, and progress
/// through verification steps.
@riverpod
class VerificationNotifier extends _$VerificationNotifier {
  /// Creates an instance of [VerificationNotifier].
  /// Requires a [Ref] to access the [verificationRepositoryProvider].
  @override
  VerificationState build() {
    // Initial state
    return const VerificationState();
  }

  // Helper to get repository
  VerificationRepository get _repository =>
      ref.read(verificationRepositoryProvider);

  /// Loads the current or most recent verification process associated with the given [identityAddress].
  ///
  /// Determines the `currentStepIndex` based on the first incomplete step found.
  /// Updates the state with the loaded process or an error message.
  Future<void> loadVerification(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final verification =
          await _repository.getVerificationProcess(identityAddress);

      var currentStepIndex = 0;
      if (verification != null && verification.steps.isNotEmpty) {
        // Find the index of the first step not marked as completed.
        currentStepIndex = verification.steps.indexWhere(
          (step) => step.status != VerificationStepStatus.completed,
        );
        // If all steps are completed, indexWhere returns -1. Set to last step index or 0.
        if (currentStepIndex == -1) {
          currentStepIndex =
              verification.steps.isNotEmpty ? verification.steps.length - 1 : 0;
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
        errorMessage: 'Failed to load verification process: $e',
      );
    }
  }

  /// Starts a new verification process for the given [identityAddress].
  ///
  /// Checks if an active process already exists; if so, loads it instead.
  /// Otherwise, initiates a new process via the repository.
  /// Updates the state with the new process or an error message.
  Future<void> startVerification(String identityAddress) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Check if there's already an active verification process
      final hasActive =
          await _repository.hasActiveVerification(identityAddress);
      if (hasActive) {
        // Load the existing one instead of starting anew
        await loadVerification(identityAddress);
        return;
      }

      // Start a new verification process
      final verification = await _repository.startVerification(identityAddress);

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: 0, // Start at the first step
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to start verification: $e',
      );
    }
  }

  /// Starts a new verification process requesting a specific [eidasLevel].
  ///
  /// Similar to [startVerification] but allows specifying the desired level (e.g., Low, Substantial, High).
  /// **Note:** Requires obtaining the user's `identityAddress` from the current session/wallet.
  /// The repository interaction might differ based on the level.
  Future<void> startVerificationWithLevel({
    required EidasLevel eidasLevel, // Use EidasLevel from domain
    required String identityAddress, // Explicitly require identity address
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Check if there's already an active verification process
      final hasActive =
          await _repository.hasActiveVerification(identityAddress);
      if (hasActive) {
        // Consider if the existing process matches the requested level
        // If not, cancellation/restart logic might be needed (depends on policy)
        // Also check if the existing process level matches eidasLevel
        final existingProcess =
            await _repository.getVerificationProcess(identityAddress);
        if (existingProcess?.certificate?.eidasLevel == eidasLevel) {
          await loadVerification(identityAddress);
          return;
        } else {
          // Handle level mismatch - potentially cancel old one?
          // For now, just load the existing one.
          await loadVerification(identityAddress);
          return; // Or throw error, or proceed to create new?
        }
      }

      // Start a new verification process with the specified level
      // TODO: Update repository interface if `startVerification` needs the level
      final verification = await _repository.startVerification(
        identityAddress, // Pass level if required by repo method
        // level: eidasLevel, // Pass the domain level if required
      );

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: 0, // Start at the first step
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to start verification with level: $e',
      );
    }
  }

  /// Starts a verification process intended for renewing an existing certificate.
  ///
  /// **Note:** Requires obtaining the user's `identityAddress` from the current session/wallet.
  /// May involve passing the [previousCertificateId] to the repository.
  Future<void> startRenewal({
    required String identityAddress, // Explicitly require identity address
    String? previousCertificateId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Check if there's already an active verification process
      final hasActive =
          await _repository.hasActiveVerification(identityAddress);
      if (hasActive) {
        await loadVerification(identityAddress);
        return;
      }

      // Start a new verification process, potentially marking it as renewal
      // TODO: Update repository interface if `startVerification` needs renewal info
      final verification = await _repository.startVerification(
        identityAddress,
        // isRenewal: true,
        // previousCertificateId: previousCertificateId,
      );

      state = state.copyWith(
        verificationProcess: verification,
        currentStepIndex: 0, // Start at the first step
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to start verification renewal: $e',
      );
    }
  }

  /// Submits data for the current verification step.
  ///
  /// Requires [documentPaths] or other data relevant to the current step's requirements.
  /// Updates the verification process via the repository and potentially advances the `currentStepIndex`.
  /// Updates the state with the modified process or an error message.
  Future<void> submitVerificationStep(
      {required List<String> documentPaths,
      Map<String, dynamic>? formData}) async {
    // Ensure there is an active process and a current step
    if (state.verificationProcess == null || state.currentStep == null) {
      state = state.copyWith(
        errorMessage: 'No active verification process or step to submit',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final verificationId = state.verificationProcess!.id;
      final stepId = state.currentStep!.id;

      // Submit the step data to the repository
      final updatedVerification = await _repository.submitVerificationStep(
        verificationId: verificationId,
        stepId: stepId,
        documentPaths: documentPaths,
        // TODO: Pass formData if the repository method accepts it
        // formData: formData,
      );

      // Determine the next step index after submission
      var nextStepIndex = state.currentStepIndex;
      if (updatedVerification.steps.length > state.currentStepIndex) {
        // Find the first incomplete step starting from the current index
        final nextIncomplete = updatedVerification.steps.indexWhere(
          (step) => step.status != VerificationStepStatus.completed,
          state.currentStepIndex,
        );

        if (nextIncomplete != -1) {
          nextStepIndex = nextIncomplete;
        } else {
          // If all steps from current onwards are complete, stay on last step
          // or update based on overall process status
          nextStepIndex = updatedVerification.steps.isNotEmpty
              ? updatedVerification.steps.length - 1
              : 0;
        }
      }

      state = state.copyWith(
        verificationProcess: updatedVerification,
        currentStepIndex: nextStepIndex,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to submit verification step: $e',
      );
    }
  }

  /// Resets the provider state to its initial default values.
  void reset() {
    state = const VerificationState();
  }
}
