# DID App - European Digital Identity Wallet

A mobile digital identity wallet application compliant with eIDAS 2.0 and EUDI Wallet standards.

## 🌟 What is a Digital Identity?

Imagine your physical wallet, which holds your ID cards, driver's license, health insurance cards, and diplomas. Digital identity is exactly that, but on your phone!

This application allows you to:
- Store your identity documents digitally, securely, and certified
- Prove who you are online without sharing all your information
- Control what information you share, with whom, and when
- Use your identity documents to log in to online services

## 🇪🇺 EUDI Wallet & eIDAS 2.0: Why is it important?

### EUDI Wallet (European Digital Identity Wallet)
It's a standardized digital identity wallet for all European citizens. It will allow:
- Having a digital identity recognized throughout Europe
- Easy access to public and private services anywhere in the EU
- Strong protection of your personal data

### eIDAS 2.0
This is the European regulation that governs digital identities. It ensures that:
- Your digital identity is as reliable as a physical ID document
- The services you use can trust your digital attestations
- Your data is protected according to European standards
- Your privacy is respected through mechanisms like "selective disclosure" (sharing only necessary information)

## 🛡️ SSI (Self-Sovereign Identity) Approach: Your identity belongs to YOU

SSI is the philosophy behind our application. This means that:

- **You own** your identity data, not large corporations
- **You decide** what information to share, with whom, and when
- **You store** your attestations directly on your device
- **You control** your digital identity, without depending on intermediaries

## 🚀 Features for Beginners

### 1. Easy Identity Creation and Management
- Create your digital identity in a few clicks
- Import your official documents through simple, guided processes
- Easily manage your attestations with an intuitive interface

### 2. Simplified Information Sharing
- Share only the necessary information (e.g., prove you are over 18 without revealing your date of birth)
- Use QR codes for quick authentication
- Control who has access to your information with clear permissions

### 3. Accessible Security
- Protect your identity with facial recognition or fingerprint
- Receive clear alerts in case of security issues
- Easily recover access to your attestations if you lose your device

## 🏁 Getting Started

1. **Install the application** on your device
2. **Create your digital identity** by following the step-by-step guide
3. **Add your attestations** (ID card, driver's license, diplomas, etc.)
4. **Use your identity** for online or in-person services

## 🔧 Getting Started (Development)

Follow these steps to set up the development environment:

1.  **Prerequisites:**
    *   Ensure you have [Flutter](https://docs.flutter.dev/get-started/install) installed on your machine.
    *   Use a version manager like [asdf](https://asdf-vm.com/) with the Flutter plugin to manage the SDK versions specified in the `.tool-versions` file. Install the required versions:
        ```bash
        asdf install
        ```
    *   (Optional, if applicable) Run the initial setup script:
        ```bash
        ./setup.sh
        ```
        *(Note: Examine `setup.sh` to understand what it does before running it).*

2.  **Clone the repository:**
    ```bash
    git clone [https://github.com/redDwarf03/did_app](https://github.com/redDwarf03/did_app)
    cd did_app
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Generate code (if necessary):**
    If the project uses code generators (like `build_runner`), run:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Run the application:**
    ```bash
    flutter run
    ```

6.  **Useful commands:**
    *   Check for code issues: `flutter analyze`
    *   Run tests: `flutter test`

### 🧪 Testing

This project includes unit tests to ensure code quality and stability. To run all unit tests, use the following command at the project root:

```bash
flutter test
```

## Implemented Features

1. **Attestation Management**
   - Creation and storage of digital attestations
   - Support for W3C Verifiable Credentials formats
   - Verification of attestation integrity
   - Management of cryptographic proofs
   - Support for qualified attestations according to eIDAS 2.0
   - Integration with qualified trust services
   - Verification of qualified electronic signatures
   - Management of Levels of Assurance (Low, Substantial, High)

2. **Identity Wallet**
   - Secure storage of attestations
   - Private key management
   - Support for DIDs (Decentralized Identifiers)
   - Biometric authentication
   - Encryption of sensitive data
   - Support for qualified attestations
   - Integration with the European Trust Registry

3. **Secure Authentication**
   - Biometric authentication (fingerprint, facial recognition)
   - Multi-factor authentication (MFA) support
   - Cryptographic key management
   - Protection of sensitive data

4. **eIDAS 2.0 Interoperability**
   - Compliance with European standards
   - Support for eIDAS attestation formats
   - Integration with the European Trust Registry
   - Verification of trusted issuers
   - Filtering by country and trust level
   - Interoperability reports

5. **Security and Privacy**
   - End-to-end encryption
   - Secure data storage
   - Protection against attacks
   - GDPR compliance

## 📚 Glossary for Beginners

- **Attestation**: A certified digital document that proves something about you (your identity, diplomas, etc.)
- **Digital Wallet**: An application that securely stores your digital attestations
- **Issuer**: The organization that creates and certifies an attestation (e.g., the state for an ID card)
- **Verifier**: The person or organization that checks your attestations
- **Levels of Assurance**: The degree of confidence associated with an attestation (low, substantial, high)
- **Selective Disclosure**: The ability to share only part of the information contained in an attestation
- **Zero-Knowledge Proof**: A technology that allows you to prove something without revealing additional information

## 🔗 Useful Resources to Learn More

- [Citizen's Guide to European Digital Identity](https://digital-strategy.ec.europa.eu/en/policies/european-digital-identity)
- [Simple Explanations of eIDAS 2.0](https://www.youtube.com/watch?v=OO_MyjiAgr0)
- [How to Protect Your Digital Identity](https://cybersecurityguide.org/resources/digital-identity-protection/)

## Features Under Development

1. **Attestation Revocation Management**
   - Implementation of Status List 2021
   - Automatic status synchronization
   - Revocation management interface
   - Automatic renewal system

2. **Support for Qualified Attestations**
   - Integration with qualified certification authorities
   - Support for qualified electronic signatures
   - Verification of qualified seals
   - Compliance with eIDAS high level

3. **Interoperability with Public Services**
   - Integration with government services
   - Support for administrative use cases
   - Single Sign-On (SSO)
   - Cross-border services

## Technical Architecture

The application is built with Flutter and follows a clean architecture with:
- Domain-Driven Design (DDD)
- Clean Architecture
- Riverpod for state management
- flutter_secure_storage for secure local storage

## Architecture: Privacy-Enhancing PII Management

### Separation of Identity and Personal Data

This application implements a core architectural principle that enhances privacy and aligns with W3C and eIDAS 2.0 standards:

- **Core Identity Separation**: The `DigitalIdentity` model contains only minimal identifier information (DID/identity address and display name), with no embedded Personally Identifiable Information (PII).
- **PII as Verifiable Credentials**: All personal information (name, email, date of birth, address, etc.) is stored exclusively as separate Verifiable Credentials linked to the identity.

This architectural approach provides several benefits:

1. **Enhanced Privacy**: Minimizes the correlation risk by not binding all personal attributes to a single entity
2. **Selective Disclosure**: Enables sharing specific attributes without exposing the entire identity profile
3. **Standards Compliance**: Follows W3C DID Core and VC Data Model recommendations for privacy-preserving identity management
4. **User Control**: Allows the user to manage each credential independently (share, revoke, update)
5. **Regulatory Alignment**: Supports GDPR data minimization principles and eIDAS 2.0 requirements

When a user creates an identity, the system automatically generates separate Verifiable Credentials for each piece of personal information, all cryptographically linked to the core identity but stored and managed separately.

## Compliance

The application is designed to comply with:
- eIDAS 2.0 regulations
- EUDI Wallet standards
- European security directives
- General Data Protection Regulation (GDPR)

## FAQ for Beginners

### 🤔 Does this application replace my official documents?
Yes and no. Your digital attestations are legally recognized in the EU thanks to eIDAS 2.0, but it is recommended to keep your physical documents for certain situations.

### 🔒 Is my data secure?
Absolutely! Your data is stored only on your device, encrypted, and only you can unlock it. Even if you lose your phone, no one can access your information.

### 🌍 Can I use this application throughout Europe?
Yes, that is precisely the goal of EUDI Wallet and eIDAS 2.0: to create a digital identity system that works everywhere in Europe.

### 📱 What happens if I change my phone?
The application offers a backup and restore feature that allows you to securely transfer your attestations to your new device.

## Contribution

Contributions are welcome! If you want to improve this template:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🔐 Identity Management and Wallet Interaction

This application manages the user's digital identity by relying on the Archethic blockchain and the external **Archethic Wallet (aeWallet)**. Interaction occurs via the **Archethic Wallet Client (AWC)** protocol.

### Identity Flow

1.  **Connection:** The user connects their aeWallet to the dApp using one of their existing accounts/services (e.g., their main UCO account).
2.  **dApp Service Creation:** To link the user's identity specifically to this dApp, the application requests aeWallet to create a new dedicated **service** (e.g., `did_app_profile`) within the user's Keychain. This operation is initiated by the dApp but confirmed and executed by the user in their aeWallet. This service creates a new cryptographic key pair under the user's control, associated with their identity within the context of the dApp.
3.  **Usage:**
    *   The user's DID (Decentralized Identifier) is derived from their Keychain managed by aeWallet.
    *   Application-specific identity information (attributes, attestations) are managed as **Verifiable Credentials (VCs)**.
    *   Operations requiring a cryptographic signature linked to the dApp identity (e.g., issuing a self-signed VC, creating a VC presentation) should ideally use the key associated with the dApp service (`did_app_profile`).
4.  **Active Account Management (Important):** For operations requiring the specific key of the dApp service, the user **may need to manually select this service as the active account in their aeWallet** before confirming the operation. The dApp will attempt to detect the active account and guide the user if a change is necessary.

### Verifiable Credentials (VCs)

The application will use the W3C Verifiable Credentials standard to represent identity attributes and attestations (eIDAS 2.0 compliance).

*   VCs can be issued by trusted third parties or by the user themselves (Self-Issued).
*   VC storage will be managed securely (potentially encrypted local storage or via `DATA` transactions on the Archethic blockchain, signed via AWC).
*   The dApp service in the Keychain cryptographically anchors the user's identity (`did`) which is the `subject` of the VCs.

### Example W3C DID Document (from an Archethic Keychain)

The DID document is generated from the user's Keychain and represents their public keys associated with different services. Here is a simplified example:

```json
{
  "@context": [
    "https://www.w3.org/ns/did/v1",
    "https://w3id.org/security/suites/jws-2020/v1" // Context for JWK
  ],
  // The DID identifier is based on the keychain's genesis address
  "id": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142",
  "verificationMethod": [
    {
      // Identifier for the key associated with the 'uco' service
      "id": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#uco",
      // Controller is the DID itself
      "controller": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142",
      // Type indicating the key format
      "type": "JsonWebKey2020",
      // The public key in JWK format
      "publicKeyJwk": {
        "kty": "OKP", // Key Type: Octet Key Pair
        "crv": "Ed25519", // Curve: Ed25519
        "x": "THUxvsx2-3dAwofe-0YNINr9afALrSnPKdPJX6Ndh0U" // Public key value (base64url encoded)
      }
    },
    {
      // Identifier for the key associated with the dApp-specific service
      "id": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#did_app_profile",
      "controller": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142",
      "type": "JsonWebKey2020",
      "publicKeyJwk": {
        "kty": "OKP",
        "crv": "Ed25519",
        "x": "R3ehm94B6wgxWHU9jhv__-pQPYaXV3bgQzmG0515wGY" // Different public key for this service
      }
    }
    // ... other services/keys ...
  ],
  // Methods that can be used to authenticate as the DID subject
  "authentication": [
    "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#uco",
    "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#did_app_profile"
    // ... other authentication methods ...
  ],
  // Methods that can be used to assert claims about the DID subject (e.g., sign VCs)
  "assertionMethod": [
     "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#uco",
     "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#did_app_profile"
     // ... other assertion methods ...
  ]
  // Potentially other DID document properties like 'service', 'keyAgreement', etc.
}
```



