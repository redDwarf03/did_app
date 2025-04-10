import 'package:did_app/domain/verification/verification_process.dart';

/// Repository interface for verification processes
abstract class VerificationRepository {
  /// Check if the identity has an active verification process
  Future<bool> hasActiveVerification(String identityAddress);

  /// Get the current verification process for an identity
  Future<VerificationProcess?> getVerificationProcess(String identityAddress);

  /// Start a new verification process for an identity
  ///
  /// Returns the new verification process
  Future<VerificationProcess> startVerification(String identityAddress);

  /// Submit a verification step with required documents or proofs
  ///
  /// Returns the updated verification process
  Future<VerificationProcess> submitVerificationStep({
    required String verificationId,
    required String stepId,
    required List<String> documentPaths,
  });

  /// Cancel an active verification process
  Future<void> cancelVerification(String verificationId);

  /// Returns the status of a specific step in the verification process
  Future<VerificationStepStatus> getStepStatus({
    required String verificationId,
    required String stepId,
  });

  /// Get a certificate for a completed verification
  Future<VerificationCertificate?> getVerificationCertificate(
      String identityAddress);
}
