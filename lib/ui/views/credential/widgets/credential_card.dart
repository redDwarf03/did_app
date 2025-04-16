import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

/// Reusable widget to display a credential card in the application
class CredentialCard extends StatelessWidget {
  const CredentialCard({
    super.key,
    required this.credential,
    required this.onTap,
    this.onPresent,
    this.onVerify,
    this.onDelete,
    this.compact = false,
  });

  /// The credential to display
  final Credential credential;

  /// Callback when the card is tapped (usually to open details)
  final VoidCallback onTap;

  /// Callback to present the credential
  final VoidCallback? onPresent;

  /// Callback to verify the credential
  final VoidCallback? onVerify;

  /// Callback to delete the credential
  final VoidCallback? onDelete;

  /// Indicates whether to display a compact version of the card
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    // Format dates
    final dateFormat = DateFormat('dd/MM/yyyy');
    final issuedAt = dateFormat.format(credential.issuedAt);
    final expiresAt = credential.expiresAt != null
        ? dateFormat.format(credential.expiresAt!)
        : localizations.unlimited;

    // Color based on verification status
    final statusColor = _getStatusColor(credential.verificationStatus);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and type
              Row(
                children: [
                  Icon(
                    _getCredentialTypeIcon(
                      _getCredentialTypeFromList(credential.type),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      credential.name ?? localizations.defaultCredentialName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (credential.supportsZkp)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Tooltip(
                              message: localizations.zkpSupportTooltip,
                              child: Icon(
                                Icons.lock,
                                size: 14,
                                color: statusColor,
                              ),
                            ),
                          ),
                        Text(
                          _getVerificationStatusText(
                            credential.verificationStatus,
                            localizations,
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Description - show only if not compact
              if (!compact && credential.description != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    credential.description!,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              // Show these fields only if not in compact mode
              if (!compact) ...[
                // Issuer
                Row(
                  children: [
                    const Icon(Icons.business, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${localizations.issuerLabel}: ${credential.issuer}',
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Issued and expiration dates
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${localizations.issuanceDateLabel}: $issuedAt',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    if (credential.expiresAt != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.event_busy,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${localizations.expirationDateLabel}: $expiresAt',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Display a preview of the claims
                _buildClaimsPreview(context),
              ],

              const SizedBox(height: 8),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Presentation button
                  if (onPresent != null)
                    IconButton(
                      icon: const Icon(Icons.qr_code),
                      tooltip: localizations.presentButton,
                      onPressed: onPresent,
                    ),
                  // Verification button
                  if (onVerify != null)
                    IconButton(
                      icon: const Icon(Icons.verified_user),
                      tooltip: localizations.verifyStatusButton,
                      onPressed: onVerify,
                    ),
                  // Menu for edit and delete
                  if (onDelete != null)
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete' && onDelete != null) {
                          onDelete!();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text(localizations.deleteButton),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a preview of the credential claims (attributes)
  Widget _buildClaimsPreview(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final claims = credential.claims;
    if (claims.isEmpty) {
      return const SizedBox.shrink();
    }

    // Limit the number of claims displayed in the preview
    final previewClaims = claims.entries.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.credentialAttributesLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          ...previewClaims.map(
            (entry) => Text(
              '• ${entry.key}: ${entry.value}',
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Afficher indication s'il y a d'autres attributs
          if (claims.length > 3)
            Text(
              '+ ${claims.length - 3} ${localizations.moreAttributes}',
              style: TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
        ],
      ),
    );
  }

  // Méthodes utilitaires
  IconData _getCredentialTypeIcon(CredentialType type) {
    switch (type) {
      case CredentialType.identity:
        return Icons.person;
      case CredentialType.diploma:
        return Icons.school;
      case CredentialType.drivingLicense:
        return Icons.directions_car;
      case CredentialType.ageVerification:
        return Icons.cake;
      case CredentialType.addressProof:
        return Icons.home;
      case CredentialType.employmentProof:
        return Icons.work;
      case CredentialType.membershipCard:
        return Icons.card_membership;
      case CredentialType.healthInsurance:
        return Icons.medical_services;
      case CredentialType.medicalCertificate:
        return Icons.local_hospital;
      case CredentialType.professionalBadge:
        return Icons.work_outline;
      case CredentialType.other:
        return Icons.badge;
    }
  }

  Color _getStatusColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.unverified:
        return Colors.grey;
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.invalid:
        return Colors.red;
      case VerificationStatus.expired:
        return Colors.orange;
      case VerificationStatus.revoked:
        return Colors.deepOrange;
    }
  }

  String _getVerificationStatusText(
      VerificationStatus status, AppLocalizations localizations) {
    switch (status) {
      case VerificationStatus.unverified:
        return localizations.notVerifiedStatus;
      case VerificationStatus.verified:
        return localizations.verifiedStatus;
      case VerificationStatus.invalid:
        return localizations.invalidStatus;
      case VerificationStatus.expired:
        return localizations.expiredStatus;
      case VerificationStatus.revoked:
        return localizations.revokedStatus;
    }
  }

  // Convertit une liste de types en CredentialType
  CredentialType _getCredentialTypeFromList(List<String> types) {
    if (types.contains('IdentityCredential')) {
      return CredentialType.identity;
    } else if (types.contains('UniversityDegreeCredential')) {
      return CredentialType.diploma;
    } else if (types.contains('HealthInsuranceCredential')) {
      return CredentialType.healthInsurance;
    } else if (types.contains('EmploymentCredential')) {
      return CredentialType.employmentProof;
    } else if (types.contains('DrivingLicenseCredential')) {
      return CredentialType.drivingLicense;
    } else if (types.contains('AgeVerificationCredential')) {
      return CredentialType.ageVerification;
    } else if (types.contains('AddressProofCredential')) {
      return CredentialType.addressProof;
    } else if (types.contains('MembershipCardCredential')) {
      return CredentialType.membershipCard;
    } else if (types.contains('MedicalCertificateCredential')) {
      return CredentialType.medicalCertificate;
    } else if (types.contains('ProfessionalBadgeCredential')) {
      return CredentialType.professionalBadge;
    } else {
      return CredentialType.other;
    }
  }
}
