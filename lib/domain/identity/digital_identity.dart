import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_identity.freezed.dart';
part 'digital_identity.g.dart';

/// Represents a user's comprehensive digital identity profile within the application.
///
/// This class encapsulates the core attributes of a digital identity, including
/// identifiers, public information, sensitive personal details (intended to be stored securely,
/// potentially encrypted), and verification status. It aligns with concepts found in
/// Self-Sovereign Identity (SSI) systems.
///
/// **Distinction:** While related to the W3C concept of a DID Subject, this class primarily serves
/// as the application's internal, detailed representation of the user's full profile.
/// It includes sensitive Personally Identifiable Information (PII) stored in [PersonalInfo],
/// often necessary for Know Your Customer (KYC) procedures, which are typically *not* directly
/// published in a standard, publicly resolvable W3C DID Document.
///
/// Handling of data within this model, especially `personalInfo`, must comply with
/// data privacy regulations such as GDPR.
@freezed
class DigitalIdentity with _$DigitalIdentity {
  const factory DigitalIdentity({
    /// The unique identifier for this identity, often a Decentralized Identifier (DID)
    /// or a blockchain address.
    /// This serves as the primary key for the identity on the underlying platform.
    required String identityAddress,

    /// A user-chosen public name or alias associated with the identity.
    /// This is typically displayed publicly.
    required String displayName,

    /// Contains sensitive Personally Identifiable Information (PII).
    /// **Security Critical:** This data must be handled with extreme care, typically
    /// stored encrypted at rest and transmitted securely. Its processing is subject
    /// to strict privacy regulations like GDPR.
    /// See [PersonalInfo] for details.
    required PersonalInfo personalInfo,

    /// The timestamp when this identity was first created or registered.
    required DateTime createdAt,

    /// The timestamp of the last modification to any attribute of this identity.
    required DateTime updatedAt,

    /// The current verification status of the identity, reflecting the level of
    /// trust and checks performed. See [IdentityVerificationStatus].
    /// This status is often linked to KYC/AML regulatory requirements.
    @Default(IdentityVerificationStatus.unverified)
    IdentityVerificationStatus verificationStatus,
  }) = _DigitalIdentity;

  /// Creates a [DigitalIdentity] instance from a JSON map.
  factory DigitalIdentity.fromJson(Map<String, dynamic> json) =>
      _$DigitalIdentityFromJson(json);
}

/// Represents the collection of Personally Identifiable Information (PII)
/// associated with a [DigitalIdentity].
///
/// **Compliance Note:** All data within this class is considered sensitive under
/// regulations like GDPR. Ensure proper consent mechanisms, purpose limitation,
/// data minimization, and security measures (like encryption) are implemented
/// when handling this information.
@freezed
class PersonalInfo with _$PersonalInfo {
  const factory PersonalInfo({
    /// The user's full legal name. Often required for KYC processes.
    required String fullName,

    /// The user's primary email address. Commonly used for communication and
    /// basic verification.
    required String email,

    /// The user's phone number, including the country code (e.g., +1, +44).
    /// Often used for multi-factor authentication or basic verification.
    String? phoneNumber,

    /// The user's date of birth. Critical for age verification and KYC compliance.
    DateTime? dateOfBirth,

    /// The user's nationality, typically represented by a country name or code (e.g., ISO 3166-1 alpha-2).
    /// Often required for KYC/AML checks.
    String? nationality,

    /// The user's physical residential address. See [PhysicalAddress].
    /// Required for higher levels of identity verification (KYC).
    PhysicalAddress? address,
  }) = _PersonalInfo;

  /// Creates a [PersonalInfo] instance from a JSON map.
  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);
}

/// Represents a physical address.
///
/// This information is often required for Know Your Customer (KYC) and
/// Anti-Money Laundering (AML) compliance checks to verify residency.
/// Like other PII, it falls under GDPR and similar privacy regulations.
@freezed
class PhysicalAddress with _$PhysicalAddress {
  const factory PhysicalAddress({
    /// The street name and number, potentially including apartment or unit details.
    required String street,

    /// The name of the city or town.
    required String city,

    /// The state, province, region, or county, depending on the country's structure.
    String? state,

    /// The postal code or ZIP code used for mail delivery.
    required String postalCode,

    /// The country, ideally represented using ISO 3166-1 alpha-2 codes (e.g., "US", "GB", "FR").
    required String country,
  }) = _PhysicalAddress;

  /// Creates a [PhysicalAddress] instance from a JSON map.
  factory PhysicalAddress.fromJson(Map<String, dynamic> json) =>
      _$PhysicalAddressFromJson(json);
}

/// Defines the different levels of verification status for a [DigitalIdentity].
///
/// The verification status indicates the extent to which the identity's associated
/// information (especially PII) has been validated. Higher verification levels
/// often unlock access to more regulated services and are crucial for KYC/AML compliance.
/// The specific requirements for each level may vary based on jurisdiction and service provider policies.
enum IdentityVerificationStatus {
  /// The identity has not undergone any verification checks.
  /// Limited trust and functionality typically associated with this status.
  unverified,

  /// Basic verification checks have been completed, such as verifying control
  /// over an email address or phone number.
  /// This might correspond to lower levels of assurance (LoA) in identity frameworks (e.g., NIST LoA1).
  basicVerified,

  /// Comprehensive identity verification has been successfully completed.
  /// This typically involves verifying government-issued identity documents,
  /// proof of address, and potentially biometric checks.
  /// This level is required for compliance with strict KYC/AML regulations
  /// (e.g., those mandated by FATF, MiCA, or local financial authorities).
  /// Corresponds to higher levels of assurance (e.g., NIST LoA2 or LoA3, eIDAS Substantial or High).
  fullyVerified,

  /// The verification process has been initiated but is not yet complete.
  /// The identity is awaiting review or further action.
  pending,

  /// The verification process was attempted but ultimately failed or was rejected
  /// due to inconsistencies, fraudulent documents, or policy violations.
  rejected
}
