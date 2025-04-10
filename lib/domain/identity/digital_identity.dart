import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_identity.freezed.dart';
part 'digital_identity.g.dart';

/// Represents a digital identity stored on the Archethic blockchain
@freezed
class DigitalIdentity with _$DigitalIdentity {
  const factory DigitalIdentity({
    /// Unique identifier of the identity on the blockchain
    required String identityAddress,

    /// The public name of the identity
    required String displayName,

    /// Personal information (encrypted when stored)
    required PersonalInfo personalInfo,

    /// Creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// Verification status of the identity
    @Default(IdentityVerificationStatus.unverified)
    IdentityVerificationStatus verificationStatus,
  }) = _DigitalIdentity;

  factory DigitalIdentity.fromJson(Map<String, dynamic> json) =>
      _$DigitalIdentityFromJson(json);
}

/// Personal information related to the digital identity
@freezed
class PersonalInfo with _$PersonalInfo {
  const factory PersonalInfo({
    /// Full legal name
    required String fullName,

    /// Email address
    required String email,

    /// Phone number with country code
    String? phoneNumber,

    /// Date of birth
    DateTime? dateOfBirth,

    /// Nationality
    String? nationality,

    /// Physical address
    PhysicalAddress? address,
  }) = _PersonalInfo;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);
}

/// Physical address information
@freezed
class PhysicalAddress with _$PhysicalAddress {
  const factory PhysicalAddress({
    /// Street address including number
    required String street,

    /// City name
    required String city,

    /// State/province/region
    String? state,

    /// Postal/ZIP code
    required String postalCode,

    /// Country
    required String country,
  }) = _PhysicalAddress;

  factory PhysicalAddress.fromJson(Map<String, dynamic> json) =>
      _$PhysicalAddressFromJson(json);
}

/// Verification status of the identity
enum IdentityVerificationStatus {
  /// Not verified at all
  unverified,

  /// Basic level verification (email, phone)
  basicVerified,

  /// Full KYC verification completed
  fullyVerified,

  /// Verification in progress
  pending,

  /// Verification rejected
  rejected
}
