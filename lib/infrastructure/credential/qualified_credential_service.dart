import 'dart:async';
import 'dart:convert';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/qualified_credential.dart';
import 'package:did_app/domain/verification/verification_result.dart' as domain;
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:http/http.dart' as http;

/// Status of an issuer in the trust registry.
class IssuerStatus {
  const IssuerStatus({
    required this.isQualified,
    this.assuranceLevel,
    this.validityPeriod,
  });

  factory IssuerStatus.fromJson(Map<String, dynamic> json) {
    return IssuerStatus(
      isQualified: json['isQualified'] as bool,
      assuranceLevel: json['assuranceLevel'] as String?,
      validityPeriod: json['validityPeriod'] != null
          ? DateTimeRange.fromJson(json['validityPeriod'])
          : null,
    );
  }

  final bool isQualified;
  final String? assuranceLevel;
  final DateTimeRange? validityPeriod;
}

/// Represents a date/time range.
class DateTimeRange {
  const DateTimeRange({
    required this.start,
    required this.end,
  });

  factory DateTimeRange.fromJson(Map<String, dynamic> json) {
    return DateTimeRange(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );
  }

  final DateTime start;
  final DateTime end;
}

/// Service for managing eIDAS 2.0 qualified credentials.
class QualifiedCredentialService {
  QualifiedCredentialService({
    http.Client? httpClient,
    String? trustRegistryUrl,
    EidasTrustList? trustList,
  })  : _httpClient = httpClient ?? http.Client(),
        _trustRegistryUrl =
            trustRegistryUrl ?? 'https://eu-trust-registry.europa.eu/api/v1',
        _trustList = trustList ?? EidasTrustList.instance;

  final http.Client _httpClient;
  final String _trustRegistryUrl;
  final EidasTrustList _trustList;

  // Cache for verification results to improve performance
  final Map<String, IssuerStatus> _issuerStatusCache = {};
  final Map<String, QualifiedTrustService> _trustServiceCache = {};

  /// Checks if a credential meets the criteria for being eIDAS 2.0 qualified.
  Future<bool> isQualified(Credential credential) async {
    try {
      // 1. Check if the credential has a proof
      if (credential.proof.isEmpty) return false;

      // 2. Check if the issuer is listed in a qualified trust registry
      final issuerStatus = await _checkIssuerStatus(credential.issuer);
      if (!issuerStatus.isQualified) return false;

      // 3. Verify the signature's validity
      final signatureValid = await _verifySignature(credential);
      if (!signatureValid) return false;

      // 4. Check if the schema conforms to eIDAS standards
      final schemaValid = _validateEidasSchema(credential);
      if (!schemaValid) return false;

      return true;
    } catch (e) {
      // In case of exception, the credential is not considered qualified
      // TODO: Log the error
      return false;
    }
  }

  /// Determines the Level of Assurance (LoA) for a qualified credential.
  Future<AssuranceLevel> determineAssuranceLevel(Credential credential) async {
    // If the credential is not qualified, return low level by default
    if (!await isQualified(credential)) {
      return AssuranceLevel.low;
    }

    // Retrieve trust service information
    final trustService = await _getTrustService(credential.issuer);
    if (trustService == null) {
      return AssuranceLevel
          .low; // Default to low if trust service info is unavailable
    }

    // Check for specific attributes indicating high level
    final hasHighLevelAttributes = _checkHighLevelAttributes(credential);
    if (trustService.assuranceLevel == AssuranceLevel.high &&
        hasHighLevelAttributes) {
      return AssuranceLevel.high;
    }

    // Check for attributes indicating substantial level
    final hasSubstantialAttributes = _checkSubstantialAttributes(credential);
    if ((trustService.assuranceLevel == AssuranceLevel.high ||
            trustService.assuranceLevel == AssuranceLevel.substantial) &&
        hasSubstantialAttributes) {
      return AssuranceLevel.substantial;
    }

    // Default to the trust service's declared assurance level
    return trustService.assuranceLevel;
  }

  /// Converts a standard credential into a qualified credential if possible.
  Future<QualifiedCredential?> qualifyCredential(Credential credential) async {
    // Check if the credential can be qualified
    if (!await isQualified(credential)) return null;

    // Retrieve qualified trust service information
    final trustService = await _getTrustService(credential.issuer);
    if (trustService == null) return null;

    // Determine the actual assurance level
    final actualAssuranceLevel = await determineAssuranceLevel(credential);

    return QualifiedCredential(
      credential: credential,
      assuranceLevel: actualAssuranceLevel,
      signatureType:
          _determineSignatureType(credential), // TODO: Implement this method
      qualifiedTrustServiceProviderId: trustService.id,
      certificationDate: trustService.startDate,
      certificationExpiryDate: trustService.endDate ??
          DateTime.now()
              .add(const Duration(days: 365 * 2)), // Handle null endDate
      certificationCountry: trustService.country,
      qualifiedTrustRegistryUrl: _trustRegistryUrl,
      // Assuming the first certificate listed is the relevant one
      qualifiedCertificateId: trustService.qualifiedCertificates.isNotEmpty
          ? trustService.qualifiedCertificates.first
          : '', // Handle case where no certificate ID is found
      qualifiedAttributes: _extractQualifiedAttributes(
          credential), // TODO: Implement this method
      qualifiedProof: credential.proof['proofValue'] as String? ?? '',
    );
  }

  /// Verifies the conformity of a qualified credential.
  Future<domain.VerificationResult> verifyQualifiedCredential(
    QualifiedCredential qualifiedCredential,
  ) async {
    try {
      // 1. Verify the base credential qualification criteria
      final isValidBase = await isQualified(qualifiedCredential.credential);
      if (!isValidBase) {
        return domain.VerificationResult(
          isValid: false,
          message: 'Credential does not meet eIDAS qualification criteria',
        );
      }

      // 2. Verify the validity of the qualified certificate used
      final isCertificateValid = await _verifyQualifiedCertificate(
        qualifiedCredential.qualifiedCertificateId,
        qualifiedCredential.qualifiedTrustServiceProviderId,
      );

      if (!isCertificateValid) {
        return domain.VerificationResult(
          isValid: false,
          message: 'The qualified certificate is invalid or expired',
        );
      }

      // 3. Verify the qualified signature
      final isSignatureValid = await _verifyQualifiedSignature(
        qualifiedCredential.credential,
        qualifiedCredential.qualifiedProof,
        qualifiedCredential.signatureType,
      );

      if (!isSignatureValid) {
        return domain.VerificationResult(
          isValid: false,
          message: 'The qualified signature is invalid',
        );
      }

      // 4. Check the validity period of the certification
      final now = DateTime.now();
      if (now.isAfter(qualifiedCredential.certificationExpiryDate)) {
        return domain.VerificationResult(
          isValid: false,
          message:
              'Certification expired on ${_formatDate(qualifiedCredential.certificationExpiryDate)}',
        );
      }

      // 5. Check if the certification has been revoked
      final isRevoked = await _checkCertificationRevocation(
        qualifiedCredential.qualifiedCertificateId,
      );

      if (isRevoked) {
        return domain.VerificationResult(
          isValid: false,
          message: 'Certification has been revoked',
        );
      }

      // All checks passed
      // TODO: Consider adding verified details to the result message or a dedicated field
      return domain.VerificationResult(
        isValid: true,
        message: 'Qualified credential verified successfully',
        // details: {
        //   'assuranceLevel': qualifiedCredential.assuranceLevel.toString(),
        //   'signatureType': qualifiedCredential.signatureType.toString(),
        //   'country': qualifiedCredential.certificationCountry,
        //   'provider': qualifiedCredential.qualifiedTrustServiceProviderId,
        // },
      );
    } catch (e) {
      // TODO: Log the error
      return domain.VerificationResult(
        isValid: false,
        message: 'Error during qualified credential verification: $e',
      );
    }
  }

  /// Synchronizes with the European Trust List Registry.
  /// TODO: Implement actual synchronization logic.
  Future<void> syncTrustRegistry() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // In a real implementation, this would fetch the latest trust list
    // from _trustRegistryUrl and update the local _trustList cache/database.
    print('Trust registry synchronization simulated.');
  }

  // --- Private Helper Methods --- //

  /// Checks the status of an issuer against the trust registry (with caching).
  Future<IssuerStatus> _checkIssuerStatus(String issuerDid) async {
    if (_issuerStatusCache.containsKey(issuerDid)) {
      return _issuerStatusCache[issuerDid]!;
    }

    // Simulate API call to trust registry
    await Future.delayed(const Duration(milliseconds: 400));
    // Use the correct method name from EidasTrustList
    final isQualified = await _trustList.isIssuerTrusted(issuerDid);
    // Mock assurance level retrieval for now
    final mockIssuer = await _trustList.getTrustedIssuer(issuerDid);
    // Use local helper to convert enum to string
    final assuranceLevelString = mockIssuer != null
        ? _mapTrustLevelToString(mockIssuer.trustLevel)
        : null;

    // TODO: Fetch validity period from registry if available
    final status = IssuerStatus(
      isQualified: isQualified,
      assuranceLevel: assuranceLevelString,
    );

    _issuerStatusCache[issuerDid] = status;
    return status;
  }

  /// Helper to convert TrustLevel enum to string representation.
  String? _mapTrustLevelToString(TrustLevel? level) {
    if (level == null) return null;
    switch (level) {
      case TrustLevel.low:
        return 'low';
      case TrustLevel.substantial:
        return 'substantial';
      case TrustLevel.high:
        return 'high';
    }
  }

  /// Verifies the credential's signature (mock implementation).
  /// TODO: Implement actual cryptographic signature verification.
  Future<bool> _verifySignature(Credential credential) async {
    // Simulate verification delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real implementation: resolve issuer DID, get key, verify proof.
    return credential.proof.containsKey('proofValue'); // Basic mock check
  }

  /// Validates the credential schema against eIDAS requirements (mock implementation).
  /// TODO: Implement actual schema validation logic.
  bool _validateEidasSchema(Credential credential) {
    // Simulate schema check
    // A real check would validate credential.credentialSchema against known eIDAS schemas.
    final schema = credential.credentialSchema;
    return schema != null && schema.containsKey('id'); // Basic mock check
  }

  /// Retrieves trust service details for an issuer DID (with caching).
  Future<QualifiedTrustService?> _getTrustService(String issuerDid) async {
    if (_trustServiceCache.containsKey(issuerDid)) {
      return _trustServiceCache[issuerDid]!;
    }

    // Simulate API call or lookup in local trust list
    await Future.delayed(const Duration(milliseconds: 200));
    final trustedIssuer = await _trustList.getTrustedIssuer(issuerDid);
    if (trustedIssuer != null) {
      // Map TrustedIssuer to QualifiedTrustService (assuming structure matches)
      // This mapping might need adjustment based on actual data models
      final service = QualifiedTrustService(
        id: trustedIssuer.did,
        name: trustedIssuer.name,
        type: trustedIssuer.serviceType,
        country: trustedIssuer.country,
        status: 'active', // Mock status
        startDate:
            DateTime.now().subtract(const Duration(days: 365)), // Mock date
        endDate: trustedIssuer.validUntil, // Use validUntil from TrustedIssuer
        serviceUrl: '', // Mock URL
        qualifiedCertificates: [], // Mock certificates list
        assuranceLevel:
            _mapTrustLevelToAssuranceLevel(trustedIssuer.trustLevel),
      );
      _trustServiceCache[issuerDid] = service;
      return service;
    }
    return null;
  }

  AssuranceLevel _mapTrustLevelToAssuranceLevel(TrustLevel level) {
    switch (level) {
      case TrustLevel.low:
        return AssuranceLevel.low;
      case TrustLevel.substantial:
        return AssuranceLevel.substantial;
      case TrustLevel.high:
        return AssuranceLevel.high;
      default:
        return AssuranceLevel.low;
    }
  }

  /// Checks for attributes typically associated with high assurance level (mock).
  /// TODO: Implement specific checks based on credential subject data.
  bool _checkHighLevelAttributes(Credential credential) {
    // Simulate check - e.g., presence of verified biometric data link
    return credential.credentialSubject
        .containsKey('verifiedBiometricReference');
  }

  /// Checks for attributes typically associated with substantial assurance level (mock).
  /// TODO: Implement specific checks based on credential subject data.
  bool _checkSubstantialAttributes(Credential credential) {
    // Simulate check - e.g., presence of verified ID document number
    return credential.credentialSubject.containsKey('idDocumentNumber');
  }

  /// Determines the signature type used (mock implementation).
  /// TODO: Implement logic to parse proof type.
  QualifiedSignatureType _determineSignatureType(Credential credential) {
    final proofType = credential.proof['type'] as String?;
    if (proofType?.contains('Seal') ?? false) {
      return QualifiedSignatureType.qeseal;
    } else if (proofType?.contains('Wac') ?? false) {
      return QualifiedSignatureType.qwac;
    }
    // Default to QES for other signature types in mock
    return QualifiedSignatureType.qes;
  }

  /// Verifies the qualified certificate validity (mock implementation).
  /// TODO: Implement actual certificate chain validation and revocation check (OCSP/CRL).
  Future<bool> _verifyQualifiedCertificate(
      String certificateId, String tspId) async {
    // Simulate check against trust list / registry
    await Future.delayed(const Duration(milliseconds: 350));
    // Use the correct method name from EidasTrustList (assuming it exists)
    // For mock, assume valid if certificateId is not empty
    // TODO: Find appropriate method in EidasTrustList or mock logic differently
    // return await _trustList.isCertificateValid(certificateId, tspId);
    return certificateId.isNotEmpty;
  }

  /// Verifies the qualified signature (mock implementation).
  /// TODO: Implement actual cryptographic verification using qualified certificate.
  Future<bool> _verifyQualifiedSignature(Credential credential,
      String proofValue, QualifiedSignatureType signatureType) async {
    // Simulate verification
    await Future.delayed(const Duration(milliseconds: 500));
    return proofValue.isNotEmpty; // Basic mock check
  }

  /// Checks certification revocation status (mock implementation).
  /// TODO: Implement OCSP or CRL check for the certificate.
  Future<bool> _checkCertificationRevocation(String certificateId) async {
    // Simulate revocation check
    await Future.delayed(const Duration(milliseconds: 450));
    // Assume not revoked in mock
    return false;
  }

  /// Formats a DateTime object for display.
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    // Simple date formatting, adjust as needed
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Extracts qualified attributes from a credential (mock).
  /// TODO: Implement actual logic based on schema or policy.
  Map<String, dynamic> _extractQualifiedAttributes(Credential credential) {
    // For mock purposes, return a subset of credentialSubject
    final qualified = <String, dynamic>{};
    final subject = credential.credentialSubject;
    if (subject.containsKey('firstName'))
      qualified['firstName'] = subject['firstName'];
    if (subject.containsKey('lastName'))
      qualified['lastName'] = subject['lastName'];
    if (subject.containsKey('dateOfBirth'))
      qualified['dateOfBirth'] = subject['dateOfBirth'];
    return qualified;
  }
}
