import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EidasCredential Model Tests', () {
    final now = DateTime.now();
    final issuance = now.subtract(const Duration(days: 5));
    final expiration = now.add(const Duration(days: 360));

    const sampleSubject = {
      'id': 'did:example:holder1',
      'givenName': 'Alice',
      'familyName': 'Wonderland',
      'nationality': 'Fantasy Land'
    };

    final sampleIssuer = EidasIssuer(
      id: 'did:example:issuer123',
      name: 'Example Issuer Authority',
    );

    final sampleSchema = EidasCredentialSchema(
      id: 'https://example.com/schemas/eidas/VerifiableId/v1',
      type: 'JsonSchemaValidator2018',
    );

    final sampleStatus = EidasCredentialStatus(
      id: 'https://example.com/status/eidas/1#5',
      type: 'StatusList2021',
      statusListCredential: 'https://example.com/status/eidas/1',
      statusListIndex: 5,
    );

    final sampleProof = EidasProof(
      type: 'Ed25519Signature2020',
      created: issuance,
      verificationMethod: 'did:example:issuer123#keys-1',
      proofPurpose: 'assertionMethod',
      proofValue: 'zSignatureValue...',
    );

    final sampleEvidence = EidasEvidence(
      type: 'DocumentVerification',
      verifier: 'did:example:verifier456',
      evidenceDocument: ['passport.pdf'],
      subjectPresence: 'Physical',
    );

    final baseEidasCredential = EidasCredential(
      id: 'urn:uuid:12345678-1234-5678-1234-567812345678',
      type: ['VerifiableCredential', 'VerifiableId'],
      issuer: sampleIssuer,
      issuanceDate: issuance,
      expirationDate: expiration,
      credentialSubject: sampleSubject,
      credentialSchema: sampleSchema,
      credentialStatus: sampleStatus,
      proof: sampleProof,
      evidence: [sampleEvidence],
    );

    test('Object creation and basic properties', () {
      expect(baseEidasCredential.id,
          'urn:uuid:12345678-1234-5678-1234-567812345678');
      expect(baseEidasCredential.type,
          containsAll(['VerifiableCredential', 'VerifiableId']));
      expect(baseEidasCredential.issuer, sampleIssuer);
      expect(baseEidasCredential.issuanceDate, issuance);
      expect(baseEidasCredential.expirationDate, expiration);
      expect(baseEidasCredential.credentialSubject, sampleSubject);
      expect(baseEidasCredential.credentialSchema, sampleSchema);
      expect(baseEidasCredential.credentialStatus, sampleStatus);
      expect(baseEidasCredential.proof, sampleProof);
      expect(baseEidasCredential.evidence, contains(sampleEvidence));
    });

    test('copyWith updates fields correctly', () {
      final newExpiration = expiration.add(const Duration(days: 10));
      final newSubject = {...sampleSubject, 'familyName': 'UpdatedWonderland'};
      final updatedCred = baseEidasCredential.copyWith(
        expirationDate: newExpiration,
        credentialSubject: newSubject,
      );

      expect(updatedCred.expirationDate, newExpiration);
      expect(updatedCred.credentialSubject['familyName'], 'UpdatedWonderland');
      // Check unchanged fields remain the same
      expect(updatedCred.id, baseEidasCredential.id);
      expect(updatedCred.issuer, baseEidasCredential.issuer);
    });

    test('toCredential converts correctly', () {
      final credential = baseEidasCredential.toCredential();

      expect(credential, isA<Credential>());
      expect(credential.id, baseEidasCredential.id);
      expect(credential.type, baseEidasCredential.type);
      expect(credential.issuer, baseEidasCredential.issuer.id);
      expect(credential.issuanceDate, baseEidasCredential.issuanceDate);
      expect(credential.expirationDate, baseEidasCredential.expirationDate);
      expect(
          credential.credentialSubject, baseEidasCredential.credentialSubject);
      expect(credential.subject, baseEidasCredential.credentialSubject['id']);
      expect(
          credential.context,
          containsAll([
            'https://www.w3.org/2018/credentials/v1',
            'https://ec.europa.eu/2023/credentials/eidas/v1',
          ]));
      // Check conversion of nested objects to maps
      expect(credential.proof, baseEidasCredential.proof?.toJson());
      expect(credential.status, baseEidasCredential.credentialStatus?.toJson());
      expect(credential.credentialSchema,
          baseEidasCredential.credentialSchema?.toJson());
      expect(credential.name,
          'eIDAS Digital Identity'); // Based on type 'VerifiableId'
      expect(credential.supportsZkp, isTrue);
    });

    test('_getReadableName returns correct names', () {
      final idCred = baseEidasCredential
          .copyWith(type: ['VerifiableCredential', 'VerifiableId']);
      final attCred = baseEidasCredential
          .copyWith(type: ['VerifiableCredential', 'VerifiableAttestation']);
      final dipCred = baseEidasCredential
          .copyWith(type: ['VerifiableCredential', 'VerifiableDiploma']);
      final authCred = baseEidasCredential
          .copyWith(type: ['VerifiableCredential', 'VerifiableAuthorisation']);
      final otherCred = baseEidasCredential
          .copyWith(type: ['VerifiableCredential', 'OtherType']);

      expect(idCred.toCredential().name, 'eIDAS Digital Identity');
      expect(attCred.toCredential().name, 'eIDAS Verifiable Attestation');
      expect(dipCred.toCredential().name, 'Verifiable Diploma');
      expect(authCred.toCredential().name, 'eIDAS Authorisation');
      expect(otherCred.toCredential().name, 'VerifiableCredential, OtherType');
    });
  });

  group('EidasIssuer Tests', () {
    test('fromJson handles string input', () {
      const issuerId = 'did:example:issuer-string';
      final issuer = EidasIssuer.fromJson(issuerId);
      expect(issuer.id, issuerId);
      expect(issuer.name, isNull);
    });

    test('fromJson handles map input', () {
      final issuerMap = {
        'id': 'did:example:issuer-map',
        'name': 'Map Issuer Name',
        'image': 'http://example.com/logo.png'
      };
      final issuer = EidasIssuer.fromJson(issuerMap);
      expect(issuer.id, 'did:example:issuer-map');
      expect(issuer.name, 'Map Issuer Name');
      expect(issuer.image, 'http://example.com/logo.png');
    });

    test('fromJson throws on invalid input type', () {
      expect(() => EidasIssuer.fromJson(123), throwsFormatException);
      expect(() => EidasIssuer.fromJson(['list']), throwsFormatException);
    });
  });

  // Add similar small test groups for EidasCredentialSchema, EidasCredentialStatus, EidasProof, EidasEvidence
  group('EidasCredentialSchema Tests', () {
    test('Object creation works', () {
      final schema = EidasCredentialSchema(id: 'schema-id', type: 'SchemaType');
      expect(schema.id, 'schema-id');
      expect(schema.type, 'SchemaType');
    });
  });

  group('EidasCredentialStatus Tests', () {
    test('Object creation works', () {
      final status = EidasCredentialStatus(id: 'status-id', type: 'StatusType');
      expect(status.id, 'status-id');
      expect(status.type, 'StatusType');
    });
  });

  group('EidasProof Tests', () {
    final now = DateTime.now();
    test('Object creation works', () {
      final proof = EidasProof(
          type: 'ProofType',
          created: now,
          verificationMethod: 'vm-id',
          proofPurpose: 'purpose',
          proofValue: 'value');
      expect(proof.type, 'ProofType');
      expect(proof.created, now);
    });
  });

  group('EidasEvidence Tests', () {
    test('Object creation works', () {
      final evidence = EidasEvidence(
        type: 'EvidenceType',
        verifier: 'verifier-id',
      );
      expect(evidence.type, 'EvidenceType');
      expect(evidence.verifier, 'verifier-id');
    });
  });
}
