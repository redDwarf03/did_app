import 'package:did_app/domain/credential/credential_status.dart'; // For RevocationReason
import 'package:did_app/domain/credential/revocation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  const credId = 'urn:uuid:test-cred-1';

  group('RevocationResult Model Tests', () {
    final baseResult = RevocationResult(
      credentialId: credId,
      success: true,
      timestamp: now,
    );

    test('Object creation and basic properties (success)', () {
      expect(baseResult.credentialId, credId);
      expect(baseResult.success, isTrue);
      expect(baseResult.timestamp, now);
      expect(baseResult.errorMessage, isNull);
      expect(baseResult.details, isNull);
    });

    test('Object creation and basic properties (failure)', () {
      final failureResult = RevocationResult(
        credentialId: credId,
        success: false,
        timestamp: now,
        errorMessage: 'Connection failed',
        details: 'Unable to reach revocation registry',
      );
      expect(failureResult.success, isFalse);
      expect(failureResult.errorMessage, 'Connection failed');
      expect(failureResult.details, 'Unable to reach revocation registry');
    });

    test('copyWith updates fields correctly', () {
      final updatedResult = baseResult.copyWith(
        success: false,
        errorMessage: 'Not found',
      );

      expect(updatedResult.credentialId, baseResult.credentialId);
      expect(updatedResult.success, isFalse);
      expect(updatedResult.errorMessage, 'Not found');
      expect(updatedResult.timestamp, baseResult.timestamp);
    });
  });

  group('RevocationHistoryEntry Model Tests', () {
    final baseEntry = RevocationHistoryEntry(
      credentialId: credId,
      timestamp: now,
      action: RevocationAction.revoke,
      reason: RevocationReason.compromised,
      actor: 'did:example:issuer1',
    );

    test('Object creation and basic properties (revoke)', () {
      expect(baseEntry.credentialId, credId);
      expect(baseEntry.timestamp, now);
      expect(baseEntry.action, RevocationAction.revoke);
      expect(baseEntry.reason, RevocationReason.compromised);
      expect(baseEntry.actor, 'did:example:issuer1');
      expect(baseEntry.details, isNull);
    });

    test('Object creation and basic properties (unrevoke)', () {
      final unrevokeEntry = RevocationHistoryEntry(
        credentialId: credId,
        timestamp: now.add(const Duration(minutes: 5)),
        action: RevocationAction.unrevoke,
        reason: null,
        actor: 'did:example:issuer1',
        details: 'Revoked in error',
      );
      expect(unrevokeEntry.action, RevocationAction.unrevoke);
      expect(unrevokeEntry.reason, isNull);
      expect(unrevokeEntry.details, 'Revoked in error');
    });

    test('copyWith updates fields correctly', () {
      final updatedEntry = baseEntry.copyWith(
        details: 'Performed by admin script',
        reason: RevocationReason.noLongerValid,
      );

      expect(updatedEntry.credentialId, baseEntry.credentialId);
      expect(updatedEntry.timestamp, baseEntry.timestamp);
      expect(updatedEntry.action, baseEntry.action);
      expect(updatedEntry.reason, RevocationReason.noLongerValid);
      expect(updatedEntry.details, 'Performed by admin script');
      expect(updatedEntry.actor, baseEntry.actor);
    });
  });

  group('RevocationAction Enum Tests', () {
    test('Enum values exist', () {
      expect(
          RevocationAction.values,
          containsAll([
            RevocationAction.revoke,
            RevocationAction.unrevoke,
          ]));
    });
  });

  // Note: RevocationService is abstract, no direct tests here.
  // Tests would target concrete implementations.
}
