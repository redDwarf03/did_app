import 'dart:async';
import 'dart:math';

import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/domain/verification/verification_repository.dart';

/// Mock implementation of the Verification Repository for development and testing
///
/// TODO: Replace this mock implementation with a real verification service
/// This class simulates a verification process with artificial delays and in-memory storage.
/// A real implementation should:
/// - Integrate with a real KYC/AML provider
/// - Securely store verification data on the blockchain
/// - Implement proper document validation
/// - Follow eIDAS 2.0 compliance requirements
/// - Implement secure certificate generation with real digital signatures
class MockVerificationRepository implements VerificationRepository {
  // In-memory storage for mock verification processes
  final Map<String, VerificationProcess> _verifications = {};

  // Random generator for mock IDs
  final _random = Random();

  /// Generate a mock ID
  String _generateMockId() {
    const chars = 'abcdef0123456789';
    return List.generate(16, (index) => chars[_random.nextInt(chars.length)])
        .join();
  }

  /// Create a set of default verification steps
  List<VerificationStep> _createDefaultVerificationSteps() {
    final now = DateTime.now();

    return [
      // Step 1: Email verification
      VerificationStep(
        id: _generateMockId(),
        type: VerificationStepType.emailVerification,
        status: VerificationStepStatus.notStarted,
        order: 1,
        description: 'Verify your email address',
        instructions:
            'We will send a verification code to your email address. Please enter the code to verify your email.',
        updatedAt: now,
      ),

      // Step 2: Phone verification
      VerificationStep(
        id: _generateMockId(),
        type: VerificationStepType.phoneVerification,
        status: VerificationStepStatus.notStarted,
        order: 2,
        description: 'Verify your phone number',
        instructions:
            'We will send an SMS code to your phone number. Please enter the code to verify your phone.',
        updatedAt: now,
      ),

      // Step 3: ID document verification
      VerificationStep(
        id: _generateMockId(),
        type: VerificationStepType.idDocumentVerification,
        status: VerificationStepStatus.notStarted,
        order: 3,
        description: 'Upload your ID document',
        instructions:
            "Please upload a high-quality photo of your ID document (passport, driver's license, or national ID card). Both front and back sides are required.",
        updatedAt: now,
      ),

      // Step 4: Address verification
      VerificationStep(
        id: _generateMockId(),
        type: VerificationStepType.addressVerification,
        status: VerificationStepStatus.notStarted,
        order: 4,
        description: 'Verify your address',
        instructions:
            'Please upload a proof of address document (utility bill, bank statement, etc.) not older than 3 months.',
        updatedAt: now,
      ),

      // Step 5: Liveness check
      VerificationStep(
        id: _generateMockId(),
        type: VerificationStepType.livenessCheck,
        status: VerificationStepStatus.notStarted,
        order: 5,
        description: 'Selfie verification',
        instructions:
            'Please take a clear selfie of yourself holding your ID document next to your face.',
        updatedAt: now,
      ),
    ];
  }

  @override
  Future<bool> hasActiveVerification(String identityAddress) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Check if there's a verification process for this identity
    final hasVerification = _verifications.values.any(
      (process) =>
          process.identityAddress == identityAddress &&
          process.status != VerificationStatus.completed &&
          process.status != VerificationStatus.rejected &&
          process.status != VerificationStatus.expired,
    );

    return hasVerification;
  }

  @override
  Future<VerificationProcess?> getVerificationProcess(
    String identityAddress,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Find verification process for this identity
    final verification = _verifications.values
        .where((process) => process.identityAddress == identityAddress)
        .toList();

    if (verification.isEmpty) {
      return null;
    }

    // Return the most recent one
    verification.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return verification.first;
  }

  @override
  Future<VerificationProcess> startVerification(String identityAddress) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Check if there's already an active verification
    final hasActive = await hasActiveVerification(identityAddress);
    if (hasActive) {
      throw Exception(
        'There is already an active verification process for this identity',
      );
    }

    // Create a new verification process
    final now = DateTime.now();
    final verificationId = _generateMockId();

    final verification = VerificationProcess(
      id: verificationId,
      identityAddress: identityAddress,
      status: VerificationStatus.notStarted,
      steps: _createDefaultVerificationSteps(),
      createdAt: now,
      updatedAt: now,
    );

    // Store in our mock database
    _verifications[verificationId] = verification;

    return verification;
  }

  @override
  Future<VerificationProcess> submitVerificationStep({
    required String verificationId,
    required String stepId,
    required List<String> documentPaths,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Get the verification process
    final verification = _verifications[verificationId];
    if (verification == null) {
      throw Exception('Verification process not found');
    }

    // Find the step to update
    final stepIndex =
        verification.steps.indexWhere((step) => step.id == stepId);
    if (stepIndex == -1) {
      throw Exception('Verification step not found');
    }

    // Update the step status and add documents
    final now = DateTime.now();
    final updatedSteps = List<VerificationStep>.from(verification.steps);
    final currentStep = updatedSteps[stepIndex];

    updatedSteps[stepIndex] = currentStep.copyWith(
      status: VerificationStepStatus.actionRequired,
      documentPaths: documentPaths,
      updatedAt: now,
    );

    // Update the verification process status if needed
    var updatedStatus = verification.status;
    if (updatedStatus == VerificationStatus.notStarted) {
      updatedStatus = VerificationStatus.inProgress;
    }

    // Check if all steps are completed
    final allStepsSubmitted = updatedSteps.every(
      (step) =>
          step.status == VerificationStepStatus.completed ||
          step.status == VerificationStepStatus.actionRequired,
    );

    if (allStepsSubmitted) {
      updatedStatus = VerificationStatus.pendingReview;
    }

    // Create updated verification process
    final updatedVerification = verification.copyWith(
      status: updatedStatus,
      steps: updatedSteps,
      updatedAt: now,
    );

    // Update in our mock database
    _verifications[verificationId] = updatedVerification;

    // For the mock implementation, we'll auto-approve steps after a delay
    await _autoApproveStepAfterDelay(verificationId, stepId);

    return updatedVerification;
  }

  /// Auto-approve a verification step after a delay (mock testing only)
  Future<void> _autoApproveStepAfterDelay(
    String verificationId,
    String stepId,
  ) async {
    // TODO: Remove this mock auto-approval in production implementation
    // This method exists only for testing and demonstration purposes.
    // A real implementation would:
    // - Have verification steps reviewed by authorized personnel or automated systems
    // - Implement proper validation of submitted documents
    // - Follow regulatory compliance requirements for KYC/AML procedures
    // - Provide detailed feedback for rejected verification steps

    // Random delay between 5-10 seconds for testing
    final delay = Duration(milliseconds: 5000 + _random.nextInt(5000));
    await Future.delayed(delay);

    // Get the verification process
    final verification = _verifications[verificationId];
    if (verification == null) return;

    // Find the step to update
    final stepIndex =
        verification.steps.indexWhere((step) => step.id == stepId);
    if (stepIndex == -1) return;

    // Update the step status
    final now = DateTime.now();
    final updatedSteps = List<VerificationStep>.from(verification.steps);
    final currentStep = updatedSteps[stepIndex];

    updatedSteps[stepIndex] = currentStep.copyWith(
      status: VerificationStepStatus.completed,
      updatedAt: now,
    );

    // Check if all steps are completed
    final allStepsCompleted = updatedSteps.every(
      (step) => step.status == VerificationStepStatus.completed,
    );

    var updatedStatus = verification.status;
    var completedAt = verification.completedAt;
    var certificate = verification.certificate;

    // If all steps are completed, mark verification as completed
    if (allStepsCompleted) {
      updatedStatus = VerificationStatus.completed;
      completedAt = now;

      // Create a verification certificate
      certificate = VerificationCertificate(
        id: _generateMockId(),
        issuedAt: now,
        expiresAt: now.add(const Duration(days: 365)), // Valid for 1 year
        issuer: 'Mock Verification Authority',
        eidasLevel: EidasLevel.substantial,
        signature: _generateMockSignature(),
      );
    } else if (updatedStatus == VerificationStatus.pendingReview) {
      // If we're still in review but not all steps are complete
      updatedStatus = VerificationStatus.inProgress;
    }

    // Create updated verification process
    final updatedVerification = verification.copyWith(
      status: updatedStatus,
      steps: updatedSteps,
      updatedAt: now,
      completedAt: completedAt,
      certificate: certificate,
    );

    // Update in our mock database
    _verifications[verificationId] = updatedVerification;
  }

  /// Generate a mock signature
  String _generateMockSignature() {
    return _generateMockId() + _generateMockId();
  }

  @override
  Future<void> cancelVerification(String verificationId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Remove the verification process
    _verifications.remove(verificationId);
  }

  @override
  Future<VerificationStepStatus> getStepStatus({
    required String verificationId,
    required String stepId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Get the verification process
    final verification = _verifications[verificationId];
    if (verification == null) {
      throw Exception('Verification process not found');
    }

    // Find the step
    final step = verification.steps.firstWhere(
      (step) => step.id == stepId,
      orElse: () => throw Exception('Verification step not found'),
    );

    return step.status;
  }

  @override
  Future<VerificationCertificate?> getVerificationCertificate(
    String identityAddress,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Find the completed verification process for this identity
    final verification = _verifications.values.firstWhere(
      (process) =>
          process.identityAddress == identityAddress &&
          process.status == VerificationStatus.completed &&
          process.certificate != null,
      orElse: () =>
          throw Exception('No completed verification found for this identity'),
    );

    return verification.certificate;
  }
}
