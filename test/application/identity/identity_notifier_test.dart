import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock IdentityRepository
class MockIdentityRepository extends Mock implements IdentityRepository {}

// Create Fake class for Fallback registration
class FakeDigitalIdentity extends Fake implements DigitalIdentity {}

void main() {
  // Register fallback values BEFORE tests run
  setUpAll(() {
    registerFallbackValue(FakeDigitalIdentity());
  });

  late MockIdentityRepository mockRepository;
  late ProviderContainer container;
  late IdentityNotifier notifier;

  // Sample DigitalIdentity for testing
  final testIdentity = DigitalIdentity(
    identityAddress: 'did:mock:123',
    displayName: 'Tester',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // Helper function to reset container and notifier with current mock setup
  ProviderContainer _initializeContainerAndNotifier() {
    final newContainer = ProviderContainer(
      overrides: [
        identityRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    // Read the notifier to trigger its initialization
    notifier = newContainer.read(identityNotifierProvider.notifier);
    return newContainer;
  }

  setUp(() {
    mockRepository = MockIdentityRepository();
    // --- Correction: Ensure initial mocks are always set in setUp ---
    // Default setup for tests assuming no initial identity exists
    when(() => mockRepository.hasIdentity()).thenAnswer((_) async => false);
    // Provide a default for getIdentity even if not expected, avoids null errors
    when(() => mockRepository.getIdentity())
        .thenAnswer((_) async => testIdentity);
    // Provide defaults for create/update to avoid null errors if called unexpectedly
    when(
      () => mockRepository.createIdentity(
        displayName: any(named: 'displayName'),
      ),
    ).thenAnswer((_) async => testIdentity);
    when(() => mockRepository.updateIdentity(identity: any(named: 'identity')))
        .thenAnswer((_) async => testIdentity);

    // Initialize container and notifier using the default mocks
    container = _initializeContainerAndNotifier();
  });

  tearDown(() {
    // Dispose the container after each test.
    container.dispose();
  });

  group('IdentityNotifier Tests', () {
    // Test relies on the default mock from setUp: hasIdentity returns false
    test('Initial state is correct (no identity)', () async {
      // Arrange: Default mock from setUp (hasIdentity -> false)

      // Act: Notifier initialized in setUp. Wait for async constructor logic.
      await Future.delayed(Duration.zero);

      // Assert: Check initial state
      expect(notifier.state.isLoading, false);
      expect(notifier.state.identity, null);
      expect(notifier.state.errorMessage, null);
    });

    test('Loads existing identity on initialization', () async {
      // Arrange: Override default mocks for this specific test
      when(() => mockRepository.hasIdentity()).thenAnswer((_) async => true);
      when(() => mockRepository.getIdentity())
          .thenAnswer((_) async => testIdentity);

      // Re-initialize container WITH THE NEW MOCKS
      container.dispose();
      container = _initializeContainerAndNotifier();

      // Act: Wait for the async initialization to complete
      await Future.delayed(Duration.zero); // Allow microtasks to complete

      // Assert: Check state reflects the loaded identity
      expect(notifier.state.isLoading, false);
      expect(notifier.state.identity, testIdentity);
      expect(notifier.state.errorMessage, null);
    });

    test('createIdentity successful path', () async {
      // Arrange: Use default mock (hasIdentity->false)
      // Override createIdentity for success case
      when(
        () => mockRepository.createIdentity(
          displayName: any(named: 'displayName'),
        ),
      ).thenAnswer((_) async => testIdentity);

      // Act: Call createIdentity
      await notifier.createIdentity(
        displayName: 'Tester',
        fullName: 'Test User',
        email: 'test@example.com',
      );

      // Assert: Check state after creation
      expect(notifier.state.isLoading, false);
      expect(notifier.state.identity, testIdentity);
      expect(notifier.state.errorMessage, null);
      // Verify specific call was made
      verify(
        () => mockRepository.createIdentity(
          displayName: 'Tester',
        ),
      ).called(1);
    });

    test('createIdentity fails if identity already exists', () async {
      // Arrange: Override default mock
      when(() => mockRepository.hasIdentity()).thenAnswer((_) async => true);
      // No need to mock getIdentity here if we trust the initial state setting

      // Re-initialize container with the new mocks and get notifier
      container.dispose();
      container = _initializeContainerAndNotifier();
      // Wait for potential initial load triggered by re-init
      await Future.delayed(Duration.zero);
      // Ensure state reflects existing identity *before* calling create
      notifier.state = IdentityState(identity: testIdentity);

      // Act: Call createIdentity
      await notifier.createIdentity(
        displayName: 'NewTester',
        fullName: 'New User',
        email: 'new@example.com',
      );

      // Assert: Check state shows error, identity unchanged
      expect(notifier.state.isLoading, false);
      expect(
        notifier.state.identity,
        testIdentity,
      ); // Identity should not change
      expect(
        notifier.state.errorMessage,
        'An identity already exists for this user.',
      );
      verifyNever(
        () => mockRepository.createIdentity(
          displayName: any(named: 'displayName'),
        ),
      );
    });

    test('createIdentity handles repository error', () async {
      // Arrange: Use default mock (hasIdentity->false)
      // Override createIdentity to throw an error
      final exception = Exception('Network Error');
      when(
        () => mockRepository.createIdentity(
          displayName: any(named: 'displayName'),
        ),
      ).thenThrow(exception);

      // Act: Call createIdentity
      await notifier.createIdentity(
        displayName: 'Tester',
        fullName: 'Test User',
        email: 'test@example.com',
      );

      // Assert: Check state shows error, identity is null
      expect(notifier.state.isLoading, false);
      expect(notifier.state.identity, null);
      expect(
        notifier.state.errorMessage,
        'Failed to create identity: $exception',
      );
    });

    test('updateIdentity successful path', () async {
      // Arrange:
      final updatedIdentity =
          testIdentity.copyWith(displayName: 'Updated Tester');

      // Override updateIdentity mock for success
      when(
        () => mockRepository.updateIdentity(identity: any(named: 'identity')),
      ).thenAnswer((_) async => updatedIdentity);

      // Set initial state with an existing identity for the test
      notifier.state = IdentityState(identity: testIdentity);

      // Act: Call updateIdentity
      await notifier.updateIdentity(
        displayName: 'Updated Tester',
      );

      // Assert: Check state reflects the updated identity
      expect(notifier.state.isLoading, false);
      expect(notifier.state.identity, updatedIdentity);
      expect(notifier.state.errorMessage, null);

      // Verify that updateIdentity was called with the correctly updated object
      final captured = verify(
        () => mockRepository.updateIdentity(
          identity: captureAny(named: 'identity'),
        ),
      ).captured;
      expect(captured.length, 1);
      final passedIdentity = captured.first as DigitalIdentity;
      expect(passedIdentity.displayName, 'Updated Tester');
      expect(
        passedIdentity.identityAddress,
        testIdentity.identityAddress,
      ); // Ensure non-updated fields remain
    });

    test('updateIdentity fails if no identity exists', () async {
      // Arrange: Ensure notifier starts with no identity state
      // Use default mock (hasIdentity->false)
      notifier.state =
          const IdentityState(); // Reset state to no identity explicitly
      // --- Correction: Ensure mocks are set in Arrange phase ---
      // No specific mocks needed here as we expect it to fail early

      // Act: Call updateIdentity
      await notifier.updateIdentity(
        displayName: 'Updated Name',
      );

      // Assert: Check state shows error, identity is still null
      expect(notifier.state.isLoading, false);
      expect(notifier.state.identity, null);
      expect(notifier.state.errorMessage, 'No identity exists to update.');
      verifyNever(
        () => mockRepository.updateIdentity(identity: any(named: 'identity')),
      );
    });

    test('updateIdentity handles repository error', () async {
      // Arrange: Override updateIdentity mock to throw error
      final exception = Exception('Update Failed');
      when(
        () => mockRepository.updateIdentity(identity: any(named: 'identity')),
      ).thenThrow(exception);

      // Set initial state with an existing identity
      notifier.state = IdentityState(identity: testIdentity);

      // Act: Call updateIdentity
      await notifier.updateIdentity(
        displayName: 'Updated Name',
      );

      // Assert: Check state shows error, identity remains unchanged
      expect(notifier.state.isLoading, false);
      expect(
        notifier.state.identity,
        testIdentity,
      ); // Identity should not change on error
      expect(
        notifier.state.errorMessage,
        'Failed to update identity: $exception',
      );
    });

    test('refreshIdentity calls _checkForExistingIdentity', () async {
      // Arrange: Set mocks for the check that refreshIdentity will trigger
      when(() => mockRepository.hasIdentity()).thenAnswer((_) async => true);
      when(() => mockRepository.getIdentity())
          .thenAnswer((_) async => testIdentity);

      // Act: Call refreshIdentity
      await notifier.refreshIdentity();
      await Future.delayed(Duration.zero); // Allow async operations to complete

      // Assert: Verify that the repository methods for checking were called again
      // Need to account for calls during setUp/initialization + the refresh call.
      // Use `captureAny` or adjust `called()` expectation based on exact init flow.
      verify(() => mockRepository.hasIdentity())
          .called(greaterThanOrEqualTo(2)); // Initial check + refresh
      verify(() => mockRepository.getIdentity())
          .called(greaterThanOrEqualTo(1)); // Called if hasIdentity is true
      // State should reflect the re-fetched identity
      expect(notifier.state.identity, testIdentity);
    });
  });
}
