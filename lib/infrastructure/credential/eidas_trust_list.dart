import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eidas_trust_list.freezed.dart';
part 'eidas_trust_list.g.dart';

/// Manages a simulated eIDAS 2.0 Trust List.
///
/// In a real-world scenario, this class would interact with the official
/// European Union Trust Lists (EU TLs) to fetch and validate information about
/// Qualified Trust Service Providers (QTSPs) and other trusted entities
/// according to the eIDAS regulation.
///
/// This implementation simulates the caching and querying of trusted issuers
/// for demonstration and development purposes.
class EidasTrustList {
  EidasTrustList._();

  /// Singleton instance of the EidasTrustList.
  static final EidasTrustList instance = EidasTrustList._();

  // Simulates a cache of trusted issuers, keyed by their DID.
  final Map<String, TrustedIssuer> _trustedIssuers = {};

  // Flag indicating if the mock data has been initialized.
  bool _initialized = false;

  // Timestamp of the last simulated synchronization.
  DateTime? _lastSyncDate;

  /// Initializes the trust list with mock data.
  /// Simulates loading data from an EU Trust List.
  Future<void> _initialize() async {
    if (_initialized) return;

    // Simulate network delay for loading the trust list.
    await Future.delayed(const Duration(milliseconds: 800));

    // Add some fictitious trusted issuers for demonstration.
    _addTrustedIssuer(
      TrustedIssuer(
        did: 'did:example:government-fr',
        name: 'French Government (Mock)',
        country: 'FR',
        serviceType: 'IdentityProvider',
        trustLevel: TrustLevel.high,
        validUntil: DateTime.now().add(const Duration(days: 365)),
      ),
    );

    _addTrustedIssuer(
      TrustedIssuer(
        did: 'did:example:ministry-interior',
        name: 'Ministry of the Interior (Mock)',
        country: 'FR',
        serviceType: 'IdentityProvider',
        trustLevel: TrustLevel.high,
        validUntil: DateTime.now().add(const Duration(days: 365)),
      ),
    );

    _addTrustedIssuer(
      TrustedIssuer(
        did: 'did:example:eidas-conformant-service',
        name: 'eIDAS Compliant Service (Mock)',
        country: 'EU',
        serviceType: 'AttributeProvider',
        trustLevel: TrustLevel.substantial,
        validUntil: DateTime.now().add(const Duration(days: 365)),
      ),
    );

    _initialized = true;
    _lastSyncDate = DateTime.now();
  }

  /// Adds a trusted issuer to the local cache.
  void _addTrustedIssuer(TrustedIssuer issuer) {
    _trustedIssuers[issuer.did] = issuer;
  }

  /// Updates or adds an issuer in the trust list cache.
  /// Simulates receiving an update from an EU Trust List registry.
  Future<void> updateTrustedIssuer(TrustedIssuer issuer) async {
    await _initialize();
    _trustedIssuers[issuer.did] = issuer;

    // Update the last sync date.
    _lastSyncDate = DateTime.now();
  }

  /// Performs a bulk update of the trust list cache.
  Future<void> updateTrustList(List<TrustedIssuer> issuers) async {
    await _initialize();

    for (final issuer in issuers) {
      _trustedIssuers[issuer.did] = issuer;
    }

    _lastSyncDate = DateTime.now();
  }

  /// Checks if an issuer identified by [issuerId] is present in the trust list.
  Future<bool> isIssuerTrusted(String issuerId) async {
    await _initialize();
    return _trustedIssuers.containsKey(issuerId);
  }

  /// Retrieves the details of a trusted issuer by its identifier [issuerId].
  /// Returns `null` if the issuer is not found.
  Future<TrustedIssuer?> getTrustedIssuer(String issuerId) async {
    await _initialize();
    return _trustedIssuers[issuerId];
  }

  /// Retrieves all trusted issuers currently in the cache.
  Future<List<TrustedIssuer>> getAllTrustedIssuers() async {
    await _initialize();
    return _trustedIssuers.values.toList();
  }

  /// Retrieves trusted issuers matching a specific [level] of assurance.
  Future<List<TrustedIssuer>> getTrustedIssuersByLevel(TrustLevel level) async {
    await _initialize();
    return _trustedIssuers.values
        .where((issuer) => issuer.trustLevel == level)
        .toList();
  }

  /// Retrieves trusted issuers operating within a specific country, identified by [countryCode].
  Future<List<TrustedIssuer>> getTrustedIssuersByCountry(
    String countryCode,
  ) async {
    await _initialize();
    return _trustedIssuers.values
        .where((issuer) => issuer.country == countryCode)
        .toList();
  }

  /// Retrieves trusted issuers providing a specific [serviceType].
  Future<List<TrustedIssuer>> getTrustedIssuersByServiceType(
    String serviceType,
  ) async {
    await _initialize();
    return _trustedIssuers.values
        .where((issuer) => issuer.serviceType == serviceType)
        .toList();
  }

  /// Removes a trusted issuer identified by [issuerId] from the cache.
  /// Returns `true` if the issuer was found and removed, `false` otherwise.
  Future<bool> removeTrustedIssuer(String issuerId) async {
    await _initialize();
    final wasRemoved = _trustedIssuers.remove(issuerId) != null;
    if (wasRemoved) {
      _lastSyncDate = DateTime.now();
    }
    return wasRemoved;
  }

  /// Gets the timestamp of the last simulated synchronization.
  Future<DateTime?> getLastSyncDate() async {
    await _initialize();
    return _lastSyncDate;
  }

  /// Simulates refreshing the trust list from the official EU TL servers.
  /// In a real implementation, this would involve fetching and processing
  /// the latest TSL (Trust Service Status List) data.
  Future<void> refreshTrustList() async {
    // Simulate network delay for fetching updates.
    await Future.delayed(const Duration(seconds: 2));

    // Add a new mock trusted service for demonstration.
    _addTrustedIssuer(
      TrustedIssuer(
        did: 'did:example:university-${DateTime.now().millisecondsSinceEpoch}',
        name: 'Demo University (Mock)',
        country: 'FR',
        serviceType: 'CredentialIssuer',
        trustLevel: TrustLevel.substantial,
        validUntil: DateTime.now().add(const Duration(days: 180)),
      ),
    );

    _lastSyncDate = DateTime.now();
  }

  /// Exports the details of a [TrustedIssuer] to a simulated eIDAS-like JSON format.
  /// Note: This is a simplified representation for demonstration.
  String exportTrustedIssuerToEidas(TrustedIssuer issuer) {
    // Note: In a real eIDAS context, the format would be based on TSL specifications.
    final eidasFormat = <String, dynamic>{
      'id': issuer.did, // Using DID as the primary identifier.
      'type': ['TrustedIssuer', 'EidasService'], // Example types.
      'name': issuer.name,
      'countryCode': issuer.country,
      'serviceType': issuer.serviceType,
      'trustLevel':
          _trustLevelToString(issuer.trustLevel), // eIDAS level of assurance.
      'validUntil': issuer.validUntil.toIso8601String(),
      'status': 'active', // Simplified status.
    };

    return jsonEncode(eidasFormat);
  }

  /// Generates a summary report of the current state of the trust list cache.
  Future<Map<String, dynamic>> generateTrustListReport() async {
    await _initialize();

    final issuers = _trustedIssuers.values.toList();
    final countries = <String>{};
    final serviceTypes = <String>{};
    final trustLevelCounts = <String, int>{};

    for (final issuer in issuers) {
      countries.add(issuer.country);
      serviceTypes.add(issuer.serviceType);

      final level = _trustLevelToString(issuer.trustLevel);
      trustLevelCounts[level] = (trustLevelCounts[level] ?? 0) + 1;
    }

    return {
      'totalIssuers': issuers.length,
      'countries': countries.toList(),
      'serviceTypes': serviceTypes.toList(),
      'trustLevelCounts': trustLevelCounts,
      'lastSyncDate': _lastSyncDate?.toIso8601String(),
    };
  }

  /// Converts a [TrustLevel] enum value to its string representation
  /// as commonly used in eIDAS contexts.
  String _trustLevelToString(TrustLevel level) {
    switch (level) {
      case TrustLevel.low:
        return 'low';
      case TrustLevel.substantial:
        return 'substantial';
      case TrustLevel.high:
        return 'high';
    }
  }
}

/// Data model representing a trusted issuer within the eIDAS context.
///
/// This typically represents a Trust Service Provider (TSP) whose details
/// are listed in an official EU Trust List.
@freezed
class TrustedIssuer with _$TrustedIssuer {
  const factory TrustedIssuer({
    /// Unique identifier for the issuer, often represented as a Decentralized Identifier (DID).
    required String did,

    /// Official name of the trusted issuer (e.g., company name).
    required String name,

    /// ISO 3166-1 alpha-2 country code where the issuer is based or operates.
    required String country,

    /// Type of trust service provided (e.g., IdentityProvider, AttributeProvider, TimestampAuthority).
    required String serviceType,

    /// Level of Assurance defined by eIDAS regulation for the service/issuer.
    required TrustLevel trustLevel,

    /// Date until which the issuer's status or service is considered valid in the trust list.
    required DateTime validUntil,
  }) = _TrustedIssuer;

  /// Factory constructor to create a [TrustedIssuer] instance from a JSON map.
  factory TrustedIssuer.fromJson(Map<String, dynamic> json) =>
      _$TrustedIssuerFromJson(json);
}

/// Represents the Levels of Assurance (LoA) defined by the eIDAS regulation.
///
/// These levels indicate the degree of confidence in the claimed identity
/// or the reliability of a trust service.
enum TrustLevel {
  /// Low level of assurance:
  /// Provides a limited degree of confidence in the claimed identity.
  /// Often used for services with lower risk.
  @JsonValue('low')
  low,

  /// Substantial level of assurance:
  /// Provides a substantial degree of confidence in the claimed identity.
  /// Suitable for services requiring higher security than 'low'.
  @JsonValue('substantial')
  substantial,

  /// High level of assurance:
  /// Provides the highest degree of confidence in the claimed identity.
  /// Often required for critical services (e.g., government, finance).
  @JsonValue('high')
  high,
}
