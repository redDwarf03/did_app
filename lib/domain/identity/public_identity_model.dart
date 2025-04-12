import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_identity_model.freezed.dart';

/// Represents a core digital identity, structured similarly to a W3C DID Document.
///
/// **Purpose:** This class models the public-facing or protocol-level representation
/// of an identity. It aligns closely with the W3C DID Core specification's concept of a
/// DID Document \[DID-CORE]. Its primary role is to associate a DID (`address`)
/// with verification methods (implicitly, through services that might use keys)
/// and especially service endpoints ([IdentityService]).
///
/// **Distinction:** Unlike `digital_identity.dart` (which holds detailed, private PII), this
/// class focuses on information typically found in a publicly resolvable DID Document:
/// the DID itself, potentially public aliases (`publicName`), and service endpoints
/// that define *how* to interact with the identity (e.g., for authentication, messaging,
/// credential exchange) as described in the DID spec's section on Services.
/// See: https://www.w3.org/TR/did-core/#services
///
/// It intentionally avoids storing sensitive PII to maintain privacy, a key principle
/// highlighted in the W3C DID privacy considerations.
/// See: https://www.w3.org/TR/did-core/#privacy-considerations
@freezed
class PublicIdentityModel with _$PublicIdentityModel {
  const factory PublicIdentityModel({
    /// The unique blockchain address or Decentralized Identifier (DID) for this identity.
    required String address,

    /// The primary, potentially private or internal, name associated with the identity.
    required String name,

    /// An optional publicly visible name or alias for the identity.
    String? publicName,

    /// A URL or reference to an image representing the identity profile.
    String? profileImage,

    /// The timestamp when this identity record was created.
    required DateTime createdAt,

    /// A list of service endpoints associated with this identity.
    /// See [IdentityService].
    @Default([]) List<IdentityService> services,
  }) = _PublicIdentityModel;

  // Private constructor for enabling custom methods/getters.
  const PublicIdentityModel._();

  /// Returns the name to be displayed publicly.
  /// Uses [publicName] if available, otherwise falls back to the primary [name].
  String get displayName => publicName ?? name;
}

/// Represents a service endpoint associated with a [PublicIdentityModel].
///
/// Service endpoints are used by applications to interact with the identity
/// for specific functions (e.g., authentication, credential issuance).
/// See: https://www.w3.org/TR/did-core/#service-endpoints
@freezed
class IdentityService with _$IdentityService {
  const factory IdentityService({
    /// A unique identifier for the service endpoint within the context of the identity.
    /// Often formatted as `did:example:123#service-1`.
    required String id,

    /// The type of the service endpoint (e.g., "VerifiableCredentialService", "DIDCommMessaging").
    /// Standardized types are recommended for interoperability.
    required String type,

    /// The URL or URI where the service can be accessed.
    required String endpoint,
  }) = _IdentityService;

  // Add fromJson factory for IdentityService if needed for serialization
  // factory IdentityService.fromJson(Map<String, dynamic> json) => _$IdentityServiceFromJson(json);
}
