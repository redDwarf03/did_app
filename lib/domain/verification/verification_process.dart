import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_process.freezed.dart';
part 'verification_process.g.dart';

/// Represents a verification process for KYC/AML compliance
@freezed
class VerificationProcess with _$VerificationProcess {
  const factory VerificationProcess({
    /// Unique identifier for the verification process
    required String id,

    /// Address of the identity being verified
    required String identityAddress,

    /// Current status of the verification
    required VerificationStatus status,

    /// List of verification steps required
    required List<VerificationStep> steps,

    /// Creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// Rejection reason if the verification was rejected
    String? rejectionReason,

    /// Timestamp when the verification was completed
    DateTime? completedAt,

    /// Certificate data if fully verified
    VerificationCertificate? certificate,
  }) = _VerificationProcess;

  factory VerificationProcess.fromJson(Map<String, dynamic> json) =>
      _$VerificationProcessFromJson(json);
}

/// Represents a verification step in the KYC/AML process
@freezed
class VerificationStep with _$VerificationStep {
  const factory VerificationStep({
    /// Unique identifier for this step
    required String id,

    /// Type of verification step
    required VerificationStepType type,

    /// Current status of this step
    required VerificationStepStatus status,

    /// Order of this step in the verification process
    required int order,

    /// Description of what this step verifies
    required String description,

    /// Instructions for the user
    required String instructions,

    /// Last update timestamp
    required DateTime updatedAt,

    /// Rejection reason if this step was rejected
    String? rejectionReason,

    /// Paths to uploaded documents or proofs if applicable
    List<String>? documentPaths,
  }) = _VerificationStep;

  factory VerificationStep.fromJson(Map<String, dynamic> json) =>
      _$VerificationStepFromJson(json);
}

/// Represents a verification certificate for a fully verified identity
@freezed
class VerificationCertificate with _$VerificationCertificate {
  const factory VerificationCertificate({
    /// Unique identifier for this certificate
    required String id,

    /// Timestamp when the certificate was issued
    required DateTime issuedAt,

    /// Timestamp when the certificate expires
    required DateTime expiresAt,

    /// Issuer of the certificate
    required String issuer,

    /// Digital signature of the issuer
    required String signature,

    /// eIDAS compliance level
    @Default(EidasLevel.low) EidasLevel eidasLevel,
  }) = _VerificationCertificate;

  factory VerificationCertificate.fromJson(Map<String, dynamic> json) =>
      _$VerificationCertificateFromJson(json);
}

/// Overall status of the verification process
enum VerificationStatus {
  /// Not started
  notStarted,

  /// In progress
  inProgress,

  /// Pending review by verifier
  pendingReview,

  /// Completed successfully
  completed,

  /// Rejected
  rejected,

  /// Expired
  expired
}

/// Status of an individual verification step
enum VerificationStepStatus {
  /// Not started yet
  notStarted,

  /// In progress
  inProgress,

  /// Completed successfully
  completed,

  /// Rejected
  rejected,

  /// Waiting for user action
  actionRequired
}

/// Types of verification steps in the KYC/AML process
enum VerificationStepType {
  /// Email verification
  emailVerification,

  /// Phone verification
  phoneVerification,

  /// ID document upload and verification
  idDocumentVerification,

  /// Address proof verification
  addressVerification,

  /// Liveness check (selfie or video)
  livenessCheck,

  /// Advanced biometric verification
  biometricVerification,

  /// Additional documents as required by regulations
  additionalDocuments
}

/// eIDAS compliance levels
enum EidasLevel {
  /// Low assurance level
  low,

  /// Substantial assurance level
  substantial,

  /// High assurance level
  high
}
