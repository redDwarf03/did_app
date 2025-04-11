import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/ui/common/section_title.dart';
import 'package:did_app/ui/common/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité de partage à venir'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité d\'impression à venir'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCertificate(context),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Informations du certificat'),
            _buildCertificateInfo(context),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Validité'),
            _buildValidityInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificate(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');
    final size = MediaQuery.of(context).size;

    // On détermine le type d'attestation pour personnaliser le certificat
    final credentialType = _getCredentialTypeFromList(credential.type);
    IconData typeIcon = _getCredentialTypeIcon(credentialType);
    String typeTitle = 'Attestation';
    Color accentColor = theme.colorScheme.primary;

    switch (credentialType) {
      case CredentialType.identity:
        typeTitle = "Attestation d'identité";
        accentColor = Colors.blue;
        break;
      case CredentialType.diploma:
        typeTitle = "Diplôme";
        accentColor = Colors.purple;
        break;
      case CredentialType.healthInsurance:
        typeTitle = "Attestation de santé";
        accentColor = Colors.green;
        break;
      case CredentialType.employmentProof:
        typeTitle = "Attestation d'emploi";
        accentColor = Colors.orange;
        break;
      case CredentialType.drivingLicense:
        typeTitle = "Permis de conduire";
        accentColor = Colors.red;
        break;
      case CredentialType.ageVerification:
        typeTitle = "Vérification d'âge";
        accentColor = Colors.amber;
        break;
      case CredentialType.addressProof:
        typeTitle = "Justificatif de domicile";
        accentColor = Colors.teal;
        break;
      case CredentialType.membershipCard:
        typeTitle = "Carte de membre";
        accentColor = Colors.indigo;
        break;
      case CredentialType.other:
        typeTitle = "Attestation";
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // En-tête avec motif
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
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
                      color: accentColor.withOpacity(0.1),
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                Center(
                  child: Text(
                    'CERTIFICAT OFFICIEL',
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
                    _getCredentialName(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 24),

                // Contenu principal
                ..._buildCertificateContent(context),

                const SizedBox(height: 24),

                // Pied avec signature
                _buildSignature(context),
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
                      'Vérifié',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                Text(
                  'ID: ${credential.id.substring(0, 8)}...',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Émis le: ${dateFormat.format(credential.issuanceDate)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCredentialName() {
    // Détermine un nom plus lisible pour l'attestation
    final subjectData = credential.credentialSubject;
    if (credential.type.contains('IdentityCredential')) {
      final firstName = subjectData['firstName'] as String? ?? '';
      final lastName = subjectData['lastName'] as String? ?? '';
      return 'Identité de $firstName $lastName';
    } else if (credential.type.contains('UniversityDegreeCredential')) {
      final degreeType =
          (subjectData['degree'] as Map<String, dynamic>)['type'] as String? ??
              '';
      final field =
          (subjectData['degree'] as Map<String, dynamic>)['field'] as String? ??
              '';
      return '$degreeType en $field';
    } else if (credential.type.contains('HealthInsuranceCredential')) {
      final provider = subjectData['insuranceProvider'] as String? ?? '';
      return 'Assurance santé - $provider';
    } else if (credential.type.contains('EmploymentCredential')) {
      final position = subjectData['position'] as String? ?? '';
      final employer = (subjectData['employer'] as Map<String, dynamic>)['name']
              as String? ??
          '';
      return '$position chez $employer';
    }
    return credential.type.join(', ');
  }

  List<Widget> _buildCertificateContent(BuildContext context) {
    final theme = Theme.of(context);
    final subjectData = credential.credentialSubject;
    final widgets = <Widget>[];

    if (credential.type.contains('IdentityCredential')) {
      // Pour une attestation d'identité
      widgets.addAll([
        _buildContentRow('Nom complet',
            '${subjectData['firstName']} ${subjectData['lastName']}'),
        _buildContentRow('Date de naissance', subjectData['dateOfBirth'] ?? ''),
        _buildContentRow('Nationalité', subjectData['nationality'] ?? ''),
        if (subjectData['documentNumber'] != null)
          _buildContentRow('N° de document', subjectData['documentNumber']),
      ]);
    } else if (credential.type.contains('UniversityDegreeCredential')) {
      // Pour un diplôme
      final degree = subjectData['degree'] as Map<String, dynamic>? ?? {};
      widgets.addAll([
        _buildContentRow('Diplôme', '${degree['type']} en ${degree['field']}'),
        _buildContentRow('Établissement',
            credential.issuer.replaceAll('did:archethic:', '')),
        _buildContentRow(
            'Date d\'obtention', subjectData['graduationDate'] ?? ''),
        if (subjectData['gpa'] != null)
          _buildContentRow('GPA', subjectData['gpa']),
      ]);
    } else if (credential.type.contains('HealthInsuranceCredential')) {
      // Pour une attestation d'assurance santé
      widgets.addAll([
        _buildContentRow('Assureur', subjectData['insuranceProvider'] ?? ''),
        _buildContentRow('N° de police', subjectData['policyNumber'] ?? ''),
        _buildContentRow(
            'Début de couverture', subjectData['coverageStart'] ?? ''),
        _buildContentRow('Fin de couverture', subjectData['coverageEnd'] ?? ''),
        _buildContentRow(
            'Type de couverture', subjectData['coverageType'] ?? ''),
      ]);
    } else if (credential.type.contains('EmploymentCredential')) {
      // Pour une attestation d'emploi
      final employer = subjectData['employer'] as Map<String, dynamic>? ?? {};
      widgets.addAll([
        _buildContentRow('Fonction', subjectData['position'] ?? ''),
        _buildContentRow('Employeur', employer['name'] ?? ''),
        _buildContentRow('Département', subjectData['department'] ?? ''),
        _buildContentRow('Date d\'embauche', subjectData['startDate'] ?? ''),
        _buildContentRow('ID employé', subjectData['employeeId'] ?? ''),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  Widget _buildSignature(BuildContext context) {
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
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    'Émetteur: ${credential.issuer.replaceAll('did:archethic:', '')}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Signature numérique vérifiée',
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

  Widget _buildCertificateInfo(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow(
              context,
              Icons.fingerprint,
              'Identifiant',
              credential.id,
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.business,
              'Émetteur',
              credential.issuer,
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.person,
              'Sujet',
              credential.subject,
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.category,
              'Type',
              credential.type.join(', '),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidityInfo(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow(
              context,
              Icons.calendar_today,
              'Date d\'émission',
              dateFormat.format(credential.issuanceDate),
            ),
            if (credential.expirationDate != null) ...[
              const Divider(),
              _buildInfoRow(
                context,
                Icons.event_busy,
                'Date d\'expiration',
                dateFormat.format(credential.expirationDate!),
              ),
            ],
            const Divider(),
            _buildInfoRow(
              context,
              credential.isValid ? Icons.check_circle : Icons.cancel,
              'Statut de validité',
              credential.isValid ? 'Valide' : 'Expiré',
              valueColor: credential.isValid ? Colors.green : Colors.red,
            ),
            if (credential.status != null) ...[
              const Divider(),
              _buildInfoRow(
                context,
                credential.isRevoked ? Icons.gpp_bad : Icons.gpp_good,
                'Statut de révocation',
                credential.isRevoked ? 'Révoqué' : 'Non révoqué',
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
      case CredentialType.other:
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
    } else {
      return CredentialType.other;
    }
  }
}

/// Peintre personnalisé pour dessiner un motif sur le certificat
class CertificatePatternPainter extends CustomPainter {
  final Color color;

  CertificatePatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Dessiner un motif de lignes en diagonale
    for (double i = -size.height; i < size.width + size.height; i += 20) {
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
