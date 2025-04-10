import 'package:did_app/domain/identity/digital_identity.dart';

/// Repository interface for interacting with Digital Identity on the blockchain
abstract class IdentityRepository {
  /// Check if the connected wallet has an identity
  Future<bool> hasIdentity();

  /// Create a new identity for the connected wallet
  ///
  /// Mock implementation will generate a random blockchain address
  Future<DigitalIdentity> createIdentity({
    required String displayName,
    required PersonalInfo personalInfo,
  });

  /// Get the identity linked to the connected wallet
  Future<DigitalIdentity?> getIdentity();

  /// Update an existing identity
  Future<DigitalIdentity> updateIdentity({
    required DigitalIdentity identity,
  });
}
