# Archethic dApp Template

A minimal template for developing decentralized applications (dApps) on the [Archethic](https://www.archethic.net/) blockchain.

## Features

- Complete and organized project structure
- Connection to Archethic wallet
- Display of connected account information
- Use of Riverpod 2 for state management
- Freezed for immutable classes
- Support for localization

## Prerequisites

- Flutter 3.27.4 or higher
- Dart SDK 3.3.0 or higher
- [Archethic Wallet](https://www.archethic.net/wallet) installed

## Installation

1. Clone this repository or use it as a template
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate code files
4. Launch the application with `flutter run -d chrome` (or your preferred platform)

## Project Structure

```
lib/
  ├── application/         # Business logic and providers
  │   ├── dapp_client.dart # Client for wallet connection
  │   └── session/         # Session management and wallet connection
  ├── domain/              # Data models, entities and repository interfaces
  ├── infrastructure/      # Repository implementations, external services
  ├── l10n/                # Translation files
  ├── ui/                  # User interface
  │   └── views/           # Application screens
  ├── util/                # Utilities and service locator
  └── main.dart            # Application entry point
```

## Development Status

### Implemented Features

1. **Identity Creation and Management**
   - Basic identity creation workflow
   - Profile data management (name, email, personal info)
   - Identity details view
   - Mock implementation of blockchain association

2. **Identity Verification (KYC/AML)**
   - Verification process UI framework
   - Multi-step verification flow
   - Mock verification repository
   - Verification completion and certificate generation
   - Status tracking for verification steps

3. **Document Management**
   - Basic document listing UI
   - Document details view
   - Document type categorization

4. **Navigation and User Experience**
   - Tab-based main navigation
   - Well-defined navigation flows between features
   - Confirmation dialogs for critical actions
   - Loading indicators and error states

### Partially Implemented Features

1. **Verification Workflow**
   - UI for verification steps is implemented
   - Backend integration needs to be implemented with real verification services

2. **Identity Dashboard**
   - Basic identity card UI is implemented
   - History and detailed tracking needs enhancement

3. **Document Storage**
   - UI for document management is implemented
   - Secure document storage implementation is pending

### Features To Be Implemented

1. **Authorization and Sharing**
   - Granular consent system for data sharing
   - Temporary/limited sharing of identity proofs
   - Access tracking and authorization revocation

2. **eIDAS 2.0 Interoperability**
   - EUDI Wallet compatibility
   - Support for standardized data formats and certificates
   - Cross-border interoperability features

3. **Secure Authentication**
   - Biometric authentication (fingerprint, facial recognition)
   - Multi-factor authentication
   - Passwordless authentication

4. **Verifiable Attestations and Certifications**
   - Reception and storage of verifiable attestations
   - Third-party validation system
   - Management of expired/revoked certifications

5. **Third-Party Service Integration**
   - API for integration with financial services
   - Simplified connection to public and private services
   - Integration framework for partners

6. **Privacy and Security Enhancements**
   - End-to-end encryption of data
   - Decentralized storage on Archethic blockchain
   - Selective information disclosure (zero-knowledge proofs)

7. **Regulatory Compliance**
   - Reporting tools for compliance
   - Audit trails for data access
   - Regular updates according to evolving regulations

## Development

This template contains only the bare minimum to connect to the Archethic wallet. To develop your dApp:

1. Add your screens in `lib/ui/views/`
2. Create your models in `lib/domain/`
3. Implement business logic in `lib/application/`
4. Add your services and repositories in `lib/infrastructure/`

## Wallet Connection

The connection to the Archethic wallet is managed by `SessionNotifier`. The application automatically attempts to connect to the wallet at startup. You can also add a connection button as demonstrated in `welcome_screen.dart`.

## Resources

- [Archethic Documentation](https://wiki.archethic.net/)
- [Archethic dApp Framework](https://github.com/archethic-foundation/archethic-dapp-framework-flutter)
- [Archethic Wallet Client](https://github.com/archethic-foundation/archethic-wallet-client-dart)



