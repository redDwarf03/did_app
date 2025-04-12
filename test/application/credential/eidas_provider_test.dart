import 'package:did_app/application/credential/eidas_provider.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/domain/verification/verification_result.dart';
import 'package:did_app/infrastructure/credential/eidas_credential_service.dart'
    as infra_eidas_service;
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/infrastructure/credential/revocation_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' hide VerificationResult;

import 'eidas_provider_test.mocks.dart'; // Generated mocks

// Mocks - REMOVE Manual Mocks
// class MockEidasCredentialService extends Mock
//     implements infra_eidas_service.EidasCredentialService {}
//
// class MockEidasTrustList extends Mock implements EidasTrustList {}
//
// class MockEuTrustRegistryService extends Mock implements EuTrustRegistryService {}

// Define a custom mock class with a unique name for EidasCredentialService
@GenerateMocks(
  [infra_eidas_service.EidasCredentialService],
  customMocks: [
    MockSpec<infra_eidas_service.EidasCredentialService>(
      as: #GenMockEidasCredentialService,
    ),
  ],
)
// Add annotation to generate mock for EidasTrustList
@GenerateMocks([EidasTrustList])
void main() {
  late GenMockEidasCredentialService mockEidasService;
  late MockEidasTrustList mockTrustList;
  // ProviderContainer is typically created inside testWidgets
  // late ProviderContainer container;

  // Sample Data
  final sampleCredential = Credential(
    context: ['https://www.w3.org/2018/credentials/v1'],
    id: 'http://example.gov/credentials/3732',
    type: ['VerifiableCredential', 'UniversityDegreeCredential'],
    issuer: 'https://example.edu/issuers/14',
    issuanceDate: DateTime.parse('2010-01-01T19:23:24Z'),
    credentialSubject: {
      'id': 'did:example:ebfeb1f712ebc6f1c276e12ec21',
      'degree': {
        'type': 'BachelorDegree',
        'name': 'Baccalauréat en musiques numériques',
      },
    },
    status: {
      'id': 'https://example.edu/status/24',
      'type': 'CredentialStatusList2017',
    },
    proof: {},
  );
  final sampleEidasCredential = EidasCredential(
    id: 'eidas-cred-1',
    type: ['VerifiableCredential', 'VerifiableAttestation'],
    issuer: const EidasIssuer(id: 'did:example:eidas-issuer'),
    issuanceDate: DateTime.now(),
    credentialSubject: {'id': 'did:example:holder', 'attribute': 'att-value'},
    proof: EidasProof(
      type: 'a',
      created: DateTime.now(),
      verificationMethod: 'b',
      proofPurpose: 'c',
      proofValue: 'd',
    ),
  );

  // Define sample data needed for trust list mocks
  final sampleTrustedIssuers = <TrustedIssuer>[
    /* ... populate if needed ... */
  ];
  final sampleReport = <String, dynamic>{'count': 0};
  final sampleSyncDate = DateTime(2024);

  setUp(() {
    // Initialize mocks
    mockEidasService = GenMockEidasCredentialService();
    mockTrustList = MockEidasTrustList();

    // Mock EidasTrustList methods called during INITIALIZATION
    when(mockTrustList.getLastSyncDate())
        .thenAnswer((_) async => sampleSyncDate);
    when(mockTrustList.getAllTrustedIssuers())
        .thenAnswer((_) async => sampleTrustedIssuers);
    when(mockTrustList.generateTrustListReport())
        .thenAnswer((_) async => sampleReport);

    // Create the container, overriding the notifier provider to inject mocks
    // container = ProviderContainer(
    //   overrides: [
    //     // Override the notifier itself to inject mocks
    //     eidasNotifierProvider.overrideWith((ref) {
    //       // The ref here is for the OVERRIDDEN provider
    //       // Create the notifier manually, injecting mocks
    //       // We don't watch dependencies here, we pass the mocks directly
    //       final notifier = EidasNotifier(
    //         ref, // Pass the ref for potential future use inside notifier
    //         mockEidasService, // Pass the mocked service
    //         mockTrustList, // Pass the mocked trust list
    //       );
    //       // Ensure initialization mocks are setup BEFORE returning notifier
    //       // (Already done above with when calls)
    //       return notifier;
    //     }),
    //     // We no longer need to override eidasCredentialServiceProvider directly,
    //     // as it's handled by the eidasNotifierProvider override.
    //     // eidasCredentialServiceProvider.overrideWithValue(mockEidasService),
    //   ],
    // );

    // Reading the notifier here will trigger its creation with mocks
    // final notifier = container.read(eidasNotifierProvider.notifier);
  });

  // tearDown is less common with testWidgets as container is often local

  group('EidasNotifier Tests', () {
    // Use testWidgets for tests involving async operations and Riverpod
    testWidgets('Initial state is correct after initialization',
        (tester) async {
      // Create container specific to this test
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith((ref) {
            final notifier = EidasNotifier(
              ref,
              mockEidasService,
              mockTrustList,
            );
            return notifier;
          }),
        ],
      );

      // Read the notifier - this triggers constructor and async calls
      final notifier = container.read(eidasNotifierProvider.notifier);

      // Allow async operations in constructor to complete
      await tester.pumpAndSettle(); // Pump until animations settle

      // Now check the state
      expect(notifier.state.isLoading, false);
      expect(notifier.state.isEudiWalletAvailable, true); // Should be true now
      expect(notifier.state.errorMessage, null);
      expect(notifier.state.lastSyncDate, sampleSyncDate);
      expect(notifier.state.trustedIssuers, sampleTrustedIssuers);
      expect(notifier.state.trustListReport, sampleReport);

      // Dispose container at the end of the test
      addTearDown(container.dispose);
    });

    testWidgets('importFromJson calls service and updates state',
        (tester) async {
      // Setup container and notifier for this test
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle(); // Wait for init

      const jsonString = '{"@context": "...", "id": "...", ...}';
      when(mockEidasService.importFromJson(jsonString))
          .thenAnswer((_) async => sampleCredential);

      // Act
      await notifier.importFromJson(jsonString);
      await tester.pump(); // Allow state update future to complete

      // Assert
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      verify(mockEidasService.importFromJson(jsonString)).called(1);
    });

    testWidgets('importFromJson handles errors', (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      const jsonString = '{}';
      final exception = Exception('Import failed');
      when(mockEidasService.importFromJson(jsonString)).thenThrow(exception);

      await notifier.importFromJson(jsonString);
      await tester.pump();

      expect(notifier.state.isLoading, false);
      expect(
        notifier.state.errorMessage,
        contains('Error importing from JSON'),
      );
      verify(mockEidasService.importFromJson(jsonString)).called(1);
    });

    // --- Apply testWidgets and pump pattern to ALL other tests ---

    testWidgets('exportToJson calls service and updates state', (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      const jsonResult = '{"@context": "...", "id": "...", ...}';
      when(mockEidasService.exportToJson(sampleCredential))
          .thenAnswer((_) async => jsonResult);
      final result = await notifier.exportToJson(sampleCredential);
      await tester.pump();

      expect(result, jsonResult);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      verify(mockEidasService.exportToJson(sampleCredential)).called(1);
    });

    testWidgets('exportToJson handles errors', (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      final exception = Exception('Export failed');
      when(mockEidasService.exportToJson(sampleCredential))
          .thenThrow(exception);
      final result = await notifier.exportToJson(sampleCredential);
      await tester.pump();

      expect(result, isNull);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, contains('Error exporting to JSON'));
      verify(mockEidasService.exportToJson(sampleCredential)).called(1);
    });

    testWidgets('isEidasCompatible calls service', (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      when(mockEidasService.isEidasCompatible(sampleCredential))
          .thenReturn(true);
      final result =
          notifier.isEidasCompatible(sampleCredential); // This is sync
      // No pump needed for sync call

      expect(result, true);
      verify(mockEidasService.isEidasCompatible(sampleCredential)).called(1);
    });

    testWidgets('makeEidasCompatible calls service and updates state',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      when(mockEidasService.makeEidasCompatible(sampleCredential))
          .thenAnswer((_) async => sampleCredential);
      final result = await notifier.makeEidasCompatible(sampleCredential);
      await tester.pump();

      expect(result, sampleCredential);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      verify(mockEidasService.makeEidasCompatible(sampleCredential)).called(1);
    });

    testWidgets('makeEidasCompatible handles errors', (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      final exception = Exception('Conversion failed');
      when(mockEidasService.makeEidasCompatible(sampleCredential))
          .thenThrow(exception);
      final result = await notifier.makeEidasCompatible(sampleCredential);
      await tester.pump();

      expect(result, isNull);
      expect(notifier.state.isLoading, false);
      expect(
        notifier.state.errorMessage,
        contains('Error making credential eIDAS compatible'),
      );
      verify(mockEidasService.makeEidasCompatible(sampleCredential)).called(1);
    });

    testWidgets('importFromEudiWallet calls service (simulation)',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      when(mockEidasService.importFromEudiWallet())
          .thenAnswer((_) async => sampleCredential);
      final result = await notifier.importFromEudiWallet();
      await tester.pump();

      expect(result, sampleCredential);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      verify(mockEidasService.importFromEudiWallet()).called(1);
    });

    testWidgets('shareWithEudiWallet calls service (simulation)',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      when(mockEidasService.shareWithEudiWallet(sampleCredential))
          .thenAnswer((_) async => true);
      await notifier.shareWithEudiWallet(sampleCredential);
      await tester.pump();

      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      verify(mockEidasService.shareWithEudiWallet(sampleCredential)).called(1);
    });

    testWidgets(
        'verifyEidasCredential performs verification and revocation check',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      const verificationResult = VerificationResult(isValid: true);
      final validRevocationStatus = RevocationStatus(
        isRevoked: false,
        message: 'Test status valid',
        lastChecked: DateTime.now(),
      );
      when(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .thenAnswer((_) async => verificationResult);
      when(mockEidasService.checkRevocationStatus(sampleEidasCredential))
          .thenAnswer((_) async => validRevocationStatus);

      await notifier.verifyEidasCredential(sampleEidasCredential);
      await tester.pump();

      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      expect(notifier.state.verificationResult, verificationResult);
      expect(notifier.state.revocationStatus, validRevocationStatus);
      verify(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .called(1);
      verify(mockEidasService.checkRevocationStatus(sampleEidasCredential))
          .called(1);
    });

    testWidgets('verifyEidasCredential handles invalid signature',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      const verificationResult = VerificationResult(
        isValid: false,
        message: 'Invalid signature',
      );
      when(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .thenAnswer((_) async => verificationResult);

      await notifier.verifyEidasCredential(sampleEidasCredential);
      await tester.pump();

      expect(notifier.state.isLoading, false);
      expect(notifier.state.errorMessage, isNull);
      expect(notifier.state.verificationResult, verificationResult);
      expect(notifier.state.revocationStatus, null);
      verify(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .called(1);
      verifyNever(mockEidasService.checkRevocationStatus(any));
    });

    testWidgets('verifyEidasCredential handles revoked credential',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      const verificationResult = VerificationResult(isValid: true);
      final revokedStatus = RevocationStatus(
        isRevoked: true,
        message: 'Credential revoked',
        lastChecked: DateTime.now(),
      );
      when(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .thenAnswer((_) async => verificationResult);
      when(mockEidasService.checkRevocationStatus(sampleEidasCredential))
          .thenAnswer((_) async => revokedStatus);

      await notifier.verifyEidasCredential(sampleEidasCredential);
      await tester.pump();

      // Corrected assertions based on notifier logic
      expect(notifier.state.isLoading, false);
      expect(notifier.state.verificationResult?.isValid, false);
      expect(
        notifier.state.verificationResult?.message,
        contains(revokedStatus.message),
      );
      expect(notifier.state.revocationStatus, revokedStatus);
      expect(notifier.state.errorMessage, isNull);
      verify(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .called(1);
      verify(mockEidasService.checkRevocationStatus(sampleEidasCredential))
          .called(1);
    });

    testWidgets('verifyEidasCredential handles verification errors',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      final exception = Exception('Verification process failed');
      when(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .thenThrow(exception);

      await notifier.verifyEidasCredential(sampleEidasCredential);
      await tester.pump();

      // Corrected assertions based on notifier logic
      expect(notifier.state.isLoading, false);
      expect(notifier.state.verificationResult?.isValid, false);
      expect(
        notifier.state.verificationResult?.message,
        contains('Verification failed'),
      );
      expect(notifier.state.revocationStatus, null);
      // Correct expected error message substring
      expect(
        notifier.state.errorMessage,
        contains('Error verifying eIDAS credential'),
      );
      verify(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .called(1);
      verifyNever(mockEidasService.checkRevocationStatus(any));
    });

    testWidgets('verifyEidasCredential handles revocation check errors',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          eidasNotifierProvider.overrideWith(
            (ref) => EidasNotifier(ref, mockEidasService, mockTrustList),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(eidasNotifierProvider.notifier);
      await tester.pumpAndSettle();

      const verificationResult = VerificationResult(isValid: true);
      final exception = Exception('Revocation check failed');
      when(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .thenAnswer((_) async => verificationResult);
      when(mockEidasService.checkRevocationStatus(sampleEidasCredential))
          .thenThrow(exception);

      await notifier.verifyEidasCredential(sampleEidasCredential);
      await tester.pump();

      // Corrected assertions based on notifier logic
      expect(notifier.state.isLoading, false);
      expect(
        notifier.state.verificationResult?.isValid,
        true,
      ); // Verification result is kept
      expect(notifier.state.revocationStatus, null);
      expect(
        notifier.state.errorMessage,
        contains('Error checking revocation status'),
      );
      verify(mockEidasService.verifyEidasCredential(sampleEidasCredential))
          .called(1);
      verify(mockEidasService.checkRevocationStatus(sampleEidasCredential))
          .called(1);
    });
  });
}
