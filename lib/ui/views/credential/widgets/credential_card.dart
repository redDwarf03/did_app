import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget réutilisable pour afficher une carte d'attestation dans l'application
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

  /// L'attestation à afficher
  final Credential credential;

  /// Callback quand la carte est touchée (généralement pour ouvrir les détails)
  final VoidCallback onTap;

  /// Callback pour présenter l'attestation
  final VoidCallback? onPresent;

  /// Callback pour vérifier l'attestation
  final VoidCallback? onVerify;

  /// Callback pour supprimer l'attestation
  final VoidCallback? onDelete;

  /// Indique s'il faut afficher une version compacte de la carte
  final bool compact;

  @override
  Widget build(BuildContext context) {
    // Formatter les dates
    final dateFormat = DateFormat('dd/MM/yyyy');
    final issuedAt = credential.issuedAt != null
        ? dateFormat.format(credential.issuedAt!)
        : dateFormat.format(credential.issuanceDate);
    final expiresAt = credential.expiresAt != null
        ? dateFormat.format(credential.expiresAt!)
        : 'Illimité';

    // Couleur basée sur le statut de vérification
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
              // Titre et type
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
                      credential.name ?? 'Attestation',
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
                              message: 'Supporte la preuve à divulgation nulle',
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

              // Description - afficher seulement si pas en mode compact
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

              // Afficher ces champs seulement si pas en mode compact
              if (!compact) ...[
                // Émetteur
                Row(
                  children: [
                    const Icon(Icons.business, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Émetteur: ${credential.issuer}',
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Dates d'émission et d'expiration
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Émise le: $issuedAt',
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
                            'Expire le: $expiresAt',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Afficher un aperçu des claims
                _buildClaimsPreview(context),
              ],

              const SizedBox(height: 8),

              // Boutons d'action
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Bouton de présentation
                  if (onPresent != null)
                    IconButton(
                      icon: const Icon(Icons.qr_code),
                      tooltip: 'Présenter',
                      onPressed: onPresent,
                    ),
                  // Bouton de vérification
                  if (onVerify != null)
                    IconButton(
                      icon: const Icon(Icons.verified_user),
                      tooltip: 'Vérifier authenticité',
                      onPressed: onVerify,
                    ),
                  // Menu pour édition et suppression
                  if (onDelete != null)
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete' && onDelete != null) {
                          onDelete!();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Supprimer'),
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

  // Construit un aperçu des claims (attributs) de l'attestation
  Widget _buildClaimsPreview(BuildContext context) {
    final claims = credential.claims;
    if (claims == null || claims.isEmpty) {
      return const SizedBox.shrink();
    }

    // Limiter le nombre de claims affichés dans l'aperçu
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
          const Text(
            'Attributs:',
            style: TextStyle(
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
              '+ ${claims.length - 3} autres',
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

  String _getVerificationStatusText(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.unverified:
        return 'Non vérifié';
      case VerificationStatus.verified:
        return 'Vérifié';
      case VerificationStatus.invalid:
        return 'Invalide';
      case VerificationStatus.expired:
        return 'Expiré';
      case VerificationStatus.revoked:
        return 'Révoqué';
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

  /// Obtient la couleur associée au type d'attestation
  Color _getTypeColor(CredentialType type) {
    switch (type) {
      case CredentialType.identity:
        return Colors.blue;
      case CredentialType.diploma:
        return Colors.amber;
      case CredentialType.drivingLicense:
        return Colors.green;
      case CredentialType.ageVerification:
        return Colors.purple;
      case CredentialType.addressProof:
        return Colors.brown;
      case CredentialType.employmentProof:
        return Colors.teal;
      case CredentialType.professionalBadge:
        return Colors.deepOrange;
      case CredentialType.membershipCard:
        return Colors.indigo;
      case CredentialType.healthInsurance:
        return Colors.red;
      case CredentialType.medicalCertificate:
        return Colors.pink;
      case CredentialType.other:
        return Colors.grey;
    }
  }
}
