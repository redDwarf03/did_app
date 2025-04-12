import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BiometricAuthState Model Tests', () {
    // Base state for comparison
    const baseState = BiometricAuthState();

    test('Initial state has default values', () {
      // Assert
      expect(baseState.availableBiometrics, isEmpty);
      expect(baseState.currentBiometricType, BiometricType.none);
      expect(baseState.status, AuthStatus.notAuthenticated);
      expect(baseState.errorMessage, isNull);
      expect(baseState.isBiometricEnabled, isFalse);
      expect(baseState.isTwoFactorEnabled, isFalse);
      expect(baseState.isPasswordlessEnabled, isFalse);
    });

    test('copyWith creates a copy with updated fields', () {
      // Arrange
      const updatedAvailable = [
        BiometricType.fingerprint,
        BiometricType.faceId,
      ];
      const updatedType = BiometricType.faceId;
      const updatedStatus = AuthStatus.authenticated;
      const updatedError = 'Failed to enroll';

      // Act
      final updatedState = baseState.copyWith(
        availableBiometrics: updatedAvailable,
        currentBiometricType: updatedType,
        status: updatedStatus,
        errorMessage: updatedError,
        isBiometricEnabled: true,
        isTwoFactorEnabled: true,
        isPasswordlessEnabled: true,
      );

      // Assert: Check updated fields
      expect(updatedState.availableBiometrics, updatedAvailable);
      expect(updatedState.currentBiometricType, updatedType);
      expect(updatedState.status, updatedStatus);
      expect(updatedState.errorMessage, updatedError);
      expect(updatedState.isBiometricEnabled, isTrue);
      expect(updatedState.isTwoFactorEnabled, isTrue);
      expect(updatedState.isPasswordlessEnabled, isTrue);

      // Assert: Check unchanged fields (using baseState for comparison)
      // In this case, all fields were changed, so no direct comparison needed.
      // If only some fields were changed, you'd check others remain equal to baseState.
    });

    test('copyWith creates an identical copy if no fields are provided', () {
      // Arrange & Act
      final copy = baseState.copyWith();

      // Assert
      expect(
        copy,
        baseState,
      ); // Freezed models implement equality based on value
      expect(
        identical(copy, baseState),
        false,
      ); // Should be a different instance
    });

    test('copyWith handles null error message', () {
      // Arrange: Create a state with an error message
      final stateWithError = baseState.copyWith(errorMessage: 'Initial error');

      // Act: Copy and set error message to null
      final stateWithoutError = stateWithError.copyWith(errorMessage: null);

      // Assert
      expect(stateWithError.errorMessage, 'Initial error');
      expect(stateWithoutError.errorMessage, isNull);
    });

    // Tests for fromJson/toJson can be added if serialization is needed
    // test('fromJson creates correct object', () { ... });
    // test('toJson creates correct map', () { ... });
  });

  group('BiometricType Enum Tests', () {
    test('Enum values exist', () {
      expect(
        BiometricType.values,
        containsAll([
          BiometricType.fingerprint,
          BiometricType.faceId,
          BiometricType.iris,
          BiometricType.none,
        ]),
      );
    });
  });

  group('AuthStatus Enum Tests', () {
    test('Enum values exist', () {
      expect(
        AuthStatus.values,
        containsAll([
          AuthStatus.notAuthenticated,
          AuthStatus.authenticating,
          AuthStatus.authenticated,
          AuthStatus.failed,
          AuthStatus.unavailable,
          AuthStatus.notSetUp,
        ]),
      );
    });
  });
}
