/// Represents the identity details retrieved from the connected wallet.
class UserIdentityDetails {
  final String did; // The user's primary DID (from Keychain)
  final String?
      selectedAddress; // Currently selected address in the wallet, if available
  final List<String>
      availableServices; // List of service names found in the keychain

  UserIdentityDetails({
    required this.did,
    this.selectedAddress,
    required this.availableServices,
  });

  @override
  String toString() {
    return 'UserIdentityDetails(did: $did, selectedAddress: $selectedAddress, services: ${availableServices.length})';
  }
}
