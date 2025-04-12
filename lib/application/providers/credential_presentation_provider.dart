import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/verification/verification_result.dart' as domain;
import 'package:did_app/infrastructure/credential/qualified_credential_service.dart'
    as infra;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'credential_presentation_provider.freezed.dart';

/// Represents the state for credential presentation management.
@freezed
class CredentialPresentationState with _$CredentialPresentationState {
  /// Creates an instance of [CredentialPresentationState].
  const factory CredentialPresentationState({
    /// Indicates if a presentation creation operation is in progress.
    @Default(false) bool loading,

    /// Indicates if a presentation verification operation is in progress.
    @Default(false) bool isValidating,

    /// The currently generated or processed credential presentation.
    CredentialPresentation? presentation,

    /// Holds a potential error message from the last operation.
    String? error,

    /// Holds the result of the last presentation verification.
    domain.VerificationResult? verificationResult,
  }) = _CredentialPresentationState;

  /// Private constructor for Freezed.
  const CredentialPresentationState._();

  // If serialization is needed:
  // factory CredentialPresentationState.fromJson(Map<String, dynamic> json) =>
  //     _$CredentialPresentationStateFromJson(json);
}

/// Provides an instance of [QualifiedCredentialService].
///
/// This service is used to check if credentials meet specific qualification
/// standards, such as eIDAS compliance.
final qualifiedCredentialServiceProvider =
    Provider<infra.QualifiedCredentialService>(
  (ref) => infra.QualifiedCredentialService(),
);

/// Provider for the [CredentialPresentationNotifier] which manages the [CredentialPresentationState].
final credentialPresentationProvider = StateNotifierProvider<
    CredentialPresentationNotifier, CredentialPresentationState>(
  CredentialPresentationNotifier.new,
);

/// Manages the state and orchestrates operations related to creating and verifying
/// Verifiable Presentations ([CredentialPresentation]).
///
/// Interacts with identity, credential, and qualification services.
class CredentialPresentationNotifier
    extends StateNotifier<CredentialPresentationState> {
  /// Creates an instance of [CredentialPresentationNotifier].
  /// Requires a [Ref] to access other providers.
  CredentialPresentationNotifier(this._ref)
      : super(const CredentialPresentationState()); // Use const constructor

  final Ref _ref;
  final _uuid = const Uuid();

  /// Creates a new Verifiable Presentation ([CredentialPresentation]) based on selected credentials.
  ///
  /// Takes a list of [credentialIds] to include, a map of [revealedAttributes]
  /// specifying which attributes to disclose for each credential, optional [predicates],
  /// and optional [challenge] and [domain] values often provided by the verifier.
  ///
  /// Returns the created [CredentialPresentation] or `null` if an error occurs.
  /// Updates the state with loading status, the resulting presentation, or an error message.
  Future<CredentialPresentation?> createPresentation({
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
    String? challenge,
    String? domain,
    // TODO: Add `message` parameter for non-repudiation or context?
    // String? message,
  }) async {
    state = state.copyWith(loading: true, error: null);

    try {
      // Ensure user has an identity
      final identity = _ref.read(identityNotifierProvider).identity;
      if (identity == null) {
        state = state.copyWith(
          loading: false,
          error: 'An identity is required to create a presentation',
        );
        return null;
      }

      // Retrieve and validate the selected credentials
      final credentialState = _ref.read(credentialNotifierProvider);
      final credentials = <Credential>[];

      for (final id in credentialIds) {
        final credential = credentialState.credentials.firstWhere(
          (c) => c.id == id,
          // TODO: Improve error handling - specific exception type?
          orElse: () => throw Exception('Credential not found: $id'),
        );
        // TODO: Check if credential is valid/not revoked before adding?
        credentials.add(credential);
      }

      if (credentials.isEmpty) {
        state = state.copyWith(
          loading: false,
          error:
              'At least one credential must be selected to create a presentation',
        );
        return null;
      }

      // Check qualification status (e.g., eIDAS) if relevant
      final qualifiedService = _ref.read(qualifiedCredentialServiceProvider);
      final qualifiedStatuses = await Future.wait(
        credentials.map(qualifiedService.isQualified),
      );

      // Define JSON-LD contexts
      // Base context + eIDAS context if applicable
      final contexts = <String>[
        'https://www.w3.org/2018/credentials/v1',
        // Add eIDAS context if any credential implies it or if required by policy
        // This logic might need refinement based on specific requirements
        if (qualifiedStatuses
            .any((q) => q)) // Example: Add if at least one is qualified
          'https://ec.europa.eu/digital-identity/credentials/v1',
      ];

      // Determine presentation types
      final types = ['VerifiablePresentation'];
      // Add specific types based on context or credential types
      // Example: Add EidasPresentation if all included credentials are qualified eIDAS credentials
      if (qualifiedStatuses.every((q) => q)) {
        types.add('EidasPresentation');
      }

      // Generate the proof for the presentation
      final proof = await _generateProof(
        identity: identity,
        credentials: credentials, // Pass credentials for context if needed
        challenge: challenge,
        domain: domain,
      );

      // Construct the presentation object
      final presentation = CredentialPresentation(
        // Use standard context or dynamically determined contexts
        context: contexts, // Now we can add the context
        id: 'urn:uuid:${_uuid.v4()}', // Generate a unique ID
        type: types,
        // Include the actual credential objects
        verifiableCredentials: credentials,
        // Specify revealed attributes (Selective Disclosure)
        // TODO: Implement actual selective disclosure based on revealedAttributes map
        // For now, includes full credentials. ZKP/BBS+ would handle this properly.
        revealedAttributes: revealedAttributes,
        // Include holder information (the user's DID)
        holder:
            'did:archethic:${identity.identityAddress}', // Now we can add the holder
        // Optional fields provided by the verifier
        challenge: challenge,
        domain: domain,
        // Timestamp
        created: DateTime.now(),
        // Attach the generated proof
        proof: proof,
        // TODO: Add predicates if provided and supported
        // predicates: predicates,
      );

      state = state.copyWith(loading: false, presentation: presentation);
      return presentation;
    } catch (e) {
      // TODO: Log error properly
      state = state.copyWith(
        loading: false,
        error: 'Error creating presentation: $e',
      );
      return null;
    }
  }

  /// Generates a proof for the presentation.
  ///
  /// This method simulates the signing process. In a real implementation,
  /// it would use the holder's private key associated with their DID
  /// to sign the presentation data according to the chosen proof type.
  /// The specific signing mechanism depends on the [proofType].
  Future<Map<String, dynamic>> _generateProof({
    required DigitalIdentity identity,
    required List<Credential> credentials, // Used to determine proof type
    String? challenge,
    String? domain,
  }) async {
    // In a real implementation, sign with the private key.
    // This mock simulates a proof compatible with potential requirements.

    final proofType = _determineProofType(credentials);

    // Construct the proof object according to VC Data Model v2.0
    return {
      'type': proofType,
      'created': DateTime.now().toIso8601String(),
      'proofPurpose':
          'authentication', // Or 'assertionMethod' depending on use case
      'verificationMethod':
          'did:archethic:${identity.identityAddress}#key-1', // Holder's verification method URL
      // The actual signature value would go here
      'proofValue': 'zMockSignatureValueForPresentationData...', // Placeholder
      if (challenge != null)
        'challenge': challenge, // Include challenge if provided
      if (domain != null) 'domain': domain, // Include domain if provided
    };
  }

  /// Determines the appropriate proof type based on the included credentials.
  ///
  /// Prefers Zero-Knowledge Proof schemes like BBS+ if all credentials support it,
  /// otherwise falls back to a standard signature type (e.g., EidasSignature).
  String _determineProofType(List<Credential> credentials) {
    // Prefer ZKP (BBS+) if all included credentials support it for selective disclosure
    if (credentials.isNotEmpty && credentials.every((c) => c.supportsZkp)) {
      return 'BbsBlsSignature2020'; // Example ZKP signature type
    }

    // Fallback to a standard signature type (e.g., Eidas or a default)
    // TODO: Determine the exact fallback type based on requirements (e.g., Eidas specific)
    return 'EidasSignature2023'; // Or a more general type like 'JsonWebSignature2020'
  }

  /// Verifies a received [CredentialPresentation].
  ///
  /// Performs several checks:
  /// 1. Basic structure (e.g., contains credentials).
  /// 2. Validity and revocation status of each included credential.
  /// 3. Qualification status if it's an eIDAS presentation.
  /// 4. Cryptographic signature/proof verification.
  ///
  /// Returns a [domain.VerificationResult] indicating success or failure with a message.
  /// Updates the state with validation status and the result.
  Future<domain.VerificationResult> verifyPresentation(
    CredentialPresentation presentation,
  ) async {
    state = state.copyWith(
        isValidating: true, verificationResult: null, error: null);

    try {
      // 1. Basic structural checks
      if (presentation.verifiableCredentials?.isEmpty ?? true) {
        // Check for null or empty
        final result = domain.VerificationResult(
          isValid: false,
          message: 'Presentation contains no credentials',
        );
        state = state.copyWith(isValidating: false, verificationResult: result);
        return result;
      }

      // 2. Verify individual credential validity and status
      // TODO: Implement robust credential status checks (revocation, expiration)
      final invalidCredentials = presentation.verifiableCredentials!.where(
        // Safe access after null/empty check
        (c) => !c.isValid || c.verificationStatus == VerificationStatus.invalid,
      ); // Simplified check

      if (invalidCredentials.isNotEmpty) {
        final invalidIds = invalidCredentials.map((c) => c.id).join(', ');
        final result = domain.VerificationResult(
          isValid: false,
          message:
              'Presentation contains invalid or revoked credentials: $invalidIds',
        );
        state = state.copyWith(isValidating: false, verificationResult: result);
        return result;
      }

      // 3. eIDAS-specific checks (if applicable)
      final isEidasPresentation =
          presentation.type.contains('EidasPresentation');
      if (isEidasPresentation) {
        final qualifiedService = _ref.read(qualifiedCredentialServiceProvider);

        // Ensure all credentials in an EidasPresentation are qualified
        final qualifiedStatuses = await Future.wait(
          presentation.verifiableCredentials! // Safe access
              .map(qualifiedService.isQualified),
        );

        if (!qualifiedStatuses.every((q) => q)) {
          final result = domain.VerificationResult(
            isValid: false,
            message: 'EidasPresentation contains non-qualified credentials',
          );
          state =
              state.copyWith(isValidating: false, verificationResult: result);
          return result;
        }
        // TODO: Add other eIDAS specific checks if needed
      }

      // 4. Verify the presentation's proof/signature
      final isSignatureValid = await _verifySignature(presentation);

      if (!isSignatureValid) {
        final result = domain.VerificationResult(
          isValid: false,
          message: 'Presentation signature is invalid',
        );
        state = state.copyWith(isValidating: false, verificationResult: result);
        return result;
      }

      // All checks passed
      final result = domain.VerificationResult(
        isValid: true,
        message: 'Presentation verified successfully',
      );
      state = state.copyWith(isValidating: false, verificationResult: result);
      return result;
    } catch (e) {
      // TODO: Log error properly
      final result = domain.VerificationResult(
        isValid: false,
        message: 'Error during presentation verification: $e',
      );
      state = state.copyWith(
          isValidating: false,
          verificationResult: result,
          error: result.message);
      return result;
    }
  }

  /// Verifies the signature/proof of the presentation.
  ///
  /// This method simulates the verification process. In a real implementation,
  /// it would involve:
  /// 1. Resolving the holder's DID (`verificationMethod` from the proof) to get their public key.
  /// 2. Canonicalizing the presentation data according to the proof type's algorithm.
  /// 3. Using the public key and algorithm to verify the `proofValue` against the canonicalized data.
  Future<bool> _verifySignature(CredentialPresentation presentation) async {
    // Simulate signature verification
    await Future.delayed(
        const Duration(milliseconds: 150)); // Simulate async work

    // TODO: Implement actual cryptographic verification based on presentation.proof
    // Steps:
    // 1. Get proof details (type, verificationMethod, proofValue, etc.)
    // 2. Resolve DID in verificationMethod to get public key.
    // 3. Prepare data to verify (canonicalize presentation minus proof).
    // 4. Perform cryptographic verification using the key, algorithm, data, and proofValue.

    // Mock result: Assume valid for now if proof exists
    return presentation.proof['proofValue'] != null;
  }

  /// Generates a sharing link for a presentation.
  /// TODO: Implement proper encoding (e.g., JWT) and link generation.
  String sharePresentation(String presentationId) {
    // In a real implementation, encode the presentation
    // into a suitable format (JWT, etc.) and generate a link
    return 'https://did.app/presentation/$presentationId';
  }

  /// Resets the provider state to its initial default values.
  void reset() {
    state = const CredentialPresentationState(); // Use const constructor
  }
}
