import 'package:did_app/domain/credential/credential_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  const credId = 'urn:uuid:status-cred-1';
  const statusUrl = 'https://example.com/status/list/1';

  group('CredentialStatus Model Tests', () {
    final validStatus = CredentialStatus(
      credentialId: credId,
      status: CredentialStatusType.valid,
      lastChecked: now.subtract(const Duration(minutes: 5)),
      statusListUrl: statusUrl,
      statusListIndex: 10,
      nextCheck: now.add(const Duration(hours: 1)),
    );

    final revokedStatus = CredentialStatus(
      credentialId: credId,
      status: CredentialStatusType.revoked,
      lastChecked: now.subtract(const Duration(minutes: 10)),
      revokedAt: now.subtract(const Duration(minutes: 9)),
      revocationReason: RevocationReason.compromised,
      revocationDetails: 'Key found in public dump',
      statusListUrl: statusUrl,
      statusListIndex: 10,
      nextCheck:
          now.add(const Duration(days: 1)), // Check less frequently if revoked
    );

    test('Object creation and basic properties (valid)', () {
      expect(validStatus.credentialId, credId);
      expect(validStatus.status, CredentialStatusType.valid);
      expect(validStatus.revokedAt, isNull);
      expect(validStatus.revocationReason, isNull);
      expect(validStatus.statusListUrl, statusUrl);
      expect(validStatus.statusListIndex, 10);
      expect(validStatus.lastChecked, isNotNull);
      expect(validStatus.nextCheck, isNotNull);
    });

    test('Object creation and basic properties (revoked)', () {
      expect(revokedStatus.status, CredentialStatusType.revoked);
      expect(revokedStatus.revokedAt, isNotNull);
      expect(revokedStatus.revocationReason, RevocationReason.compromised);
      expect(revokedStatus.revocationDetails, 'Key found in public dump');
    });

    test('copyWith updates fields correctly', () {
      final updatedStatus = validStatus.copyWith(
        status: CredentialStatusType.expired,
        expiresAt: now.subtract(const Duration(days: 1)),
        nextCheck:
            now.add(const Duration(days: 30)), // Check much later if expired
      );

      expect(updatedStatus.credentialId, validStatus.credentialId);
      expect(updatedStatus.status, CredentialStatusType.expired);
      expect(updatedStatus.expiresAt, isNotNull);
      expect(updatedStatus.nextCheck.isAfter(validStatus.nextCheck), isTrue);
      // Check unchanged fields
      expect(updatedStatus.statusListUrl, validStatus.statusListUrl);
      expect(updatedStatus.revocationReason, isNull);
    });
  });

  group('StatusList Model Tests', () {
    final baseStatusList = StatusList(
      id: statusUrl,
      lastUpdated: now.subtract(const Duration(hours: 1)),
      statuses: {
        0: false,
        1: true,
        2: false,
        10: true
      }, // index 1 and 10 are revoked/suspended
      size: 2048,
    );

    test('Object creation and basic properties', () {
      expect(baseStatusList.id, statusUrl);
      expect(baseStatusList.lastUpdated, isNotNull);
      expect(baseStatusList.statuses, containsPair(1, true));
      expect(baseStatusList.statuses, containsPair(0, false));
      expect(baseStatusList.statuses.length, 4);
      expect(baseStatusList.size, 2048);
      expect(baseStatusList.version, isNull);
    });

    test('copyWith updates fields correctly', () {
      final updatedStatuses = Map.of(baseStatusList.statuses)
        ..addAll({10: false, 11: true});
      final updatedList = baseStatusList.copyWith(
        lastUpdated: now,
        statuses: updatedStatuses,
        version: 'v1.1',
      );

      expect(updatedList.id, baseStatusList.id);
      expect(updatedList.lastUpdated, now);
      expect(updatedList.statuses[10], isFalse); // Updated
      expect(updatedList.statuses[11], isTrue); // Added
      expect(updatedList.statuses[0], isFalse); // Unchanged
      expect(updatedList.version, 'v1.1');
    });
  });

  group('StatusCheckResult Model Tests', () {
    final successResult = StatusCheckResult(
      credentialId: credId,
      status: CredentialStatusType.valid,
      checkedAt: now,
    );
    final failureResult = StatusCheckResult(
      credentialId: credId,
      status: CredentialStatusType.unknown, // Often unknown if check fails
      checkedAt: now,
      error: 'Timeout connecting to status service',
      details: 'Attempt 3/3 failed.',
    );

    test('Object creation and basic properties (success)', () {
      expect(successResult.credentialId, credId);
      expect(successResult.status, CredentialStatusType.valid);
      expect(successResult.checkedAt, now);
      expect(successResult.error, isNull);
      expect(successResult.details, isNull);
    });

    test('Object creation and basic properties (failure)', () {
      expect(failureResult.status, CredentialStatusType.unknown);
      expect(failureResult.error, 'Timeout connecting to status service');
      expect(failureResult.details, 'Attempt 3/3 failed.');
    });

    test('copyWith updates fields correctly', () {
      final updatedResult = successResult.copyWith(
        status: CredentialStatusType.revoked,
        details: 'Revoked per StatusList2021 check.',
      );
      expect(updatedResult.status, CredentialStatusType.revoked);
      expect(updatedResult.details, 'Revoked per StatusList2021 check.');
      expect(updatedResult.error, isNull);
    });
  });

  group('CredentialStatusType Enum Tests', () {
    test('Enum values exist', () {
      expect(
          CredentialStatusType.values,
          containsAll([
            CredentialStatusType.valid,
            CredentialStatusType.revoked,
            CredentialStatusType.expired,
            CredentialStatusType.unknown,
          ]));
    });
  });

  group('RevocationReason Enum Tests', () {
    test('Enum values exist', () {
      expect(
          RevocationReason.values,
          containsAll([
            RevocationReason.compromised,
            RevocationReason.superseded,
            RevocationReason.noLongerValid,
            RevocationReason.issuerRevoked,
            RevocationReason.other,
          ]));
    });
  });
}
