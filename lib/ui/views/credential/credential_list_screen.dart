import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:did_app/ui/views/credential/widgets/credential_card.dart';

/// Écran affichant les attestations (Verifiable Credentials) de l'utilisateur
class CredentialListScreen extends ConsumerStatefulWidget {
  const CredentialListScreen({super.key});

  @override
  ConsumerState<CredentialListScreen> createState() =>
      _CredentialListScreenState();
}

class _CredentialListScreenState extends ConsumerState<CredentialListScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les attestations au démarrage
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity != null) {
      await ref.read(credentialNotifierProvider.notifier).loadCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    final credentialState = ref.watch(credentialNotifierProvider);
    final identityState = ref.watch(identityNotifierProvider);

    if (identityState.identity == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mes Attestations'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Identité requise',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Vous devez créer une identité numérique pour accéder à vos attestations',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
                softWrap: true,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pushNamed('createIdentity'),
                child: const Text('Créer une identité'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Attestations'),
        actions: [
          // Bouton pour rafraîchir la liste
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: credentialState.isLoading ? null : _loadCredentials,
            tooltip: 'Actualiser',
          ),
          // Bouton pour scanner un QR code
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed:
                credentialState.isLoading ? null : () => _scanQRCode(context),
            tooltip: 'Scanner un QR code',
          ),
        ],
      ),
      // Afficher un indicateur de chargement si nécessaire
      body: credentialState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCredentialList(context, credentialState),
      // Bouton pour demander une nouvelle attestation
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'request',
            onPressed: () => _showRequestCredentialDialog(context),
            label: const Text('Demander'),
            icon: const Icon(Icons.add_card),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            heroTag: 'present',
            onPressed: () => _showPresentCredentialDialog(context),
            label: const Text('Présenter'),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildCredentialList(BuildContext context, CredentialState state) {
    if (state.credentials.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.badge_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Aucune attestation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ajoutez des attestations vérifiables pour prouver votre identité',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showRequestCredentialDialog(context),
              icon: const Icon(Icons.add_card),
              label: const Text('Demander une attestation'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.credentials.length,
      itemBuilder: (context, index) {
        final credential = state.credentials[index];
        return ListTile(
          leading: Icon(_getCredentialTypeIcon(
              _getCredentialTypeFromList(credential.type))),
          title: Text(credential.name ?? 'Attestation'),
          subtitle: Text(credential.type.join(', ')),
          onTap: () => _openCredentialDetails(context, credential),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showCredentialOptions(context, credential),
          ),
        );
      },
    );
  }

  // Ouvrir les détails d'une attestation
  void _openCredentialDetails(BuildContext context, Credential credential) {
    // Navigate to credential details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CredentialDetailScreen(credentialId: credential.id),
      ),
    );
  }

  // Présenter une attestation
  Future<void> _presentCredential(
      BuildContext context, Credential credential) async {
    // Ici, on afficherait une interface permettant de créer une présentation sélective
    // puis de générer un QR code ou un lien pour partager cette présentation

    // Pour le prototype, on montre simplement un dialog avec un QR fictif
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Présenter l\'attestation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'QR Code de présentation générée',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.qr_code, size: 150, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Seules les informations sélectionnées seront partagées',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Vérifier une attestation
  Future<void> _verifyCredential(
      BuildContext context, Credential credential) async {
    // Montrer un indicateur de chargement
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Vérification en cours...'),
          ],
        ),
      ),
    );

    try {
      // Vérifier l'authenticité
      final isValid = await ref
          .read(credentialNotifierProvider.notifier)
          .verifyCredential(credential.id);

      // Fermer le dialogue de chargement
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Afficher le résultat
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Résultat de la vérification'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isValid ? Icons.check_circle : Icons.error,
                  color: isValid ? Colors.green : Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  isValid
                      ? 'Cette attestation est valide et n\'a pas été modifiée'
                      : 'Attention ! Cette attestation n\'est pas valide ou a été modifiée',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Fermer le dialogue de chargement
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Afficher l'erreur
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur est survenue: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ],
          ),
        );
      }
    }
  }

  // Scanner un QR code
  Future<void> _scanQRCode(BuildContext context) async {
    // Dans une implémentation réelle, on utiliserait un scanner de QR code
    // Pour le prototype, on simule simplement la réception d'une attestation

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scanner un QR code'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Cette fonctionnalité permettrait de scanner un QR code pour:',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text('- Recevoir une nouvelle attestation'),
            Text('- Vérifier une attestation'),
            Text('- Répondre à une demande de présentation'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _simulateCredentialReceived(context);
            },
            child: const Text('Simuler réception'),
          ),
        ],
      ),
    );
  }

  // Simuler la réception d'une attestation
  Future<void> _simulateCredentialReceived(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Réception en cours...'),
          ],
        ),
      ),
    );

    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Attestation reçue'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 48, color: Colors.green),
              SizedBox(height: 16),
              Text(
                'Félicitations ! Vous avez reçu une nouvelle attestation',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text('Type: Attestation d\'âge'),
              Text('Émetteur: Autorité nationale'),
              Text('Validité: Un an'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadCredentials(); // Recharger la liste
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Afficher le dialogue de demande d'attestation
  Future<void> _showRequestCredentialDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demander une attestation'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.assignment_ind, color: Colors.white),
                ),
                title: const Text('Attestation d\'identité'),
                subtitle:
                    const Text('Délivrée par les autorités gouvernementales'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestCredential(context, 'identity');
                },
              ),
              const Divider(),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.school, color: Colors.white),
                ),
                title: const Text('Diplôme ou certification'),
                subtitle:
                    const Text('Délivrée par établissements d\'enseignement'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestCredential(context, 'diploma');
                },
              ),
              const Divider(),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.directions_car, color: Colors.white),
                ),
                title: const Text('Permis de conduire'),
                subtitle: const Text('Délivrée par les autorités de transport'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestCredential(context, 'drivingLicense');
                },
              ),
              const Divider(),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.badge, color: Colors.white),
                ),
                title: const Text('Autre attestation'),
                subtitle: const Text('Tout autre type d\'attestation'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestCredential(context, 'other');
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  // Demander une attestation
  Future<void> _requestCredential(BuildContext context, String type) async {
    // Ici, on lancerait le processus de demande d'attestation
    // En contactant un émetteur, ou en redirigeant vers son site

    // Pour le prototype, on simule le processus
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Processus de demande'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dans une implémentation réelle, cette action:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('1. Générerait une demande signée'),
            Text('2. Vous redirigerait vers l\'émetteur'),
            Text('3. Vous guiderait dans le processus de vérification'),
            Text(
                '4. Recevrait et stockerait l\'attestation une fois approuvée'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Compris'),
          ),
        ],
      ),
    );
  }

  // Présenter une attestation (dialogue de sélection)
  Future<void> _showPresentCredentialDialog(BuildContext context) async {
    final credentials = ref.read(credentialNotifierProvider).credentials;

    if (credentials.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vous n\'avez pas encore d\'attestations à présenter'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir une attestation à présenter'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              final credential = credentials[index];
              return ListTile(
                leading: Icon(_getCredentialTypeIcon(
                    _getCredentialTypeFromList(credential.type))),
                title: Text(credential.name ?? 'Attestation'),
                subtitle: Text(credential.issuer),
                onTap: () {
                  Navigator.of(context).pop();
                  _presentCredential(context, credential);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  // Confirmer la suppression d'une attestation
  void _confirmDeleteCredential(BuildContext context, Credential credential) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text(
            'Êtes-vous sûr de vouloir supprimer l\'attestation "${credential.name}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteCredential(context, credential);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  // Supprimer une attestation
  Future<void> _deleteCredential(
      BuildContext context, Credential credential) async {
    // Montrer un indicateur de chargement
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Suppression en cours...'),
          ],
        ),
      ),
    );

    try {
      // Supprimer l'attestation
      final success = await ref
          .read(credentialNotifierProvider.notifier)
          .deleteCredential(credential.id);

      // Fermer le dialogue de chargement
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Afficher le résultat
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Attestation supprimée avec succès'
                  : 'Échec de la suppression',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Fermer le dialogue de chargement
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Afficher l'erreur
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Une erreur est survenue: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Utilitaires
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

  // Afficher les options pour une attestation
  void _showCredentialOptions(BuildContext context, Credential credential) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Présenter'),
              onTap: () {
                Navigator.of(context).pop();
                _presentCredential(context, credential);
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Vérifier l\'authenticité'),
              onTap: () {
                Navigator.of(context).pop();
                _verifyCredential(context, credential);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Supprimer'),
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
                _confirmDeleteCredential(context, credential);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Ce composant sera implémenté plus tard
class CredentialDetailScreen extends StatelessWidget {
  final String credentialId;

  const CredentialDetailScreen({super.key, required this.credentialId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'attestation'),
      ),
      body: Center(
        child: Text('Détails de l\'attestation $credentialId'),
      ),
    );
  }
}
