/// Represents the result of successfully adding a dApp-specific service via AWC.
class ServiceCreationResult {
  final String serviceName;
  final String did; // The user's DID where the service was added
  // Add other relevant info if provided by AWC's addService response
  final dynamic rawResponse; // Optional: Store the raw success response

  ServiceCreationResult({
    required this.serviceName,
    required this.did,
    this.rawResponse,
  });

  @override
  String toString() {
    return 'ServiceCreationResult(serviceName: $serviceName, did: $did)';
  }
}
