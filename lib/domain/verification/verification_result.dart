import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_result.freezed.dart';
// part 'verification_result.g.dart'; // Uncomment if serialization needed

/// Represents the outcome of a verification process, typically for a
/// Verifiable Credential or Verifiable Presentation.
@freezed
class VerificationResult with _$VerificationResult {
  /// Creates an instance of [VerificationResult].
  const factory VerificationResult({
    /// Whether the verification was successful.
    required bool isValid,

    /// An optional message providing details about the verification outcome (e.g., error reason).
    String? message,
    // TODO: Consider adding more structured error information (e.g., error codes, specific checks failed)
  }) = _VerificationResult;

  /// Private constructor for Freezed.
  const VerificationResult._();

  // If serialization is needed:
  // factory VerificationResult.fromJson(Map<String, dynamic> json) =>
  //     _$VerificationResultFromJson(json);
}
