import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_identity.freezed.dart';
part 'digital_identity.g.dart';

/// Represents a user's digital identity within the application.
///
/// Conforming to Self-Sovereign Identity (SSI) principles and eIDAS 2.0 recommendations,
/// this class serves as a minimal container for digital identity, without directly storing
/// Personally Identifiable Information (PII).
///
/// **Important distinction:** This class does NOT directly store personal information.
/// It follows the W3C DID model, where identity is a simple identifier while personal
/// attributes are stored separately as Verifiable Credentials (VCs).
/// This approach allows better user control over their data,
/// selective disclosure, and is compliant with eIDAS 2.0.
///
/// PII previously stored in PersonalInfo is now exclusively managed
/// through individual Verifiable Credentials (VCs) linked to this identifier.
@freezed
class DigitalIdentity with _$DigitalIdentity {
  const factory DigitalIdentity({
    /// The unique identifier for this identity, typically a Decentralized Identifier (DID)
    /// or a blockchain address.
    /// This serves as the primary key for the identity on the underlying platform.
    required String identityAddress,

    /// A user-chosen public name or alias associated with the identity.
    /// Typically displayed publicly but does not contain sensitive PII.
    required String displayName,

    /// The timestamp when this identity was first created.
    required DateTime createdAt,

    /// The timestamp of the last modification to this identity.
    required DateTime updatedAt,

    /// The current verification status of the identity, reflecting the level of
    /// trust and verification performed.
    /// This status is often linked to KYC/AML regulatory requirements.
    @Default(IdentityVerificationStatus.unverified)
    IdentityVerificationStatus verificationStatus,
  }) = _DigitalIdentity;

  /// Creates a [DigitalIdentity] instance from a JSON map.
  factory DigitalIdentity.fromJson(Map<String, dynamic> json) =>
      _$DigitalIdentityFromJson(json);
}

/// Defines the different levels of verification status for a [DigitalIdentity].
///
/// The verification status indicates the extent to which the identity has been validated.
/// Higher verification levels often unlock access to more regulated services
/// and are crucial for KYC/AML compliance.
enum IdentityVerificationStatus {
  /// The identity has not undergone any verification.
  /// Limited trust and functionality associated with this status.
  unverified,

  /// Basic verification checks have been completed, such as verifying control
  /// over an email address or phone number.
  /// This may correspond to lower levels of assurance in identity frameworks.
  basicVerified,

  /// A comprehensive identity verification has been successfully completed.
  /// This typically involves verifying government-issued identity documents,
  /// proof of address, and potentially biometric checks.
  /// This level is required for compliance with strict KYC/AML regulations.
  fullyVerified,

  /// The verification process has been initiated but is not yet complete.
  /// The identity is awaiting review or further action.
  pending,

  /// The verification process was attempted but ultimately failed or was rejected
  /// due to inconsistencies, fraudulent documents, or policy violations.
  rejected
}
