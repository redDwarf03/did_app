import 'package:did_app/domain/credential/credential.dart' as cred;
import 'package:did_app/domain/credential/status_list_2021.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Credential Model Tests', () {
    // Sample data for tests
    final now = DateTime.now();
    final expiration = now.add(const Duration(days: 365));
    final issuance = now.subtract(const Duration(days: 10));

    const sampleCredentialSubject = {
      'id': 'did:example:ebfeb1f712ebc6f1c276e12ec21',
      'alumniOf': 'Example University',
    };

    final sampleProof = {
      'type': 'Ed25519Signature2020',
      'created': issuance.toIso8601String(),
      'verificationMethod': 'did:example:issuer123#key-1',
      'proofPurpose': 'assertionMethod',
      'proofValue':
          'z58DAdFfa9SkqZMVPxAQpic7ndSayn1PzZs6ZjWp1CktyGesjuTdwCBZf5DZXd3rSJ3YV72id3w5zdjEzv74xnGx',
    };

    final sampleStatusMap = {
      'id': 'https://example.com/status/1#123',
      'type': 'StatusList2021',
      'statusPurpose': 'revocation',
      'statusListIndex': 123,
      'statusListCredential': 'https://example.com/status/1',
    };

    final sampleSchemaMap = {
      'id': 'https://example.com/schemas/alumni-v1',
      'type': 'JsonSchemaValidator2018',
    };

    final baseCredential = cred.Credential(
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://www.w3.org/2018/credentials/examples/v1',
      ],
      id: 'http://example.edu/credentials/1872',
      type: ['VerifiableCredential', 'AlumniCredential'],
      issuer: 'did:example:issuer123',
      issuanceDate: issuance,
      expirationDate: expiration,
      subject: sampleCredentialSubject['id'],
      credentialSubject: sampleCredentialSubject,
      proof: sampleProof,
      status: sampleStatusMap,
      credentialSchema: sampleSchemaMap,
      name: 'Alumni Credential',
      description: 'Proves alumni status',
    );

    test('Object creation and basic properties', () {
      // Arrange & Act: Object created in `baseCredential`

      // Assert
      expect(baseCredential.id, 'http://example.edu/credentials/1872');
      expect(
        baseCredential.type,
        containsAll(['VerifiableCredential', 'AlumniCredential']),
      );
      expect(baseCredential.issuer, 'did:example:issuer123');
      expect(baseCredential.issuanceDate, issuance);
      expect(baseCredential.expirationDate, expiration);
      expect(baseCredential.subject, 'did:example:ebfeb1f712ebc6f1c276e12ec21');
      expect(baseCredential.credentialSubject, sampleCredentialSubject);
      expect(baseCredential.proof, sampleProof);
      expect(baseCredential.status, sampleStatusMap);
      expect(baseCredential.credentialSchema, sampleSchemaMap);
      expect(baseCredential.name, 'Alumni Credential');
      expect(baseCredential.description, 'Proves alumni status');
      expect(baseCredential.context.length, 2);
    });

    test('copyWith creates a copy with updated fields', () {
      // Arrange
      final newExpiration = expiration.add(const Duration(days: 100));
      final newSubject = {
        'id': 'did:example:ebfeb1f712ebc6f1c276e12ec21',
        'alumniOf': 'Another University',
        'degree': 'BSc',
      };
      final newProof = {
        ...sampleProof,
        'proofValue': 'zNewProofValue...',
      }; // Shallow copy and update

      // Act
      final updatedCredential = baseCredential.copyWith(
        expirationDate: newExpiration,
        credentialSubject: newSubject,
        proof: newProof,
        name: 'Updated Alumni Credential',
      );

      // Assert
      expect(updatedCredential.id, baseCredential.id);
      expect(updatedCredential.type, baseCredential.type);
      expect(updatedCredential.issuer, baseCredential.issuer);
      expect(updatedCredential.issuanceDate, baseCredential.issuanceDate);
      expect(updatedCredential.expirationDate, newExpiration);
      expect(updatedCredential.subject, baseCredential.subject);
      expect(updatedCredential.credentialSubject, newSubject);
      expect(updatedCredential.proof, newProof);
      expect(updatedCredential.status, baseCredential.status);
      expect(
        updatedCredential.credentialSchema,
        baseCredential.credentialSchema,
      );
      expect(updatedCredential.name, 'Updated Alumni Credential');
      expect(updatedCredential.description, baseCredential.description);
    });

    test('copyWith creates an identical copy if no fields are provided', () {
      // Arrange & Act
      final copy = baseCredential.copyWith();

      // Assert
      expect(copy, baseCredential); // Freezed models implement equality
      expect(
        identical(copy, baseCredential),
        false,
      ); // Should be a different instance
    });

    group('Validity based on expiration (isValid getter)', () {
      test('isValid returns true for non-expired credential', () {
        // Check the `isValid` getter
        expect(baseCredential.isValid, isTrue);
      });

      test('isValid returns false if expirationDate is in the past', () {
        final expiredCred = baseCredential.copyWith(
          expirationDate: now.subtract(const Duration(days: 1)),
        );
        // Check the `isValid` getter
        expect(expiredCred.isValid, isFalse);
      });

      test(
          'isValid returns true if expirationDate is null (valid indefinitely)',
          () {
        final nonExpiringCred = baseCredential.copyWith(expirationDate: null);
        // Check the `isValid` getter
        expect(nonExpiringCred.isValid, isTrue);
      });

      // The original verificationStatus field remains unverified by default.
      // Add a test for the actual field value if needed.
      test('verificationStatus field retains default value unless changed', () {
        expect(
          baseCredential.verificationStatus,
          cred.VerificationStatus.unverified,
        );
        final verifiedCred = baseCredential.copyWith(
          verificationStatus: cred.VerificationStatus.verified,
        );
        expect(
          verifiedCred.verificationStatus,
          cred.VerificationStatus.verified,
        );
      });

      // TODO: Add tests for revocation status affecting verificationStatus (or a combined validity getter)
    });

    group('getStatusList2021Entry getter', () {
      test('returns StatusList2021Entry if status type matches', () {
        final entry = baseCredential.getStatusList2021Entry();
        expect(entry, isNotNull);
        expect(entry, isA<StatusList2021Entry>());
        expect(entry!.id, sampleStatusMap['id']);
        expect(entry.statusPurpose.name, sampleStatusMap['statusPurpose']);
        expect(entry.statusListIndex, sampleStatusMap['statusListIndex']);
        expect(
          entry.statusListCredential,
          sampleStatusMap['statusListCredential'],
        );
      });

      test('returns null if status is null', () {
        final credWithoutStatus = baseCredential.copyWith(status: null);
        expect(credWithoutStatus.getStatusList2021Entry(), isNull);
      });

      test('returns null if status type does not match', () {
        final otherStatusMap = {
          'id': 'https://example.com/other/status',
          'type': 'OtherStatusType', // Different type
        };
        final credWithOtherStatus =
            baseCredential.copyWith(status: otherStatusMap);
        expect(credWithOtherStatus.getStatusList2021Entry(), isNull);
      });

      test('returns null if required fields in status are missing', () {
        // Create a map that looks like CredentialStatus but misses required fields for StatusList2021Entry
        final incompleteStatusMap = {
          'id': 'https://example.com/status/incomplete',
          'type': 'StatusList2021', // Type matches
          // Missing statusPurpose, statusListCredential, statusListIndex
        };
        final credWithIncompleteStatus =
            baseCredential.copyWith(status: incompleteStatusMap);
        // The getter performs checks, should return null if fields are missing.
        expect(credWithIncompleteStatus.getStatusList2021Entry(), isNull);
      });
    });

    // Add tests for fromJson/toJson if implemented and needed
    // test('fromJson creates correct object', () { ... });
    // test('toJson creates correct map', () { ... });
  });
}
