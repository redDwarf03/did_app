import 'package:did_app/domain/identity/digital_identity.dart';

/// Abstract interface defining the contract for managing the user's core digital identity profile.
///
/// This repository handles operations related to the creation, retrieval, and update
/// of the detailed [DigitalIdentity] (the model containing [PersonalInfo]). It acts
/// as a bridge between the user interface/application logic, the connected wallet
/// (representing user control), and the underlying identity system (e.g., secure storage, blockchain).
/// Implementations must ensure compliance with relevant data protection regulations like GDPR
/// when handling [PersonalInfo].
///
/// **Regulatory & Technical Context:**
/// - **GDPR:** Implementations MUST handle [PersonalInfo] in strict compliance with GDPR,
///   ensuring lawful basis for processing, data minimization, purpose limitation, security,
///   and user rights (e.g., access, rectification). See Regulation (EU) 2016/679.
///   eIDAS 2.0 (Recital 9) reaffirms the applicability of GDPR.
/// - **SSI (Self-Sovereign Identity):** The repository pattern supports SSI principles by
///   abstracting the storage and management, assuming user control is exerted via the
///   connected wallet. The user initiates actions like creation and updates.
/// - **KYC/AML:** The collection and management of [PersonalInfo] via this repository are
///   often essential steps in fulfilling Know Your Customer (KYC) and Anti-Money Laundering (AML)
///   requirements for accessing regulated services.
/// - **eIDAS 2.0 & EUDI Wallet:** This repository manages the data that could potentially
///   populate a European Digital Identity Wallet (EUDI Wallet). The `createIdentity`
///   process relates to user onboarding, which under eIDAS 2.0 may need to meet specific
///   assurance levels (Substantial or High - Recital 28). The wallet aims to provide users
///   with sole control over their identity data (Recital 5).
/// - **DID (Decentralized Identifiers):** While managing the detailed profile, implementations
///   might interact with DIDs (e.g., using the `identityAddress` from [DigitalIdentity])
///   for anchoring data or linking the profile to a DID controlled by the user's wallet.
///   See W3C DID Core specification: https://www.w3.org/TR/did-core/
abstract class IdentityRepository {
  /// Checks if a digital identity profile exists for the currently connected wallet/user.
  ///
  /// This verifies if an identity has been previously created or associated with the
  /// controlling key/wallet, which acts as the proof of control in an SSI context.
  ///
  /// Returns `true` if an identity exists, `false` otherwise.
  Future<bool> hasIdentity();

  /// Creates a new digital identity profile associated with the connected wallet.
  ///
  /// This process typically involves:
  /// 1. Collecting necessary identity attributes ([PersonalInfo]) and display name.
  /// 2. Obtaining user consent (essential for GDPR compliance regarding PII).
  /// 3. Potentially generating or associating a DID ([DigitalIdentity.identityAddress]) controlled by the wallet.
  /// 4. Securely storing the profile data under user control (SSI principle).
  /// 5. Optionally initiating verification processes (relevant for KYC/AML or achieving
  ///    specific assurance levels, like those discussed in eIDAS 2.0 - Recital 28).
  ///
  /// - [displayName]: The public name chosen by the user for the identity.
  /// - [personalInfo]: The sensitive personal information provided by the user. Handling
  ///   this data requires strict adherence to GDPR principles (data minimization,
  ///   security, purpose limitation). Collection is often linked to KYC requirements.
  ///
  /// **Note:** The goal is often to populate a user-controlled identity wallet (like the
  /// concept of the EUDI Wallet - eIDAS 2.0 Recital 5), requiring secure and
  /// privacy-preserving onboarding.
  ///
  /// Returns the newly created [DigitalIdentity] profile.
  Future<DigitalIdentity> createIdentity({
    required String displayName,
    required PersonalInfo personalInfo,
  });

  /// Retrieves the digital identity profile associated with the connected wallet.
  ///
  /// Assumes the connection implies user authorization to access their own identity data.
  ///
  /// Returns the [DigitalIdentity] if found, otherwise `null`.
  Future<DigitalIdentity?> getIdentity();

  /// Updates an existing digital identity profile.
  ///
  /// Requires the user (via the connected wallet) to authorize the changes, reflecting
  /// user control (SSI).
  /// Updates to [PersonalInfo] must comply with GDPR (right to rectification) and may
  /// impact verification status or trigger re-verification processes (KYC/AML).
  /// This conceptually aligns with the `update` operation for DID Documents, allowing
  /// modification of associated data under controller authorization (W3C DID Spec §8.2).
  ///
  /// - [identity]: The [DigitalIdentity] object containing the updated information.
  ///
  /// Returns the updated [DigitalIdentity].
  Future<DigitalIdentity> updateIdentity({
    required DigitalIdentity identity,
  });
}
