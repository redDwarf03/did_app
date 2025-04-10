import 'dart:async';
import 'dart:math';

import 'package:did_app/application/session/provider.dart';
import 'package:did_app/domain/identity/digital_identity.dart';
import 'package:did_app/domain/identity/identity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mock implementation of the Identity Repository for development and testing
class MockIdentityRepository implements IdentityRepository {
  MockIdentityRepository(this.ref);

  final Ref ref;

  // In-memory storage for this mock implementation
  final Map<String, DigitalIdentity> _identities = {};

  // Random generator for mock blockchain addresses
  final _random = Random();

  /// Generate a mock blockchain address for testing
  String _generateMockAddress() {
    const chars = 'abcdef0123456789';
    return List.generate(64, (index) => chars[_random.nextInt(chars.length)])
        .join();
  }

  /// Get the connected wallet address from the session
  String _getConnectedWalletAddress() {
    final session = ref.read(sessionNotifierProvider);
    // Use the genesis address from the session, or a placeholder for testing
    return session.genesisAddress;
  }

  @override
  Future<bool> hasIdentity() async {
    // Simulate blockchain lookup latency
    await Future.delayed(const Duration(milliseconds: 500));

    final walletAddress = _getConnectedWalletAddress();
    return _identities.containsKey(walletAddress);
  }

  @override
  Future<DigitalIdentity> createIdentity({
    required String displayName,
    required PersonalInfo personalInfo,
  }) async {
    // Simulate blockchain transaction latency
    await Future.delayed(const Duration(milliseconds: 1500));

    final walletAddress = _getConnectedWalletAddress();

    // Check if identity already exists
    if (_identities.containsKey(walletAddress)) {
      throw Exception('Identity already exists for this wallet');
    }

    // Create a new identity with a mock blockchain address
    final now = DateTime.now();
    final identity = DigitalIdentity(
      identityAddress: _generateMockAddress(),
      displayName: displayName,
      personalInfo: personalInfo,
      createdAt: now,
      updatedAt: now,
    );

    // Store the identity in our mock storage
    _identities[walletAddress] = identity;

    return identity;
  }

  @override
  Future<DigitalIdentity?> getIdentity() async {
    // Simulate blockchain lookup latency
    await Future.delayed(const Duration(milliseconds: 500));

    final walletAddress = _getConnectedWalletAddress();
    return _identities[walletAddress];
  }

  @override
  Future<DigitalIdentity> updateIdentity({
    required DigitalIdentity identity,
  }) async {
    // Simulate blockchain transaction latency
    await Future.delayed(const Duration(milliseconds: 1000));

    final walletAddress = _getConnectedWalletAddress();

    // Check if identity exists
    if (!_identities.containsKey(walletAddress)) {
      throw Exception('No identity exists for this wallet');
    }

    // Create a mock updated identity with new timestamp
    final updatedIdentity = DigitalIdentity(
      identityAddress: identity.identityAddress,
      displayName: identity.displayName,
      personalInfo: identity.personalInfo,
      createdAt: identity.createdAt,
      updatedAt: DateTime.now(),
      verificationStatus: identity.verificationStatus,
    );

    // Update our mock storage
    _identities[walletAddress] = updatedIdentity;

    return updatedIdentity;
  }
}
