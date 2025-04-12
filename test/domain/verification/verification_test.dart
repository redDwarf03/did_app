import 'package:did_app/domain/verification/verification_process.dart';
import 'package:did_app/domain/verification/verification_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  const identityAddr = 'did:example:verified-user';
  const processId = 'kyc-process-1';

  group('VerificationResult Tests', () {
    test('Successful result creation', () {
      const result = VerificationResult(isValid: true);
      expect(result.isValid, isTrue);
      expect(result.message, isNull);
    });

    test('Failure result creation', () {
      const result = VerificationResult(
        isValid: false,
        message: 'Signature mismatch',
      );
      expect(result.isValid, isFalse);
      expect(result.message, 'Signature mismatch');
    });

    // copyWith is not generated by default without @unfreezed or similar
    // If needed, uncomment the model definition and regenerate.
    // test('copyWith updates fields', () {
    //   final initial = VerificationResult(isValid: true);
    //   final updated = initial.copyWith(isValid: false, message: 'Expired');
    //   expect(updated.isValid, isFalse);
    //   expect(updated.message, 'Expired');
    // });
  });

  group('VerificationProcess Tests', () {
    final step1 = VerificationStep(
      id: 'step-email',
      type: VerificationStepType.emailVerification,
      status: VerificationStepStatus.completed,
      order: 1,
      description: 'Verify Email Address',
      instructions: 'Click the link sent to your email.',
      updatedAt: now.subtract(const Duration(minutes: 10)),
    );

    final step2 = VerificationStep(
      id: 'step-idDoc',
      type: VerificationStepType.idDocumentVerification,
      status: VerificationStepStatus.inProgress,
      order: 2,
      description: 'Verify ID Document',
      instructions: 'Upload a clear picture of your passport.',
      updatedAt: now.subtract(const Duration(minutes: 5)),
    );

    final baseProcess = VerificationProcess(
      id: processId,
      identityAddress: identityAddr,
      status: VerificationStatus.inProgress,
      steps: [step1, step2],
      createdAt: now.subtract(const Duration(minutes: 15)),
      updatedAt: now.subtract(const Duration(minutes: 5)),
    );

    test('Object creation and basic properties', () {
      expect(baseProcess.id, processId);
      expect(baseProcess.identityAddress, identityAddr);
      expect(baseProcess.status, VerificationStatus.inProgress);
      expect(baseProcess.steps.length, 2);
      expect(baseProcess.steps, containsAll([step1, step2]));
      expect(baseProcess.createdAt, isNotNull);
      expect(baseProcess.updatedAt, isNotNull);
      expect(baseProcess.rejectionReason, isNull);
      expect(baseProcess.completedAt, isNull);
      expect(baseProcess.certificate, isNull);
    });

    test('copyWith updates fields correctly', () {
      final completedTime = now.add(const Duration(minutes: 1));
      final cert = VerificationCertificate(
        id: 'cert-1',
        issuedAt: completedTime,
        expiresAt: completedTime.add(const Duration(days: 365)),
        issuer: 'did:example:verifier',
        signature: 'zCertSignature...',
        eidasLevel: EidasLevel.substantial,
      );
      final updatedStep2 = step2.copyWith(
        status: VerificationStepStatus.completed,
        updatedAt: completedTime,
        documentPaths: ['/path/passport.jpg'],
      );

      final updatedProcess = baseProcess.copyWith(
        status: VerificationStatus.completed,
        completedAt: completedTime,
        updatedAt: completedTime,
        steps: [
          step1,
          updatedStep2,
        ], // Need to update the list with the changed step
        certificate: cert,
      );

      expect(updatedProcess.status, VerificationStatus.completed);
      expect(updatedProcess.completedAt, completedTime);
      expect(updatedProcess.updatedAt, completedTime);
      expect(updatedProcess.steps[1], updatedStep2);
      expect(updatedProcess.steps[1].documentPaths, isNotNull);
      expect(updatedProcess.certificate, cert);
      expect(updatedProcess.id, baseProcess.id);
    });
  });

  group('VerificationStep Tests', () {
    final baseStep = VerificationStep(
      id: 'step-addr',
      type: VerificationStepType.addressVerification,
      status: VerificationStepStatus.notStarted,
      order: 3,
      description: 'Verify Address',
      instructions: 'Upload a utility bill.',
      updatedAt: now,
    );

    test('Object creation and basic properties', () {
      expect(baseStep.id, 'step-addr');
      expect(baseStep.type, VerificationStepType.addressVerification);
      expect(baseStep.status, VerificationStepStatus.notStarted);
      expect(baseStep.order, 3);
      expect(baseStep.description, 'Verify Address');
      expect(baseStep.instructions, 'Upload a utility bill.');
      expect(baseStep.updatedAt, now);
      expect(baseStep.rejectionReason, isNull);
      expect(baseStep.documentPaths, isNull);
    });

    test('copyWith updates fields correctly', () {
      final updatedStep = baseStep.copyWith(
        status: VerificationStepStatus.rejected,
        rejectionReason: 'Document blurry',
        documentPaths: ['/path/bill.pdf'],
      );
      expect(updatedStep.status, VerificationStepStatus.rejected);
      expect(updatedStep.rejectionReason, 'Document blurry');
      expect(updatedStep.documentPaths, contains('/path/bill.pdf'));
      expect(updatedStep.id, baseStep.id);
    });
  });

  group('VerificationCertificate Tests', () {
    final issued = now.subtract(const Duration(hours: 1));
    final expires = now.add(const Duration(days: 365));
    final baseCert = VerificationCertificate(
      id: 'cert-uuid-1',
      issuedAt: issued,
      expiresAt: expires,
      issuer: 'did:example:issuer-verifier',
      signature: 'zSignatureValue...',
      eidasLevel: EidasLevel.high,
    );

    test('Object creation and basic properties', () {
      expect(baseCert.id, 'cert-uuid-1');
      expect(baseCert.issuedAt, issued);
      expect(baseCert.expiresAt, expires);
      expect(baseCert.issuer, 'did:example:issuer-verifier');
      expect(baseCert.signature, 'zSignatureValue...');
      expect(baseCert.eidasLevel, EidasLevel.high);
    });

    test('copyWith updates fields correctly', () {
      final newExpiry = expires.add(const Duration(days: 180));
      final updatedCert = baseCert.copyWith(
        expiresAt: newExpiry,
        eidasLevel: EidasLevel.substantial,
      );
      expect(updatedCert.expiresAt, newExpiry);
      expect(updatedCert.eidasLevel, EidasLevel.substantial);
      expect(updatedCert.id, baseCert.id);
    });
  });

  group('VerificationStatus Enum Tests', () {
    test('Enum values exist', () {
      expect(
        VerificationStatus.values,
        containsAll([
          VerificationStatus.notStarted,
          VerificationStatus.inProgress,
          VerificationStatus.pendingReview,
          VerificationStatus.completed,
          VerificationStatus.rejected,
          VerificationStatus.expired,
        ]),
      );
    });
  });

  group('VerificationStepStatus Enum Tests', () {
    test('Enum values exist', () {
      expect(
        VerificationStepStatus.values,
        containsAll([
          VerificationStepStatus.notStarted,
          VerificationStepStatus.inProgress,
          VerificationStepStatus.completed,
          VerificationStepStatus.rejected,
          VerificationStepStatus.actionRequired,
        ]),
      );
    });
  });

  group('VerificationStepType Enum Tests', () {
    test('Enum values exist', () {
      expect(
        VerificationStepType.values,
        containsAll([
          VerificationStepType.emailVerification,
          VerificationStepType.phoneVerification,
          VerificationStepType.idDocumentVerification,
          VerificationStepType.addressVerification,
          VerificationStepType.livenessCheck,
          VerificationStepType.biometricVerification,
          VerificationStepType.additionalDocuments,
        ]),
      );
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
        ]),
      );
    });
  });

  // Note: VerificationRepository is abstract, no direct tests here.
}
