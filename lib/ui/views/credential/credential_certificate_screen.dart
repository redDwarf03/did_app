import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Écran affichant l'attestation sous forme de certificat visuel
class CredentialCertificateScreen extends ConsumerWidget {
  const CredentialCertificateScreen({
    super.key,
    required this.credential,
  });

  final Credential credential;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.credentialDetailTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.shareFunctionalityMessage),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.shareFunctionalityMessage),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCertificate(context, l10n),
            const SizedBox(height: 24),
            SectionTitle(title: l10n.documentInfoSectionTitle),
            _buildCertificateInfo(context, l10n),
            const SizedBox(height: 24),
            SectionTitle(title: l10n.verificationSectionTitle),
            _buildValidityInfo(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificate(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');
    final size = MediaQuery.of(context).size;

    // On détermine le type d'attestation pour personnaliser le certificat
    final credentialType = _getCredentialTypeFromList(credential.type);
    final typeIcon = _getCredentialTypeIcon(credentialType);
    var typeTitle = l10n.defaultCredentialName;
    var accentColor = theme.colorScheme.primary;

    switch (credentialType) {
      case CredentialType.identity:
        typeTitle = l10n.credentialIdentityType;
        accentColor = Colors.blue;
        break;
      case CredentialType.diploma:
        typeTitle = l10n.credentialDiplomaType;
        accentColor = Colors.purple;
        break;
      case CredentialType.healthInsurance:
        typeTitle = l10n.credentialHealthInsuranceType;
        accentColor = Colors.green;
        break;
      case CredentialType.employmentProof:
        typeTitle = l10n.credentialEmploymentProofType;
        accentColor = Colors.orange;
        break;
      case CredentialType.drivingLicense:
        typeTitle = l10n.credentialDrivingLicenseType;
        accentColor = Colors.red;
        break;
      case CredentialType.ageVerification:
        typeTitle = l10n.credentialAgeVerificationType;
        accentColor = Colors.amber;
        break;
      case CredentialType.addressProof:
        typeTitle = l10n.credentialAddressProofType;
        accentColor = Colors.teal;
        break;
      case CredentialType.membershipCard:
        typeTitle = l10n.credentialMembershipCardType;
        accentColor = Colors.indigo;
        break;
      case CredentialType.medicalCertificate:
        typeTitle = l10n.credentialMedicalCertificateType;
        accentColor = Colors.pink;
        break;
      case CredentialType.professionalBadge:
        typeTitle = l10n.credentialProfessionalBadgeType;
        accentColor = Colors.deepOrange;
        break;
      case CredentialType.other:
        typeTitle = l10n.defaultCredentialName;
        accentColor = theme.colorScheme.primary;
        break;
    }

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: accentColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          // En-tête avec motif
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // Motif de fond
                Positioned.fill(
                  child: CustomPaint(
                    painter: CertificatePatternPainter(
                      color: accentColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                // Contenu de l'en-tête
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        typeIcon,
                        size: 30,
                        color: accentColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        typeTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Contenu du certificat
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                Center(
                  child: Text(
                    l10n.verifiableCredentialsTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                // Sous-titre
                Center(
                  child: Text(
                    _getCredentialName(l10n),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 24),

                // Contenu principal
                ..._buildCertificateContent(context, l10n),

                const SizedBox(height: 24),

                // Pied avec signature
                _buildSignature(context, l10n),
              ],
            ),
          ),

          // Pied avec infos de validation
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.onInverseSurface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      l10n.verifiedLabel,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                Text(
                  '${l10n.identifierLabel}: ${credential.id.substring(0, 8)}...',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  '${l10n.issuanceDateLabel}: ${dateFormat.format(credential.issuanceDate)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCredentialName(AppLocalizations l10n) {
    // Détermine un nom plus lisible pour l'attestation
    final subjectData = credential.credentialSubject;
    if (credential.type.contains('IdentityCredential')) {
      final firstName = subjectData['firstName'] as String? ?? '';
      final lastName = subjectData['lastName'] as String? ?? '';
      return '${l10n.credentialIdentityType} - $firstName $lastName';
    } else if (credential.type.contains('UniversityDegreeCredential')) {
      final degree = subjectData['degree'] as Map<String, dynamic>? ?? {};
      final degreeType = degree['type'] as String? ?? '';
      final field = degree['field'] as String? ?? '';
      return '${l10n.credentialDiplomaType} - $degreeType $field';
    } else if (credential.type.contains('HealthInsuranceCredential')) {
      final provider = subjectData['insuranceProvider'] as String? ?? '';
      return '${l10n.credentialHealthInsuranceType} - $provider';
    } else if (credential.type.contains('EmploymentCredential')) {
      final position = subjectData['position'] as String? ?? '';
      final employer = (subjectData['employer'] as Map<String, dynamic>)['name']
              as String? ??
          '';
      return '${l10n.credentialEmploymentProofType} - $position ($employer)';
    }
    return credential.type.join(', ');
  }

  List<Widget> _buildCertificateContent(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final subjectData = credential.credentialSubject;
    final widgets = <Widget>[];

    if (credential.type.contains('IdentityCredential')) {
      // Pour une attestation d'identité
      widgets.addAll([
        _buildContentRow(
          l10n.fullNameLabelDetails,
          '${subjectData['firstName']} ${subjectData['lastName']}',
        ),
        _buildContentRow(
          l10n.dobLabelDetails,
          subjectData['dateOfBirth'] ?? '',
        ),
        _buildContentRow(
          l10n.nationalityLabelDetails,
          subjectData['nationality'] ?? '',
        ),
        if (subjectData['documentNumber'] != null)
          _buildContentRow(
            l10n.documentIdLabelDetail,
            subjectData['documentNumber'],
          ),
      ]);
    } else if (credential.type.contains('UniversityDegreeCredential')) {
      // Pour un diplôme
      final degree = subjectData['degree'] as Map<String, dynamic>? ?? {};
      widgets.addAll([
        _buildContentRow(
          l10n.documentTypeLabel,
          '${degree['type']} en ${degree['field']}',
        ),
        _buildContentRow(
          l10n.issuerLabelDetail,
          credential.issuer.replaceAll('did:archethic:', ''),
        ),
        _buildContentRow(
          l10n.issueDateLabelDetail,
          subjectData['graduationDate'] ?? '',
        ),
        if (subjectData['gpa'] != null)
          _buildContentRow(l10n.documentDescriptionLabel, subjectData['gpa']),
      ]);
    } else if (credential.type.contains('HealthInsuranceCredential')) {
      // Pour une attestation d'assurance santé
      widgets.addAll([
        _buildContentRow(
          l10n.issuerLabelDetail,
          subjectData['insuranceProvider'] ?? '',
        ),
        _buildContentRow(
          l10n.documentIdLabelDetail,
          subjectData['policyNumber'] ?? '',
        ),
        _buildContentRow(
          l10n.issueDateLabelDetail,
          subjectData['coverageStart'] ?? '',
        ),
        _buildContentRow(
          l10n.expirationDateLabelDetail,
          subjectData['coverageEnd'] ?? '',
        ),
        _buildContentRow(
          l10n.documentTypeLabel,
          subjectData['coverageType'] ?? '',
        ),
      ]);
    } else if (credential.type.contains('EmploymentCredential')) {
      // Pour une attestation d'emploi
      final employer = subjectData['employer'] as Map<String, dynamic>? ?? {};
      widgets.addAll([
        _buildContentRow(l10n.documentTypeLabel, subjectData['position'] ?? ''),
        _buildContentRow(l10n.issuerLabelDetail, employer['name'] ?? ''),
        _buildContentRow(
          l10n.documentDescriptionLabel,
          subjectData['department'] ?? '',
        ),
        _buildContentRow(
          l10n.issueDateLabelDetail,
          subjectData['startDate'] ?? '',
        ),
        _buildContentRow(
          l10n.documentIdLabelDetail,
          subjectData['employeeId'] ?? '',
        ),
      ]);
    } else {
      // Pour tout autre type d'attestation, afficher tous les attributs
      subjectData.forEach((key, value) {
        if (key != 'id') {
          if (value is Map) {
            widgets.add(_buildContentRow(key, value.toString()));
          } else {
            widgets.add(_buildContentRow(key, value.toString()));
          }
        }
      });
    }

    return widgets;
  }

  Widget _buildContentRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignature(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // QR code (simulé)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.onInverseSurface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.qr_code, size: 40),
            ),

            // Signature
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  child: Text(
                    '${l10n.issuerLabel}: ${credential.issuer.replaceAll('did:archethic:', '')}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.signatureAuthenticityInfo,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCertificateInfo(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(
              context,
              Icons.fingerprint,
              l10n.identifierLabel,
              credential.id,
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.business,
              l10n.issuerLabelDetail,
              credential.issuer,
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.person,
              l10n.credentialTypeLabel,
              credential.subject ?? 'N/A',
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.category,
              l10n.documentTypeLabel,
              credential.type.join(', '),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidityInfo(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(
              context,
              Icons.calendar_today,
              l10n.issuanceDateLabel,
              dateFormat.format(credential.issuanceDate),
            ),
            if (credential.expirationDate != null) ...[
              const Divider(),
              _buildInfoRow(
                context,
                Icons.event_busy,
                l10n.expirationDateLabel,
                dateFormat.format(credential.expirationDate!),
              ),
            ],
            const Divider(),
            _buildInfoRow(
              context,
              credential.isValid ? Icons.check_circle : Icons.cancel,
              l10n.verificationStatus,
              credential.isValid ? l10n.verifiedStatus : l10n.expiredStatus,
              valueColor: credential.isValid ? Colors.green : Colors.red,
            ),
            if (credential.status != null) ...[
              const Divider(),
              _buildInfoRow(
                context,
                credential.isRevoked ? Icons.gpp_bad : Icons.gpp_good,
                l10n.status,
                credential.isRevoked ? l10n.revokedStatus : l10n.verifiedStatus,
                valueColor: credential.isRevoked ? Colors.red : Colors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: valueColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Retourne l'icône correspondant au type d'attestation
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
        return Icons.medical_services;
      case CredentialType.professionalBadge:
        return Icons.badge;
      case CredentialType.other:
      default:
        return Icons.badge;
    }
  }

  /// Convertit une liste de types en CredentialType
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

/// Peintre personnalisé pour dessiner un motif sur le certificat
class CertificatePatternPainter extends CustomPainter {
  CertificatePatternPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Dessiner un motif de lignes en diagonale
    for (var i = -size.height; i < size.width + size.height; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }

    // Dessiner une bordure
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
