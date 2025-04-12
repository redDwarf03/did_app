import 'package:did_app/domain/credential/status_list_2021.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  final issuance = now.subtract(const Duration(days: 1));
  final expiration = now.add(const Duration(days: 60));

  group('StatusList2021Credential Tests', () {
    const subject = StatusList2021Subject(
      id: 'https://example.com/status/1',
      type: 'StatusList2021',
      statusPurpose: StatusPurpose.revocation,
      encodedList: 'HwAAAAAA', // Example: 8 bits, all 0 (base64url)
    );

    final proof = StatusList2021Proof(
      type: 'Ed25519Signature2020',
      created: issuance,
      verificationMethod: 'did:example:issuer-status#keys-1',
      proofPurpose: 'assertionMethod',
      proofValue: 'zStatusProofValue...',
    );

    final baseStatusCredential = StatusList2021Credential(
      id: 'https://example.com/status/1',
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://w3id.org/vc/status-list/2021/v1',
      ],
      type: ['VerifiableCredential', 'StatusList2021Credential'],
      issuer: 'did:example:issuer-status',
      issuanceDate: issuance,
      expirationDate: expiration,
      description: 'Revocation list for batch A',
      credentialSubject: subject,
      proof: proof,
    );

    test('Object creation and basic properties', () {
      expect(baseStatusCredential.id, 'https://example.com/status/1');
      expect(baseStatusCredential.context.length, 2);
      expect(
        baseStatusCredential.type,
        containsAll(['VerifiableCredential', 'StatusList2021Credential']),
      );
      expect(baseStatusCredential.issuer, 'did:example:issuer-status');
      expect(baseStatusCredential.issuanceDate, issuance);
      expect(baseStatusCredential.expirationDate, expiration);
      expect(baseStatusCredential.description, 'Revocation list for batch A');
      expect(baseStatusCredential.credentialSubject, subject);
      expect(baseStatusCredential.proof, proof);
    });

    test('copyWith updates fields correctly', () {
      final newExpiration = expiration.add(const Duration(days: 30));
      final newSubject =
          subject.copyWith(encodedList: 'HwAAAAAB'); // Revoke index 7
      final updatedCred = baseStatusCredential.copyWith(
        expirationDate: newExpiration,
        credentialSubject: newSubject,
      );

      expect(updatedCred.id, baseStatusCredential.id);
      expect(updatedCred.expirationDate, newExpiration);
      expect(updatedCred.credentialSubject, newSubject);
      expect(updatedCred.credentialSubject.encodedList, 'HwAAAAAB');
      expect(updatedCred.issuer, baseStatusCredential.issuer);
    });
  });

  group('StatusList2021Subject Tests', () {
    const baseSubject = StatusList2021Subject(
      id: 'https://example.com/status/2',
      type: 'StatusList2021',
      statusPurpose: StatusPurpose.suspension,
      encodedList: 'HwAGAAgA', // Different example list
    );

    test('Object creation and basic properties', () {
      expect(baseSubject.id, 'https://example.com/status/2');
      expect(baseSubject.type, 'StatusList2021');
      expect(baseSubject.statusPurpose, StatusPurpose.suspension);
      expect(baseSubject.encoding, 'base64url'); // Default
      expect(baseSubject.encodedList, 'HwAGAAgA');
    });

    test('copyWith updates fields correctly', () {
      final updatedSubject = baseSubject.copyWith(
        statusPurpose: StatusPurpose.revocation, // Changed purpose
        encoding: 'base64', // Changed encoding
      );
      expect(updatedSubject.statusPurpose, StatusPurpose.revocation);
      expect(updatedSubject.encoding, 'base64');
      expect(updatedSubject.id, baseSubject.id);
    });
  });

  group('StatusList2021Proof Tests', () {
    final baseProof = StatusList2021Proof(
      type: 'Ed25519Signature2020',
      created: now,
      verificationMethod: 'did:key:zExample#keys-1',
      proofPurpose: 'assertionMethod',
      proofValue: 'zProof...',
    );

    test('Object creation and basic properties', () {
      expect(baseProof.type, 'Ed25519Signature2020');
      expect(baseProof.created, now);
      expect(baseProof.verificationMethod, 'did:key:zExample#keys-1');
      expect(baseProof.proofPurpose, 'assertionMethod');
      expect(baseProof.proofValue, 'zProof...');
    });

    test('copyWith updates fields correctly', () {
      final newTime = now.add(const Duration(seconds: 30));
      final updatedProof =
          baseProof.copyWith(created: newTime, proofValue: 'zNewProof...');
      expect(updatedProof.created, newTime);
      expect(updatedProof.proofValue, 'zNewProof...');
      expect(updatedProof.type, baseProof.type);
    });
  });

  group('StatusList2021Entry Tests', () {
    const baseEntry = StatusList2021Entry(
      id: 'urn:uuid:cred-123#status-5',
      statusPurpose: StatusPurpose.revocation,
      statusListCredential: 'https://example.com/status/list/3',
      statusListIndex: 5,
    );

    test('Object creation and basic properties', () {
      expect(baseEntry.id, 'urn:uuid:cred-123#status-5');
      expect(baseEntry.type, 'StatusList2021'); // Default value
      expect(baseEntry.statusPurpose, StatusPurpose.revocation);
      expect(
        baseEntry.statusListCredential,
        'https://example.com/status/list/3',
      );
      expect(baseEntry.statusListIndex, 5);
    });

    test('copyWith updates fields correctly', () {
      final updatedEntry = baseEntry.copyWith(
        statusListIndex: 6,
        statusPurpose: StatusPurpose.suspension, // Example change
      );
      expect(updatedEntry.statusListIndex, 6);
      expect(updatedEntry.statusPurpose, StatusPurpose.suspension);
      expect(updatedEntry.id, baseEntry.id);
    });
  });

  group('StatusPurpose Enum Tests', () {
    test('Enum values exist', () {
      expect(
        StatusPurpose.values,
        containsAll([
          StatusPurpose.revocation,
          StatusPurpose.suspension,
        ]),
      );
    });
  });
}
