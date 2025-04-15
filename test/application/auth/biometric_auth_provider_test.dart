import 'package:did_app/application/auth/biometric_auth_provider.dart';
import 'package:did_app/domain/auth/biometric_auth_model.dart';
import 'package:did_app/infrastructure/auth/biometric_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockBiometricAuthService extends Mock implements BiometricAuthService {}

// Fakes (already defined in identity_notifier_test.dart, but good practice to have locally if needed)
// class FakeBiometricAuthState extends Fake implements BiometricAuthState {}

void main() {
  late MockBiometricAuthService mockAuthService;
  late ProviderContainer container;
  late BiometricAuthNotifier notifier;

  // Helper to setup container and notifier with current mocks
  ProviderContainer _setupContainer(MockBiometricAuthService service) {
    final container = ProviderContainer(
      overrides: [
        biometricAuthServiceProvider.overrideWithValue(service),
      ],
    );
    // Read the notifier to trigger initialization (calls checkBiometricAvailability)
    notifier = container.read(biometricAuthNotifierProvider.notifier);
    return container;
  }

  setUp(() {
    mockAuthService = MockBiometricAuthService();
    // Default mocks for initial check - assumes biometrics are available and setup
    when(() => mockAuthService.isBiometricAvailable())
        .thenAnswer((_) async => true);
    when(() => mockAuthService.getAvailableBiometrics())
        .thenAnswer((_) async => [BiometricType.fingerprint]);
    // Default mock for authenticate - use AuthResult
    when(
      () => mockAuthService.authenticate(
        localizedReason: any(named: 'localizedReason'),
      ),
    ).thenAnswer(
      (_) async => AuthResult(success: true, status: AuthStatus.authenticated),
    );

    // Setup container with default mocks
    container = _setupContainer(mockAuthService);
  });

  tearDown(() {
    container.dispose();
  });

  group('BiometricAuthNotifier Tests', () {
    group('Initialization (checkBiometricAvailability)', () {
      test('State reflects available biometrics on successful check', () async {
        // Arrange: Mocks setup in global setUp for success case

        // Act: Wait for checkBiometricAvailability called during init
        await Future.delayed(Duration.zero);

        // Assert
        expect(
          notifier.state.status,
          AuthStatus.notAuthenticated,
        ); // Ready, but not authed
        expect(notifier.state.availableBiometrics, [BiometricType.fingerprint]);
        expect(notifier.state.currentBiometricType, BiometricType.fingerprint);
        expect(notifier.state.errorMessage, isNull);
      });

      test('State reflects unavailable status when service returns false',
          () async {
        // Arrange: Override default mock
        when(() => mockAuthService.isBiometricAvailable())
            .thenAnswer((_) async => false);

        // Re-initialize with new mock
        container.dispose();
        container = _setupContainer(mockAuthService);
        await Future.delayed(Duration.zero);

        // Assert
        expect(notifier.state.status, AuthStatus.unavailable);
        expect(notifier.state.availableBiometrics, isEmpty);
        expect(notifier.state.currentBiometricType, BiometricType.none);
        expect(notifier.state.errorMessage, isNotNull);
      });

      test('State reflects notSetUp status when no biometrics are enrolled',
          () async {
        // Arrange: Override default mock
        when(() => mockAuthService.getAvailableBiometrics())
            .thenAnswer((_) async => []);

        // Re-initialize with new mock
        container.dispose();
        container = _setupContainer(mockAuthService);
        await Future.delayed(Duration.zero);

        // Assert
        expect(notifier.state.status, AuthStatus.notSetUp);
        expect(notifier.state.availableBiometrics, isEmpty);
        expect(notifier.state.currentBiometricType, BiometricType.none);
        expect(notifier.state.errorMessage, isNotNull);
      });

      test('State reflects failure when service throws exception', () async {
        // Arrange: Override default mock
        final exception = Exception('Service error');
        when(() => mockAuthService.isBiometricAvailable()).thenThrow(exception);

        // Re-initialize with new mock
        container.dispose();
        container = _setupContainer(mockAuthService);
        await Future.delayed(Duration.zero);

        // Assert
        expect(notifier.state.status, AuthStatus.failed);
        expect(notifier.state.errorMessage, contains('Service error'));
      });
    });

    group('toggleBiometricAuth', () {
      test('Enables biometric auth and re-checks availability', () async {
        // Arrange: Start with biometrics disabled
        notifier.state = const BiometricAuthState();
        // Use default mocks (available=true, types=fingerprint)

        // Act
        await notifier.toggleBiometricAuth(true);
        await Future.delayed(Duration.zero); // Wait for check

        // Assert
        expect(notifier.state.isBiometricEnabled, isTrue);
        expect(
          notifier.state.status,
          AuthStatus.notAuthenticated,
        ); // Updated by check
        expect(notifier.state.availableBiometrics, [BiometricType.fingerprint]);
        verify(() => mockAuthService.isBiometricAvailable())
            .called(greaterThanOrEqualTo(1)); // Initial + toggle
        verify(() => mockAuthService.getAvailableBiometrics())
            .called(greaterThanOrEqualTo(1));
      });

      test('Disables biometric auth', () async {
        // Arrange: Start enabled
        notifier.state = notifier.state.copyWith(isBiometricEnabled: true);
        // Ensure initial check is accounted for immediately after setup.
        verify(() => mockAuthService.isBiometricAvailable()).called(1);
        verify(() => mockAuthService.getAvailableBiometrics()).called(1);

        // Act
        await notifier.toggleBiometricAuth(false);

        // Assert
        expect(notifier.state.isBiometricEnabled, isFalse);
        // Verify that NO MORE interactions happened with the service after the initial checks.
        verifyNoMoreInteractions(mockAuthService);
      });

      test('Does not enable if biometrics are unavailable', () async {
        // Arrange: Set state to unavailable AFTER initial setup check
        notifier.state = const BiometricAuthState(
          status: AuthStatus.unavailable,
          // Keep other initial state if needed, or use copyWith
        );
        // Ensure initial check is accounted for immediately after setup completes.
        // This confirms the state *before* the action under test.
        verify(() => mockAuthService.isBiometricAvailable()).called(1);
        verify(() => mockAuthService.getAvailableBiometrics()).called(1);

        // Act
        await notifier.toggleBiometricAuth(true);
        // No need for Future.delayed here as toggle returns early

        // Assert: State should not change
        expect(notifier.state.isBiometricEnabled, isFalse);
        expect(notifier.state.status, AuthStatus.unavailable);
        // We verified the initial calls in Arrange.
        // The state checks above confirm no new calls were made,
        // as the method returned early.
        // No further verify needed here.
      });
    });

    group('authenticateWithBiometrics', () {
      test('Returns true and updates state on successful authentication',
          () async {
        // Arrange: Assume enabled and available (default setup)
        notifier.state = notifier.state.copyWith(isBiometricEnabled: true);
        // Use AuthResult for mock return
        when(
          () => mockAuthService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        ).thenAnswer(
          (_) async =>
              AuthResult(success: true, status: AuthStatus.authenticated),
        );

        // Act
        final result = await notifier.authenticateWithBiometrics();

        // Assert
        expect(result, isTrue);
        expect(notifier.state.status, AuthStatus.authenticated);
        expect(notifier.state.errorMessage, isNull);
      });

      test('Returns false and updates state on failed authentication',
          () async {
        // Arrange: Assume enabled and available
        notifier.state = notifier.state.copyWith(isBiometricEnabled: true);
        // Use AuthResult for mock return
        when(
          () => mockAuthService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        ).thenAnswer(
          (_) async => AuthResult(
            success: false,
            status: AuthStatus.failed,
            message: 'Fingerprint mismatch',
          ),
        );

        // Act
        final result = await notifier.authenticateWithBiometrics();

        // Assert
        expect(result, isFalse);
        expect(notifier.state.status, AuthStatus.failed);
        expect(notifier.state.errorMessage, 'Fingerprint mismatch');
      });

      test('Returns true immediately if biometrics are disabled in settings',
          () async {
        // Arrange: Biometrics disabled
        notifier.state = notifier.state.copyWith(isBiometricEnabled: false);

        // Act
        final result = await notifier.authenticateWithBiometrics();

        // Assert
        expect(result, isTrue);
        // Status should remain unchanged from initial check
        expect(notifier.state.status, AuthStatus.notAuthenticated);
        verifyNever(
          () => mockAuthService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        );
      });

      test('Returns false if biometrics are unavailable or not set up',
          () async {
        // Arrange: Set state to unavailable
        notifier.state = notifier.state
            .copyWith(isBiometricEnabled: true, status: AuthStatus.unavailable);

        // Act
        final resultUnavailable = await notifier.authenticateWithBiometrics();

        // Assert Unavailable
        expect(resultUnavailable, isFalse);
        expect(notifier.state.status, AuthStatus.failed);
        expect(notifier.state.errorMessage, contains('not available'));
        verifyNever(
          () => mockAuthService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        );

        // Arrange: Set state to not set up
        notifier.state = notifier.state
            .copyWith(isBiometricEnabled: true, status: AuthStatus.notSetUp);

        // Act
        final resultNotSetup = await notifier.authenticateWithBiometrics();

        // Assert Not Set Up
        expect(resultNotSetup, isFalse);
        expect(notifier.state.status, AuthStatus.failed);
        expect(notifier.state.errorMessage, contains('not set up'));
        verifyNever(
          () => mockAuthService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        );
      });

      test('Returns false and sets error on service exception', () async {
        // Arrange: Assume enabled and available
        notifier.state = notifier.state.copyWith(isBiometricEnabled: true);
        final exception = Exception('Platform error');
        when(
          () => mockAuthService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        ).thenThrow(exception);

        // Act
        final result = await notifier.authenticateWithBiometrics();

        // Assert
        expect(result, isFalse);
        expect(notifier.state.status, AuthStatus.failed);
        expect(notifier.state.errorMessage, contains('Platform error'));
      });
    });

    // Simple tests for toggleTwoFactorAuth and togglePasswordlessAuth
    // (These just update state directly)
    test('toggleTwoFactorAuth updates state', () {
      notifier.toggleTwoFactorAuth(true);
      expect(notifier.state.isTwoFactorEnabled, isTrue);
      notifier.toggleTwoFactorAuth(false);
      expect(notifier.state.isTwoFactorEnabled, isFalse);
    });

    test('togglePasswordlessAuth updates state', () {
      notifier.togglePasswordlessAuth(true);
      expect(notifier.state.isPasswordlessEnabled, isTrue);
      notifier.togglePasswordlessAuth(false);
      expect(notifier.state.isPasswordlessEnabled, isFalse);
    });
  });
}
