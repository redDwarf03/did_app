import 'package:did_app/domain/credential/credential.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qualified_credential.freezed.dart';
part 'qualified_credential.g.dart';

/// Represents the levels of assurance for electronic identification means and trust services
/// as defined by the eIDAS regulation (EU) No 910/2014 and its amendments (eIDAS 2.0).
///
/// These levels indicate the degree of confidence in the claimed identity or the reliability
/// of a trust service.
/// See: eIDAS Regulation, Article 8.
enum AssuranceLevel {
  /// Low level of assurance: Provides a limited degree of confidence.
  low,

  /// Substantial level of assurance: Provides a substantial degree of confidence.
  substantial,

  /// High level of assurance: Provides the highest degree of confidence, requiring stronger
  /// identity proofing and authentication mechanisms.
  high
}

/// Defines the types of qualified electronic signatures or seals according to eIDAS.
///
/// These are used to ensure the authenticity, integrity, and legal value of electronic
/// documents and attestations.
/// See: eIDAS Regulation, Article 3.
enum QualifiedSignatureType {
  /// Qualified Electronic Signature (QES): Created by a natural person, equivalent to a handwritten signature.
  qes,

  /// Qualified Electronic Seal (QSeal): Created by a legal person, ensuring origin and integrity.
  qeseal,

  /// Qualified Website Authentication Certificate (QWAC): Ensures the authenticity and security of websites.
  qwac
}

/// Represents a Qualified Electronic Attestation of Attributes (QEAA) as defined in eIDAS 2.0.
///
/// A QEAA is a specific type of Verifiable Credential that attests to attributes (e.g., name,
/// date of birth, qualifications) and is issued by a Qualified Trust Service Provider (QTSP)
/// under strict regulatory requirements, giving it specific legal effects across the EU.
/// It wraps a base [Credential] and adds metadata related to its qualified status.
/// See: eIDAS 2.0 Regulation (amending Regulation (EU) No 910/2014), especially Articles related to electronic attestations of attributes.
@freezed
class QualifiedCredential with _$QualifiedCredential {
  const factory QualifiedCredential({
    /// The underlying base Verifiable Credential containing the attested attributes.
    required Credential credential,

    /// The eIDAS assurance level associated with the identity verification performed
    /// before issuing this attestation. See [AssuranceLevel]. REQUIRED.
    required AssuranceLevel assuranceLevel,

    /// The type of qualified signature or seal used to secure the attestation.
    /// See [QualifiedSignatureType]. REQUIRED.
    required QualifiedSignatureType signatureType,

    /// Identifier (e.g., URI or DID) for the Qualified Trust Service Provider (QTSP) that issued this QEAA. REQUIRED.
    required String qualifiedTrustServiceProviderId,

    /// The date and time when the QTSP certified or issued this attestation. REQUIRED.
    required DateTime certificationDate,

    /// The date and time when the certification or the underlying qualified certificate expires. REQUIRED.
    required DateTime certificationExpiryDate,

    /// The country (e.g., ISO 3166-1 alpha-2 code) where the QTSP is established and supervised. REQUIRED.
    required String certificationCountry,

    /// URL pointing to the official EU Trust List or a national trusted list where the
    /// QTSP and its qualified status can be verified. REQUIRED.
    required String qualifiedTrustRegistryUrl,

    /// Identifier of the specific qualified certificate used for the signature/seal. REQUIRED.
    required String qualifiedCertificateId,

    /// The specific attributes being attested in a qualified manner.
    /// The structure might depend on the specific attribute schema.
    /// This might overlap with `credential.credentialSubject` but specifies the *qualified* subset. REQUIRED.
    required Map<String, dynamic> qualifiedAttributes,

    /// The qualified electronic signature or seal itself, or a reference to it,
    /// proving the attestation's authenticity and integrity according to eIDAS.
    /// The format depends on the `signatureType`. REQUIRED.
    required String
        qualifiedProof, // Might represent the signature value or a structured proof object
  }) = _QualifiedCredential;

  /// Creates a [QualifiedCredential] instance from a JSON map.
  factory QualifiedCredential.fromJson(Map<String, dynamic> json) =>
      _$QualifiedCredentialFromJson(json);
}

/// Represents information about a Qualified Trust Service Provider (QTSP) as listed
/// in an official EU or national Trust List.
///
/// QTSPs are audited and supervised entities authorized to provide qualified trust services,
/// such as issuing qualified certificates for signatures/seals or issuing QEAAs.
/// See: eIDAS Regulation, Article 3(19) and Article 13.
@freezed
class QualifiedTrustService with _$QualifiedTrustService {
  const factory QualifiedTrustService({
    /// Unique identifier for the QTSP or a specific service it provides (e.g., from the Trust List). REQUIRED.
    required String id,

    /// The official name of the Qualified Trust Service Provider. REQUIRED.
    required String name,

    /// The type of qualified trust service provided (e.g., "QCertForESig", "QCertForESeal", "QCForEAttestOfAttr"). REQUIRED.
    required String type,

    /// The country (e.g., ISO 3166-1 alpha-2 code) where the QTSP is established. REQUIRED.
    required String country,

    /// The current status of the service in the Trust List (e.g., "granted", "withdrawn"). REQUIRED.
    required String status,

    /// The date from which the qualified status is valid. REQUIRED.
    required DateTime startDate,

    /// The date until which the qualified status is valid. OPTIONAL.
    /// (Note: Made optional as service might be active indefinitely).
    DateTime? endDate,

    /// URL for more information about the service or QTSP. REQUIRED.
    required String serviceUrl,

    /// List of identifiers for the qualified certificates associated with this service. REQUIRED.
    required List<String> qualifiedCertificates,

    /// The assurance level associated with the specific trust service offered. REQUIRED.
    required AssuranceLevel assuranceLevel,
  }) = _QualifiedTrustService;

  /// Creates a [QualifiedTrustService] instance from a JSON map.
  factory QualifiedTrustService.fromJson(Map<String, dynamic> json) =>
      _$QualifiedTrustServiceFromJson(json);
}
