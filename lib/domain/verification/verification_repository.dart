import 'package:did_app/domain/verification/verification_process.dart';

/// Abstract interface defining the contract for managing identity verification processes.
///
/// This repository handles interactions related to initiating, progressing, retrieving,
/// and managing [VerificationProcess] instances, typically for KYC/AML purposes.
/// Implementations will communicate with the backend verification service or system.
/// It ensures separation between application logic and the specifics of the verification provider.
abstract class VerificationRepository {
  /// Checks if the identity identified by [identityAddress] (e.g., a DID) has an ongoing,
  /// active verification process that is not in a final state (completed, rejected, expired).
  ///
  /// Returns `true` if an active process exists, `false` otherwise.
  Future<bool> hasActiveVerification(String identityAddress);

  /// Retrieves the current or most recent verification process associated with the
  /// specified [identityAddress].
  ///
  /// This could return an active process or the details of the last completed/rejected one.
  ///
  /// Returns the [VerificationProcess] if found, otherwise `null`.
  Future<VerificationProcess?> getVerificationProcess(String identityAddress);

  /// Initiates a new identity verification process for the given [identityAddress].
  ///
  /// This typically involves creating a new [VerificationProcess] record in the backend
  /// with a defined set of initial [VerificationStep]s based on required policies (e.g., KYC level).
  ///
  /// - [identityAddress]: The identifier of the identity to be verified.
  ///
  /// Returns the newly created [VerificationProcess] object with its initial state.
  Future<VerificationProcess> startVerification(String identityAddress);

  /// Submits data or evidence for a specific step within a verification process.
  ///
  /// This is used when a user provides required information, such as uploading documents.
  /// Implementations must handle the secure transfer and storage of this data, respecting GDPR
  /// if personal data (like ID scans) is involved.
  ///
  /// - [verificationId]: The ID of the overall [VerificationProcess].
  /// - [stepId]: The ID of the specific [VerificationStep] being submitted.
  /// - [documentPaths]: References (e.g., storage paths, URIs) to the uploaded documents or evidence.
  ///                    Secure handling is crucial.
  ///
  /// Returns the updated [VerificationProcess] reflecting the submitted step data and potentially
  /// an updated step status (e.g., moving from `actionRequired` to `inProgress` or `completed`).
  Future<VerificationProcess> submitVerificationStep({
    required String verificationId,
    required String stepId,
    // Consider if a more structured input than just paths is needed, e.g., file type, metadata.
    required List<String> documentPaths,
  });

  /// Cancels an ongoing verification process identified by [verificationId].
  ///
  /// This might be initiated by the user or an administrator.
  Future<void> cancelVerification(String verificationId);

  /// Retrieves the current status of a specific step within a verification process.
  ///
  /// Useful for updating the UI based on the progress of individual steps.
  ///
  /// - [verificationId]: The ID of the overall [VerificationProcess].
  /// - [stepId]: The ID of the specific [VerificationStep] whose status is needed.
  ///
  /// Returns the [VerificationStepStatus] for the specified step.
  Future<VerificationStepStatus> getStepStatus({
    required String verificationId,
    required String stepId,
  });

  /// Retrieves the verification certificate issued for a successfully completed verification process.
  ///
  /// This certificate ([VerificationCertificate]) attests to the level of verification achieved
  /// (e.g., eIDAS level) and could potentially be presented as proof or used to issue a
  /// Verifiable Credential (VC).
  ///
  /// - [identityAddress]: The identifier of the identity whose certificate is requested.
  ///
  /// Returns the [VerificationCertificate] if a valid, completed verification exists, `null` otherwise.
  Future<VerificationCertificate?> getVerificationCertificate(
    String identityAddress,
  );
}
