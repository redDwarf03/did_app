import 'package:did_app/domain/credential/credential.dart' as cred;
import 'package:did_app/domain/credential/qualified_credential.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Sample data reused across tests
  final now = DateTime.now();
  final certDate = now.subtract(const Duration(days: 10));
  final certExpiry = now.add(const Duration(days: 355));
  final issuance = now.subtract(const Duration(days: 15));

  // Base Credential for QualifiedCredential tests
  final baseCredential = cred.Credential(
    id: 'urn:uuid:cred-1',
    type: ['VerifiableCredential', 'UniversityDegree'],
    issuer: 'did:example:uni',
    issuanceDate: issuance,
    credentialSubject: {
      'id': 'did:example:student1',
      'degree': {'type': 'BachelorDegree', 'name': 'Computer Science'},
    },
    proof: {
      'type': 'Ed25519Signature2020', /* ... other proof fields */
    },
  );

  group('QualifiedCredential Model Tests', () {
    final baseQualifiedCredential = QualifiedCredential(
      credential: baseCredential,
      assuranceLevel: AssuranceLevel.high,
      signatureType: QualifiedSignatureType.qeseal,
      qualifiedTrustServiceProviderId: 'did:example:qtsp1',
      certificationDate: certDate,
      certificationExpiryDate: certExpiry,
      certificationCountry: 'BE',
      qualifiedTrustRegistryUrl:
          'https://webgate.ec.europa.eu/tl-browser/#/tl/BE',
      qualifiedCertificateId: 'cert-id-123',
      qualifiedAttributes: {
        'degree': {'type': 'BachelorDegree', 'name': 'Computer Science'},
      },
      qualifiedProof: 'zQSealSignatureValue...',
    );

    test('Object creation and basic properties', () {
      expect(baseQualifiedCredential.credential, baseCredential);
      expect(baseQualifiedCredential.assuranceLevel, AssuranceLevel.high);
      expect(
        baseQualifiedCredential.signatureType,
        QualifiedSignatureType.qeseal,
      );
      expect(
        baseQualifiedCredential.qualifiedTrustServiceProviderId,
        'did:example:qtsp1',
      );
      expect(baseQualifiedCredential.certificationDate, certDate);
      expect(baseQualifiedCredential.certificationExpiryDate, certExpiry);
      expect(baseQualifiedCredential.certificationCountry, 'BE');
      expect(baseQualifiedCredential.qualifiedTrustRegistryUrl, isNotNull);
      expect(baseQualifiedCredential.qualifiedCertificateId, 'cert-id-123');
      expect(
        baseQualifiedCredential.qualifiedAttributes.containsKey('degree'),
        isTrue,
      );
      expect(baseQualifiedCredential.qualifiedProof, 'zQSealSignatureValue...');
    });

    test('copyWith updates fields correctly', () {
      const newLevel = AssuranceLevel.substantial;
      final newExpiry = certExpiry.add(const Duration(days: 5));
      final updatedQualCred = baseQualifiedCredential.copyWith(
        assuranceLevel: newLevel,
        certificationExpiryDate: newExpiry,
      );

      expect(updatedQualCred.assuranceLevel, newLevel);
      expect(updatedQualCred.certificationExpiryDate, newExpiry);
      // Check unchanged fields remain the same
      expect(updatedQualCred.credential, baseQualifiedCredential.credential);
      expect(
        updatedQualCred.signatureType,
        baseQualifiedCredential.signatureType,
      );
    });
  });

  group('QualifiedTrustService Model Tests', () {
    final baseTrustService = QualifiedTrustService(
      id: 'service-id-1',
      name: 'Example QTSP Service',
      type: 'QCertForESeal',
      country: 'DE',
      status: 'granted',
      startDate: certDate,
      endDate: certExpiry,
      serviceUrl: 'https://example-qtsp.com/service-info',
      qualifiedCertificates: ['cert-id-123', 'cert-id-456'],
      assuranceLevel: AssuranceLevel.high,
    );

    test('Object creation and basic properties', () {
      expect(baseTrustService.id, 'service-id-1');
      expect(baseTrustService.name, 'Example QTSP Service');
      expect(baseTrustService.type, 'QCertForESeal');
      expect(baseTrustService.country, 'DE');
      expect(baseTrustService.status, 'granted');
      expect(baseTrustService.startDate, certDate);
      expect(baseTrustService.endDate, certExpiry);
      expect(baseTrustService.serviceUrl, isNotNull);
      expect(
        baseTrustService.qualifiedCertificates,
        containsAll(['cert-id-123', 'cert-id-456']),
      );
      expect(baseTrustService.assuranceLevel, AssuranceLevel.high);
    });

    test('copyWith updates fields correctly', () {
      const newStatus = 'withdrawn';
      final newEndDate = now;
      final updatedService = baseTrustService.copyWith(
        status: newStatus,
        endDate: newEndDate,
        assuranceLevel: AssuranceLevel.low,
      );

      expect(updatedService.status, newStatus);
      expect(updatedService.endDate, newEndDate);
      expect(updatedService.assuranceLevel, AssuranceLevel.low);
      // Check unchanged fields
      expect(updatedService.id, baseTrustService.id);
      expect(updatedService.name, baseTrustService.name);
    });

    test('copyWith handles optional endDate', () {
      final serviceWithoutEndDate = baseTrustService.copyWith(endDate: null);
      expect(serviceWithoutEndDate.endDate, isNull);

      final serviceWithEndDate =
          serviceWithoutEndDate.copyWith(endDate: certExpiry);
      expect(serviceWithEndDate.endDate, certExpiry);
    });
  });

  group('AssuranceLevel Enum Tests', () {
    test('Enum values exist', () {
      expect(
        AssuranceLevel.values,
        containsAll([
          AssuranceLevel.low,
          AssuranceLevel.substantial,
          AssuranceLevel.high,
        ]),
      );
    });
  });

  group('QualifiedSignatureType Enum Tests', () {
    test('Enum values exist', () {
      expect(
        QualifiedSignatureType.values,
        containsAll([
          QualifiedSignatureType.qes,
          QualifiedSignatureType.qeseal,
          QualifiedSignatureType.qwac,
        ]),
      );
    });
  });
}
