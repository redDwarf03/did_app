import 'package:did_app/domain/credential/credential.dart';

/// Abstract interface defining the contract for managing Verifiable Credentials (VCs)
/// within the application's storage (e.g., a digital wallet).
///
/// This repository handles CRUD operations for [Credential] objects, as well as verification,
/// presentation creation, and sharing/receiving VCs and presentation requests.
/// Implementations will interact with the underlying secure storage mechanism.
/// See: W3C VC Data Model v2.0 - https://www.w3.org/TR/vc-data-model-2.0/
abstract class CredentialRepository {
  /// Retrieves all Verifiable Credentials currently held by the user/wallet.
  ///
  /// Returns a list of [Credential] objects.
  Future<List<Credential>> getCredentials();

  /// Retrieves a specific Verifiable Credential by its unique identifier (`id`).
  ///
  /// - [id]: The unique identifier (URI) of the credential to retrieve.
  ///
  /// Returns the [Credential] if found, otherwise `null`.
  Future<Credential?> getCredentialById(String id);

  /// Saves a Verifiable Credential to the user's wallet/storage.
  ///
  /// This typically involves storing the credential securely.
  ///
  /// - [credential]: The [Credential] object to save.
  Future<void> saveCredential(Credential credential);

  /// Deletes a Verifiable Credential from the user's wallet/storage.
  ///
  /// - [id]: The unique identifier of the credential to delete.
  Future<void> deleteCredential(String id);

  /// Verifies the integrity and authenticity of a specific Verifiable Credential.
  ///
  /// This typically involves:
  /// 1. Checking the cryptographic proof (e.g., signature).
  /// 2. Verifying the issuer's identity and authority.
  /// 3. Checking the credential's status (validity period, revocation status).
  /// See: W3C VC Data Model v2 §7.1 Verification
  ///
  /// - [credential]: The [Credential] to verify.
  ///
  /// Returns `true` if the credential is valid, `false` otherwise.
  Future<bool> verifyCredential(Credential credential);

  /// Creates a Verifiable Presentation (VP) containing selected claims from one or more credentials.
  ///
  /// This allows the holder to present specific information to a verifier without revealing
  /// the entire content of their credentials (selective disclosure).
  /// See: W3C VC Data Model v2 §3.3 Presentations
  ///
  /// - [credentials]: The list of [Credential] objects from which to derive the presentation.
  /// - [selectiveDisclosure]: A map defining which claims to disclose from which credential.
  ///   The key could be the credential ID, and the value a list of claim keys/paths to disclose.
  ///   (The exact structure depends on the selective disclosure mechanism used, e.g., SD-JWT, ZKP).
  /// - [challenge]: An optional nonce provided by the verifier to prevent replay attacks.
  /// - [domain]: An optional domain identifier provided by the verifier to prevent replays across domains.
  ///
  /// Returns a [CredentialPresentation] object ready to be shared.
  Future<CredentialPresentation> createPresentation({
    required List<Credential> credentials,
    // TODO: Define a more specific type for selectiveDisclosure based on the chosen mechanism.
    required Map<String, List<String>> selectiveDisclosure,
    String? challenge,
    String? domain,
  });

  /// Verifies a received Verifiable Presentation.
  ///
  /// This involves verifying the presentation's proof (holder's signature) and
  /// potentially verifying the included credentials (or the disclosed claims).
  /// See: W3C VC Data Model v2 §7.1 Verification
  ///
  /// - [presentation]: The [CredentialPresentation] to verify.
  ///
  /// Returns `true` if the presentation is valid, `false` otherwise.
  Future<bool> verifyPresentation(CredentialPresentation presentation);

  /// Prepares a Verifiable Presentation for sharing.
  ///
  /// This might involve encoding the presentation into a specific format (e.g., JWT, JSON-LD)
  /// and generating a URI, QR code data, or other shareable representation.
  ///
  /// - [presentation]: The [CredentialPresentation] to share.
  ///
  /// Returns a string representation suitable for sharing (e.g., URI, QR code payload).
  Future<String> sharePresentation(CredentialPresentation presentation);

  /// Receives and processes a Verifiable Credential, typically from a URI or QR code.
  ///
  /// This involves fetching the credential data from the source and potentially saving it
  /// after user confirmation.
  ///
  /// - [uri]: The URI or data string representing the credential.
  ///
  /// Returns the received [Credential].
  Future<Credential> receiveCredential(String uri);

  /// Receives and processes a request for a Verifiable Presentation.
  ///
  /// This involves fetching the request details (e.g., required credential types, claims,
  /// challenge, domain) from the source URI or QR code.
  ///
  /// - [uri]: The URI or data string representing the presentation request.
  ///
  /// Returns a map containing the details of the presentation request.
  /// TODO: Define a specific PresentationRequest model instead of Map<String, dynamic>.
  Future<Map<String, dynamic>> receivePresentationRequest(String uri);

  /// Provides a stream that emits updates whenever the list of stored credentials changes.
  ///
  /// Useful for reactive UI updates.
  ///
  /// Returns a [Stream] emitting lists of [Credential] objects.
  Stream<List<Credential>> watchCredentials();
}
