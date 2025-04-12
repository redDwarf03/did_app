import 'package:did_app/domain/credential/simplified_credential.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();
  final issuance = now.subtract(const Duration(days: 10));

  group('SimplifiedCredential Model Tests', () {
    final expiresSoonDate = now.add(const Duration(days: 15));
    final expiredDate = now.subtract(const Duration(days: 1));
    final farFutureDate = now.add(const Duration(days: 100));

    final baseCredential = SimplifiedCredential(
      id: 'simple-cred-123',
      type: SimplifiedCredentialType.certificate,
      issuer: 'Test Issuer Ltd.',
      issuanceDate: issuance,
      expirationDate: farFutureDate,
      attributes: {'course': 'Flutter Basics', 'grade': 'A'},
      isVerified: true,
    );

    test('Object creation and basic properties', () {
      expect(baseCredential.id, 'simple-cred-123');
      expect(baseCredential.type, SimplifiedCredentialType.certificate);
      expect(baseCredential.issuer, 'Test Issuer Ltd.');
      expect(baseCredential.issuanceDate, issuance);
      expect(baseCredential.expirationDate, farFutureDate);
      expect(baseCredential.attributes['course'], 'Flutter Basics');
      expect(baseCredential.isVerified, isTrue);
    });

    test('copyWith updates fields correctly', () {
      final updatedAttributes = {
        ...baseCredential.attributes,
        'level': 'Beginner'
      };
      final updatedCred = baseCredential.copyWith(
        issuer: 'Updated Issuer Inc.',
        attributes: updatedAttributes,
        isVerified: false,
      );

      expect(updatedCred.id, baseCredential.id);
      expect(updatedCred.type, baseCredential.type);
      expect(updatedCred.issuer, 'Updated Issuer Inc.');
      expect(updatedCred.issuanceDate, baseCredential.issuanceDate);
      expect(updatedCred.expirationDate, baseCredential.expirationDate);
      expect(updatedCred.attributes, updatedAttributes);
      expect(updatedCred.isVerified, isFalse);
    });

    group('isExpired getter', () {
      test('returns false for future expiration date', () {
        expect(baseCredential.isExpired, isFalse);
      });

      test('returns true for past expiration date', () {
        final expiredCred =
            baseCredential.copyWith(expirationDate: expiredDate);
        expect(expiredCred.isExpired, isTrue);
      });
    });

    group('isExpiringSoon getter', () {
      test('returns false for far future expiration date', () {
        expect(baseCredential.isExpiringSoon, isFalse);
      });

      test('returns true for expiration date within 30 days', () {
        final expiringSoonCred =
            baseCredential.copyWith(expirationDate: expiresSoonDate);
        expect(expiringSoonCred.isExpiringSoon, isTrue);
      });

      test('returns false for already expired credential', () {
        final expiredCred =
            baseCredential.copyWith(expirationDate: expiredDate);
        expect(expiredCred.isExpiringSoon, isFalse);
      });
    });
  });

  group('SimplifiedCredentialType Enum Tests', () {
    test('Enum values exist', () {
      expect(
          SimplifiedCredentialType.values,
          containsAll([
            SimplifiedCredentialType.identity,
            SimplifiedCredentialType.diploma,
            SimplifiedCredentialType.certificate,
            SimplifiedCredentialType.membership,
            SimplifiedCredentialType.license,
            SimplifiedCredentialType.healthCard,
            SimplifiedCredentialType.custom,
          ]));
    });
  });
}
