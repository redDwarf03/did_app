import 'package:did_app/domain/identity/digital_identity.dart';

/// Interface defining the contract for managing the user's digital identity.
///
/// This repository handles operations related to the creation, retrieval, and update
/// of digital identity ([DigitalIdentity]). It serves as a bridge between the user interface,
/// application logic, and the underlying identity system (secure storage, blockchain).
///
/// **Regulatory & Technical Context:**
/// - **GDPR:** Implementations must ensure compliance with data protection regulations.
/// - **SSI (Self-Sovereign Identity):** The repository pattern supports SSI principles by
///   abstracting storage and management, assuming user control is exercised through
///   the connected wallet.
/// - **eIDAS 2.0 & EUDI Wallet:** This repository manages data that could potentially
///   populate a European Digital Identity Wallet (EUDI Wallet).
/// - **DID (Decentralized Identifiers):** Implementations may interact with DIDs
///   (e.g., using the `identityAddress` from [DigitalIdentity]) to anchor data or
///   link the profile to a DID controlled by the user's wallet.
///   See W3C DID Core specification: https://www.w3.org/TR/did-core/
abstract class IdentityRepository {
  /// Checks if a digital identity profile exists for the connected user.
  ///
  /// Returns `true` if an identity exists, `false` otherwise.
  Future<bool> hasIdentity();

  /// Creates a new digital identity profile associated with the connected wallet.
  ///
  /// This process typically involves:
  /// 1. Collecting the display name chosen by the user
  /// 2. Generating or associating a DID ([DigitalIdentity.identityAddress]) controlled by the wallet
  /// 3. Securely storing the profile data under user control (SSI principle)
  ///
  /// - [displayName]: The public name chosen by the user for the identity.
  ///
  /// **Note:** In accordance with SSI principles and eIDAS 2.0, Personally Identifiable
  /// Information (PII) is NOT stored directly in the identity, but managed
  /// separately through Verifiable Credentials.
  ///
  /// Returns the newly created [DigitalIdentity] profile.
  Future<DigitalIdentity> createIdentity({
    required String displayName,
  });

  /// Retrieves the digital identity profile associated with the connected wallet.
  ///
  /// Assumes the connection implies user authorization to access their own data.
  ///
  /// Returns the [DigitalIdentity] if found, otherwise `null`.
  Future<DigitalIdentity?> getIdentity();

  /// Updates an existing digital identity profile.
  ///
  /// Requires the user (via the connected wallet) to authorize the changes,
  /// reflecting user control (SSI).
  ///
  /// - [identity]: The [DigitalIdentity] object containing the updated information.
  ///
  /// Returns the updated [DigitalIdentity].
  Future<DigitalIdentity> updateIdentity({
    required DigitalIdentity identity,
  });

  /// Deletes the current user's digital identity.
  ///
  /// This operation must be secure and should only be possible with explicit
  /// user authorization, in accordance with the SSI principle of user control.
  ///
  /// Note: In a blockchain identity context, deletion might mean
  /// revocation of control rather than complete data removal.
  Future<void> deleteIdentity();
}
