import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DigitalIdentity Model Tests', () {
    // Sample data for tests
    final now = DateTime.now();

    final baseIdentity = DigitalIdentity(
      identityAddress: 'did:example:alice123',
      displayName: 'AliceW',
      verificationStatus: IdentityVerificationStatus.fullyVerified,
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now,
    );

    test('Object creation and basic properties', () {
      // Arrange & Act: Object created in `baseIdentity`

      // Assert
      expect(baseIdentity.identityAddress, 'did:example:alice123');
      expect(baseIdentity.displayName, 'AliceW');
      expect(baseIdentity.verificationStatus,
          IdentityVerificationStatus.fullyVerified);
      expect(baseIdentity.createdAt, isA<DateTime>());
      expect(baseIdentity.updatedAt, now);
    });

    test('copyWith creates a copy with updated fields', () {
      // Arrange
      final later = now.add(const Duration(hours: 1));

      // Act: Use copyWith to change specific fields
      final updatedIdentity = baseIdentity.copyWith(
        displayName: 'AliceUpdated',
        updatedAt: later,
        verificationStatus: IdentityVerificationStatus.pending,
      );

      // Assert: Check updated fields
      expect(updatedIdentity.identityAddress,
          baseIdentity.identityAddress); // ID shouldn't change
      expect(updatedIdentity.displayName, 'AliceUpdated');
      expect(updatedIdentity.verificationStatus,
          IdentityVerificationStatus.pending);
      expect(updatedIdentity.createdAt,
          baseIdentity.createdAt); // Creation date shouldn't change
      expect(updatedIdentity.updatedAt, later);
    });

    test('copyWith creates an identical copy if no fields are provided', () {
      // Arrange & Act
      final copy = baseIdentity.copyWith();

      // Assert
      expect(copy, baseIdentity); // Freezed models implement equality
      expect(identical(copy, baseIdentity),
          false); // Should be a different instance
    });

    // Add tests for fromJson/toJson if you implement them
    // test('fromJson creates correct object', () { ... });
    // test('toJson creates correct map', () { ... });
  });
}
