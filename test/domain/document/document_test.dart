import 'package:did_app/domain/document/document.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  const docId = 'doc-uuid-1';
  const ownerId = 'did:example:owner';

  group('Document Model Tests', () {
    final issued = now.subtract(const Duration(days: 30));
    final expires = now.add(const Duration(days: 365 * 2));

    final baseDocument = Document(
      id: docId,
      type: DocumentType.passport,
      title: 'My Example Passport',
      issuer: 'Government of Exampleland',
      issuedAt: issued,
      expiresAt: expires,
      version: 1,
      verificationStatus: DocumentVerificationStatus.verified,
      encryptedStoragePath: '/path/to/encrypted/passport.dat',
      documentHash: 'sha256-abcdef123...',
      encryptionIV: 'base64-encoded-iv',
      updatedAt: now,
      ownerIdentityId: ownerId,
      eidasLevel: EidasLevel.high,
      isShareable: true,
      tags: ['official', 'travel'],
    );

    test('Object creation and basic properties', () {
      expect(baseDocument.id, docId);
      expect(baseDocument.type, DocumentType.passport);
      expect(baseDocument.title, 'My Example Passport');
      expect(baseDocument.issuer, 'Government of Exampleland');
      expect(baseDocument.issuedAt, issued);
      expect(baseDocument.expiresAt, expires);
      expect(baseDocument.version, 1);
      expect(
          baseDocument.verificationStatus, DocumentVerificationStatus.verified);
      expect(baseDocument.encryptedStoragePath, isNotNull);
      expect(baseDocument.documentHash, startsWith('sha256-'));
      expect(baseDocument.encryptionIV, isNotNull);
      expect(baseDocument.updatedAt, now);
      expect(baseDocument.ownerIdentityId, ownerId);
      expect(baseDocument.eidasLevel, EidasLevel.high);
      expect(baseDocument.isShareable, isTrue);
      expect(baseDocument.tags, containsAll(['official', 'travel']));
      // Optional fields check
      expect(baseDocument.description, isNull);
      expect(baseDocument.metadata, isNull);
      expect(baseDocument.issuerSignature, isNull);
      expect(baseDocument.issuerAddress, isNull);
      expect(baseDocument.blockchainTxId, isNull);
    });

    test('copyWith updates fields correctly', () {
      final newMeta = {'countryCode': 'EXL'};
      final updatedDoc = baseDocument.copyWith(
        title: 'Updated Passport Title',
        version: 2,
        updatedAt: now.add(const Duration(minutes: 5)),
        metadata: newMeta,
        verificationStatus: DocumentVerificationStatus.pending,
        isShareable: false,
      );

      expect(updatedDoc.title, 'Updated Passport Title');
      expect(updatedDoc.version, 2);
      expect(updatedDoc.updatedAt.isAfter(baseDocument.updatedAt), isTrue);
      expect(updatedDoc.metadata, newMeta);
      expect(updatedDoc.verificationStatus, DocumentVerificationStatus.pending);
      expect(updatedDoc.isShareable, isFalse);
      // Unchanged fields
      expect(updatedDoc.id, baseDocument.id);
      expect(updatedDoc.type, baseDocument.type);
      expect(updatedDoc.issuer, baseDocument.issuer);
    });
  });

  group('DocumentVersion Model Tests', () {
    final baseVersion = DocumentVersion(
      id: 'version-uuid-1',
      versionNumber: 1,
      createdAt: now.subtract(const Duration(days: 1)),
      documentHash: 'sha256-oldhash...',
      encryptedStoragePath: '/path/v1/doc.dat',
      encryptionIV: 'iv-v1',
      changeNote: 'Initial version',
    );

    test('Object creation and basic properties', () {
      expect(baseVersion.id, 'version-uuid-1');
      expect(baseVersion.versionNumber, 1);
      expect(baseVersion.createdAt, isNotNull);
      expect(baseVersion.documentHash, 'sha256-oldhash...');
      expect(baseVersion.encryptedStoragePath, '/path/v1/doc.dat');
      expect(baseVersion.encryptionIV, 'iv-v1');
      expect(baseVersion.changeNote, 'Initial version');
      expect(baseVersion.blockchainTxId, isNull);
    });

    test('copyWith updates fields correctly', () {
      final updatedVersion = baseVersion.copyWith(
        changeNote: 'Updated metadata field X',
        blockchainTxId: 'tx-abc',
      );
      expect(updatedVersion.changeNote, 'Updated metadata field X');
      expect(updatedVersion.blockchainTxId, 'tx-abc');
      expect(updatedVersion.versionNumber, baseVersion.versionNumber);
    });
  });

  group('DocumentShare Model Tests', () {
    final expires = now.add(const Duration(days: 7));
    final baseShare = DocumentShare(
      id: 'share-uuid-1',
      documentId: docId,
      documentTitle: 'Shared Passport',
      recipientDescription: 'Bank ABC Verification',
      createdAt: now,
      expiresAt: expires,
      shareUrl: 'https://share.example.com/xyz123',
      accessType: DocumentShareAccessType.readOnly,
    );

    test('Object creation and basic properties', () {
      expect(baseShare.id, 'share-uuid-1');
      expect(baseShare.documentId, docId);
      expect(baseShare.documentTitle, 'Shared Passport');
      expect(baseShare.recipientDescription, 'Bank ABC Verification');
      expect(baseShare.createdAt, now);
      expect(baseShare.expiresAt, expires);
      expect(baseShare.shareUrl, startsWith('https://'));
      expect(baseShare.accessType, DocumentShareAccessType.readOnly);
      expect(baseShare.isActive, isTrue); // Default
      expect(baseShare.accessCount, 0); // Default
      expect(baseShare.recipientId, isNull);
      expect(baseShare.accessCode, isNull);
      expect(baseShare.maxAccessCount, isNull);
      expect(baseShare.lastAccessedAt, isNull);
    });

    test('copyWith updates fields correctly', () {
      final lastAccessed = now.add(const Duration(minutes: 1));
      final updatedShare = baseShare.copyWith(
        isActive: false,
        accessCount: 1,
        lastAccessedAt: lastAccessed,
        accessType: DocumentShareAccessType.verify,
        accessCode: '123456',
      );
      expect(updatedShare.isActive, isFalse);
      expect(updatedShare.accessCount, 1);
      expect(updatedShare.lastAccessedAt, lastAccessed);
      expect(updatedShare.accessType, DocumentShareAccessType.verify);
      expect(updatedShare.accessCode, '123456');
      expect(updatedShare.id, baseShare.id);
    });
  });

  group('DocumentType Enum Tests', () {
    test('Enum values exist', () {
      expect(
          DocumentType.values,
          containsAll([
            DocumentType.nationalId,
            DocumentType.passport,
            DocumentType.drivingLicense,
            DocumentType.diploma,
            DocumentType.certificate,
            DocumentType.addressProof,
            DocumentType.bankDocument,
            DocumentType.medicalRecord,
            DocumentType.corporateDocument,
            DocumentType.other,
          ]));
    });
  });

  group('DocumentVerificationStatus Enum Tests', () {
    test('Enum values exist', () {
      expect(
          DocumentVerificationStatus.values,
          containsAll([
            DocumentVerificationStatus.unverified,
            DocumentVerificationStatus.pending,
            DocumentVerificationStatus.verified,
            DocumentVerificationStatus.rejected,
            DocumentVerificationStatus.expired,
          ]));
    });
  });

  group('DocumentShareAccessType Enum Tests', () {
    test('Enum values exist', () {
      expect(
          DocumentShareAccessType.values,
          containsAll([
            DocumentShareAccessType.readOnly,
            DocumentShareAccessType.download,
            DocumentShareAccessType.verify,
            DocumentShareAccessType.fullAccess,
          ]));
    });
  });

  group('EidasLevel Enum Tests', () {
    test('Enum values exist', () {
      expect(
          EidasLevel.values,
          containsAll([
            EidasLevel.low,
            EidasLevel.substantial,
            EidasLevel.high,
          ]));
    });
  });

  // Note: DocumentRepository is abstract, no direct tests here.
}
