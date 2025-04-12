import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DigitalIdentity Model Tests', () {
    // Sample data for tests
    final now = DateTime.now();
    const samplePersonalInfo = PersonalInfo(
      fullName: 'Alice Wonderland',
      email: 'alice@wonderland.com',
      phoneNumber: '123-456-7890',
      dateOfBirth: null,
      nationality: 'GB',
      address: PhysicalAddress(
        street: '1 Rabbit Hole',
        city: 'Curiosity Corner',
        state: 'Wonderland',
        postalCode: 'WND 1RL',
        country: 'Fantasy Land',
      ),
    );

    final baseIdentity = DigitalIdentity(
      identityAddress: 'did:example:alice123',
      displayName: 'AliceW',
      personalInfo: samplePersonalInfo,
      verificationStatus: IdentityVerificationStatus.fullyVerified,
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now,
    );

    test('Object creation and basic properties', () {
      // Arrange & Act: Object created in `baseIdentity`

      // Assert
      expect(baseIdentity.identityAddress, 'did:example:alice123');
      expect(baseIdentity.displayName, 'AliceW');
      expect(baseIdentity.personalInfo, samplePersonalInfo);
      expect(baseIdentity.verificationStatus,
          IdentityVerificationStatus.fullyVerified);
      expect(baseIdentity.createdAt, isA<DateTime>());
      expect(baseIdentity.updatedAt, now);
    });

    test('copyWith creates a copy with updated fields', () {
      // Arrange
      final later = now.add(const Duration(hours: 1));
      final newAddress =
          samplePersonalInfo.address!.copyWith(postalCode: 'WND 2RL');

      // Act: Use copyWith to change specific fields
      final updatedIdentity = baseIdentity.copyWith(
        displayName: 'AliceUpdated',
        updatedAt: later,
        personalInfo: baseIdentity.personalInfo.copyWith(
          email: 'alice.updated@wonderland.com',
          address: newAddress,
        ),
        verificationStatus: IdentityVerificationStatus.pending,
      );

      // Assert: Check updated fields
      expect(updatedIdentity.identityAddress,
          baseIdentity.identityAddress); // ID shouldn't change
      expect(updatedIdentity.displayName, 'AliceUpdated');
      expect(
          updatedIdentity.personalInfo.email, 'alice.updated@wonderland.com');
      expect(updatedIdentity.personalInfo.fullName,
          samplePersonalInfo.fullName); // Unchanged field
      expect(updatedIdentity.personalInfo.address, newAddress);
      expect(updatedIdentity.personalInfo.address?.postalCode, 'WND 2RL');
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

    test('PersonalInfo copyWith works correctly', () {
      // Arrange
      const newAddress = PhysicalAddress(
          street: 'New Street',
          city: 'New City',
          postalCode: 'NC 123',
          country: 'FL');

      // Act
      final updatedInfo = samplePersonalInfo.copyWith(
        fullName: 'Alice W.',
        address: newAddress,
        phoneNumber: null, // Test setting a field to null
      );

      // Assert
      expect(updatedInfo.fullName, 'Alice W.');
      expect(updatedInfo.email, samplePersonalInfo.email);
      expect(updatedInfo.phoneNumber, null);
      expect(updatedInfo.dateOfBirth, samplePersonalInfo.dateOfBirth);
      expect(updatedInfo.nationality, samplePersonalInfo.nationality);
      expect(updatedInfo.address, newAddress);
    });

    test('PhysicalAddress copyWith works correctly', () {
      // Arrange
      const address = PhysicalAddress(
        street: '1 Rabbit Hole',
        city: 'Curiosity Corner',
        state: 'Wonderland',
        postalCode: 'WND 1RL',
        country: 'Fantasy Land',
      );

      // Act
      final updatedAddress = address.copyWith(
        city: 'Mad Tea Party',
        postalCode: 'WND 3TP',
      );

      // Assert
      expect(updatedAddress.street, address.street);
      expect(updatedAddress.city, 'Mad Tea Party');
      expect(updatedAddress.state, address.state);
      expect(updatedAddress.postalCode, 'WND 3TP');
      expect(updatedAddress.country, address.country);
    });

    // Add tests for fromJson/toJson if you implement them
    // test('fromJson creates correct object', () { ... });
    // test('toJson creates correct map', () { ... });
  });
}
