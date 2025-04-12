import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_process.freezed.dart';
part 'verification_process.g.dart';

/// Represents a comprehensive verification process, typically used for Know Your Customer (KYC)
/// or Anti-Money Laundering (AML) compliance checks.
///
/// This process orchestrates multiple [VerificationStep]s required to establish
/// a certain level of trust or assurance for a digital identity, identified by
/// [identityAddress] (which could be a DID).
/// The overall outcome can influence the [IdentityVerificationStatus] in the main
/// [DigitalIdentity] model and might result in the issuance of a [VerificationCertificate].
@freezed
class VerificationProcess with _$VerificationProcess {
  const factory VerificationProcess({
    /// Unique identifier for this specific instance of the verification process.
    required String id,

    /// The identifier (e.g., DID or blockchain address) of the digital identity
    /// undergoing this verification process.
    required String identityAddress,

    /// The overall current status of the verification process. See [VerificationStatus].
    required VerificationStatus status,

    /// An ordered list of the individual steps required to complete the verification.
    /// See [VerificationStep].
    required List<VerificationStep> steps,

    /// Timestamp indicating when this verification process was initiated.
    required DateTime createdAt,

    /// Timestamp indicating the last time the process state or any of its steps were updated.
    required DateTime updatedAt,

    /// If the status is [VerificationStatus.rejected], this field may contain the reason.
    String? rejectionReason,

    /// Timestamp indicating when the process reached a final state ([completed] or [rejected]).
    DateTime? completedAt,

    /// If the process completed successfully ([VerificationStatus.completed]), this may hold
    /// the resulting certificate. See [VerificationCertificate].
    VerificationCertificate? certificate,
  }) = _VerificationProcess;

  /// Creates a [VerificationProcess] instance from a JSON map.
  factory VerificationProcess.fromJson(Map<String, dynamic> json) =>
      _$VerificationProcessFromJson(json);
}

/// Represents a single, distinct step within a larger [VerificationProcess].
///
/// Each step targets a specific piece of evidence or check (e.g., email verification,
/// ID document check, liveness detection) required for KYC/AML.
@freezed
class VerificationStep with _$VerificationStep {
  const factory VerificationStep({
    /// Unique identifier for this specific step instance within the process.
    required String id,

    /// The type of verification being performed in this step. See [VerificationStepType].
    required VerificationStepType type,

    /// The current status of this individual step. See [VerificationStepStatus].
    required VerificationStepStatus status,

    /// The sequential order of this step within the overall [VerificationProcess].
    required int order,

    /// A brief description of the purpose or goal of this verification step.
    required String description,

    /// Instructions provided to the user on how to complete this step.
    required String instructions,

    /// Timestamp indicating the last time the status or data associated with this step was updated.
    required DateTime updatedAt,

    /// If the status is [VerificationStepStatus.rejected], this may contain the reason.
    String? rejectionReason,

    /// Optional list of paths or references to documents uploaded by the user
    /// as evidence for this step (e.g., ID scan, proof of address).
    /// **Note:** Handling these documents must comply with GDPR.
    List<String>? documentPaths,
  }) = _VerificationStep;

  /// Creates a [VerificationStep] instance from a JSON map.
  factory VerificationStep.fromJson(Map<String, dynamic> json) =>
      _$VerificationStepFromJson(json);
}

/// Represents a certificate issued upon successful completion of a [VerificationProcess].
///
/// This certificate attests to the verification level achieved. Conceptually, this could be
/// represented as a Verifiable Credential (VC) linked to the user's DID ([VerificationProcess.identityAddress]),
/// although this model provides a simpler structure.
@freezed
class VerificationCertificate with _$VerificationCertificate {
  const factory VerificationCertificate({
    /// Unique identifier for this verification certificate.
    required String id,

    /// Timestamp indicating when the certificate was issued (i.e., verification completed).
    required DateTime issuedAt,

    /// Timestamp indicating when the verification or certificate expires and may need renewal.
    /// (Note: Currently required, but could potentially be made optional depending on use case).
    required DateTime expiresAt,

    /// Identifier of the entity (e.g., verification service provider) that issued the certificate.
    required String issuer,

    /// A digital signature from the issuer, ensuring the certificate's authenticity and integrity.
    /// Verification would require the issuer's public key.
    required String signature,

    /// The level of assurance achieved through the verification process, aligned with eIDAS standards.
    /// See [EidasLevel] for definitions (Low, Substantial, High).
    /// See: Regulation (EU) No 910/2014.
    @Default(EidasLevel.low) EidasLevel eidasLevel,
  }) = _VerificationCertificate;

  /// Creates a [VerificationCertificate] instance from a JSON map.
  factory VerificationCertificate.fromJson(Map<String, dynamic> json) =>
      _$VerificationCertificateFromJson(json);
}

/// Enumerates the possible overall statuses of a [VerificationProcess].
enum VerificationStatus {
  /// The verification process has not yet been started.
  notStarted,

  /// The verification process has started but is not yet complete.
  inProgress,

  /// The process is complete from the user's side and is awaiting review by the verifying entity.
  pendingReview,

  /// The verification process was completed successfully, meeting all requirements.
  completed,

  /// The verification process failed or was rejected by the verifying entity.
  rejected,

  /// The verification process or its result has expired.
  expired
}

/// Enumerates the possible statuses of an individual [VerificationStep].
enum VerificationStepStatus {
  /// This specific step has not been started.
  notStarted,

  /// The user is currently working on this step, or it is being processed.
  inProgress,

  /// This step was completed successfully.
  completed,

  /// This step failed or was rejected.
  rejected,

  /// The step requires input or action from the user.
  actionRequired
}

/// Defines the different types of verification steps commonly found in KYC/AML processes.
///
/// These steps gather evidence to verify different aspects of a user's identity.
/// Combining multiple steps contributes to the overall Level of Assurance (LOA).
enum VerificationStepType {
  /// Verifying control over an email address (e.g., via a confirmation link).
  emailVerification,

  /// Verifying control over a phone number (e.g., via an SMS code).
  phoneVerification,

  /// Uploading and verifying a government-issued identification document (e.g., passport, ID card).
  /// Often involves OCR and authenticity checks.
  idDocumentVerification,

  /// Verifying the user's residential address (e.g., via a utility bill, bank statement).
  addressVerification,

  /// Verifying that the user is a live person present during the process (e.g., selfie photo/video,
  /// active challenges). Helps prevent spoofing.
  livenessCheck,

  /// Verification using advanced biometric methods beyond a simple liveness check,
  /// potentially comparing against ID document photos.
  biometricVerification,

  /// Requesting additional specific documents based on regulatory requirements or risk assessment.
  additionalDocuments
}

/// Represents the levels of assurance defined by the eIDAS regulation (EU No 910/2014).
///
/// These levels indicate the degree of confidence in the claimed identity following
/// an identity proofing and verification process.
/// - **Low:** Provides a limited degree of confidence, suitable for low-risk scenarios.
/// - **Substantial:** Provides a substantial degree of confidence, requiring more robust verification.
/// - **High:** Provides the highest degree of confidence, often equivalent to physical presence.
/// Achieving higher levels typically requires stronger verification steps (e.g., verified ID documents, liveness).
enum EidasLevel {
  /// Low assurance level according to eIDAS.
  low,

  /// Substantial assurance level according to eIDAS.
  substantial,

  /// High assurance level according to eIDAS.
  high
}
