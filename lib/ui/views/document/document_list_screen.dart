import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Écran affichant la liste des documents de l'utilisateur
class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les documents au démarrage
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity != null) {
      await ref
          .read(documentNotifierProvider.notifier)
          .loadDocuments(identity.identityAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentState = ref.watch(documentNotifierProvider);
    final identityState = ref.watch(identityNotifierProvider);

    if (identityState.identity == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mes Documents'),
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
                'Vous devez créer une identité numérique pour accéder à vos documents',
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
        title: const Text('Mes Documents'),
        actions: [
          // Bouton pour rafraîchir la liste
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: documentState.isLoading ? null : _loadDocuments,
            tooltip: 'Actualiser',
          ),
          // Bouton pour afficher les documents partagés avec moi
          IconButton(
            icon: const Icon(Icons.download_for_offline),
            onPressed: documentState.isLoading
                ? null
                : () => _showSharedWithMe(context),
            tooltip: 'Documents partagés avec moi',
          ),
        ],
      ),
      // Afficher un indicateur de chargement si nécessaire
      body: documentState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDocumentList(context, documentState),
      // Bouton d'ajout de document
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDocumentDialog(context),
        tooltip: 'Ajouter un document',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDocumentList(BuildContext context, DocumentState state) {
    if (state.documents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.description_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Aucun document',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ajoutez des documents pour les stocker et les partager de façon sécurisée',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddDocumentDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un document'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.documents.length,
      itemBuilder: (context, index) {
        final document = state.documents[index];
        return _buildDocumentCard(context, document);
      },
    );
  }

  Widget _buildDocumentCard(BuildContext context, Document document) {
    // Formater les dates
    final dateFormat = DateFormat('dd/MM/yyyy');
    final issuedAt = dateFormat.format(document.issuedAt);
    final expiresAt = document.expiresAt != null
        ? dateFormat.format(document.expiresAt!)
        : 'Non applicable';

    // Couleur selon le statut de vérification
    final statusColor = _getStatusColor(document.verificationStatus);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () => _openDocumentDetails(context, document),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre et type de document
              Row(
                children: [
                  Icon(
                    _getDocumentTypeIcon(document.type),
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      document.title,
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
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getVerificationStatusText(document.verificationStatus),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Description
              if (document.description != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    document.description!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

              // Émetteur
              Row(
                children: [
                  const Icon(Icons.business, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Émetteur: ${document.issuer}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Dates d'émission et d'expiration
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Émis le: $issuedAt',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 16),
                  if (document.expiresAt != null)
                    Row(
                      children: [
                        const Icon(Icons.event_busy,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Expire le: $expiresAt',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 4),

              // Tags
              if (document.tags != null && document.tags!.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: document.tags!
                      .map((tag) => Chip(
                            label: Text(tag),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            labelStyle: const TextStyle(fontSize: 12),
                            padding: EdgeInsets.zero,
                          ))
                      .toList(),
                ),

              const SizedBox(height: 8),

              // Boutons d'action
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Bouton de téléchargement
                  IconButton(
                    icon: const Icon(Icons.download),
                    tooltip: 'Télécharger',
                    onPressed: () => _downloadDocument(context, document),
                  ),
                  // Bouton de partage (si le document est partageable)
                  if (document.isShareable)
                    IconButton(
                      icon: const Icon(Icons.share),
                      tooltip: 'Partager',
                      onPressed: () => _showShareDialog(context, document),
                    ),
                  // Bouton de vérification
                  IconButton(
                    icon: const Icon(Icons.verified_user),
                    tooltip: 'Vérifier l\'authenticité',
                    onPressed: () => _verifyDocument(context, document),
                  ),
                  // Bouton de menu contextuel
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        _handleMenuAction(context, value, document),
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Modifier'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'versions',
                        child: Text('Voir les versions'),
                      ),
                      if (document.verificationStatus !=
                          DocumentVerificationStatus.verified)
                        const PopupMenuItem<String>(
                          value: 'sign',
                          child: Text('Signer'),
                        ),
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

  // Afficher le dialogue d'ajout de document
  Future<void> _showAddDocumentDialog(BuildContext context) async {
    // Dans une implémentation complète, cela ouvrirait un formulaire de sélection de fichier
    // et de saisie des métadonnées du document
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un document'),
        content:
            const Text('Cette fonctionnalité sera implémentée prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Ouvrir les détails d'un document
  void _openDocumentDetails(BuildContext context, Document document) {
    // Pour une implémentation complète, cela naviguerait vers l'écran de détails du document
    // context.push('/documents/${document.id}');

    // Pour le moment, afficher un dialogue simple
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(document.title),
        content: const Text(
            'L\'écran de détails du document sera implémenté prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Télécharger un document
  Future<void> _downloadDocument(
      BuildContext context, Document document) async {
    // Pour une implémentation complète, cela téléchargerait le document
    // final content = await ref.read(documentNotifierProvider.notifier).getDocumentContent(document.id);

    // Pour le moment, afficher un dialogue simple
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Télécharger le document'),
        content: const Text(
            'Le téléchargement du document sera implémenté prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Afficher le dialogue de partage de document
  Future<void> _showShareDialog(BuildContext context, Document document) async {
    // Pour une implémentation complète, cela ouvrirait un formulaire de partage
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Partager le document'),
        content:
            const Text('Le partage de document sera implémenté prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Vérifier l'authenticité d'un document
  Future<void> _verifyDocument(BuildContext context, Document document) async {
    // Afficher un indicateur de chargement
    showDialog(
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
      final status = await ref
          .read(documentNotifierProvider.notifier)
          .verifyDocumentAuthenticity(document.id);

      // Fermer le dialogue de chargement
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Afficher le résultat
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Résultat de la vérification'),
            content: Text(
              status != null
                  ? 'Statut: ${_getVerificationStatusText(status)}'
                  : 'La vérification a échoué. Veuillez réessayer.',
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
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur est survenue: ${e.toString()}'),
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

  // Afficher les documents partagés avec l'utilisateur
  Future<void> _showSharedWithMe(BuildContext context) async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) return;

    try {
      // Charger les documents partagés
      await ref
          .read(documentNotifierProvider.notifier)
          .loadSharedWithMe(identity.identityAddress);

      // Naviguer vers l'écran des documents partagés
      // context.push('/documents/shared-with-me');

      // Pour le moment, afficher un dialogue simple
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Documents partagés avec moi'),
            content: const Text(
                'L\'écran des documents partagés sera implémenté prochainement.'),
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
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur est survenue: ${e.toString()}'),
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

  // Gérer les actions du menu contextuel
  Future<void> _handleMenuAction(
    BuildContext context,
    String action,
    Document document,
  ) async {
    switch (action) {
      case 'edit':
        _editDocument(context, document);
        break;
      case 'versions':
        _showVersions(context, document);
        break;
      case 'sign':
        _signDocument(context, document);
        break;
      case 'delete':
        _confirmDeleteDocument(context, document);
        break;
    }
  }

  // Modifier un document
  void _editDocument(BuildContext context, Document document) {
    // Pour une implémentation complète, cela ouvrirait un formulaire d'édition
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le document'),
        content: const Text(
            'La modification de document sera implémentée prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Afficher l'historique des versions
  void _showVersions(BuildContext context, Document document) {
    // Pour une implémentation complète, cela afficherait l'historique des versions
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historique des versions'),
        content: const Text(
            'L\'historique des versions sera implémenté prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  // Signer un document
  Future<void> _signDocument(BuildContext context, Document document) async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) return;

    // Afficher un indicateur de chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Signature en cours...'),
          ],
        ),
      ),
    );

    try {
      // Signer le document
      final signedDocument =
          await ref.read(documentNotifierProvider.notifier).signDocument(
                documentId: document.id,
                signerIdentityAddress: identity.identityAddress,
              );

      // Fermer le dialogue de chargement
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Afficher le résultat
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Document signé'),
            content: Text(
              signedDocument != null
                  ? 'Le document a été signé avec succès.'
                  : 'La signature a échoué. Veuillez réessayer.',
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
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur est survenue: ${e.toString()}'),
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

  // Confirmer la suppression d'un document
  void _confirmDeleteDocument(BuildContext context, Document document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content:
            Text('Êtes-vous sûr de vouloir supprimer "${document.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteDocument(context, document);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  // Supprimer un document
  Future<void> _deleteDocument(BuildContext context, Document document) async {
    // Afficher un indicateur de chargement
    showDialog(
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
      // Supprimer le document
      final success = await ref
          .read(documentNotifierProvider.notifier)
          .deleteDocument(document.id);

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
                  ? 'Document supprimé avec succès'
                  : 'Échec de la suppression du document',
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
            content: Text('Une erreur est survenue: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Utilitaires
  IconData _getDocumentTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.nationalId:
        return Icons.credit_card;
      case DocumentType.passport:
        return Icons.menu_book;
      case DocumentType.drivingLicense:
        return Icons.directions_car;
      case DocumentType.diploma:
        return Icons.school;
      case DocumentType.certificate:
        return Icons.workspace_premium;
      case DocumentType.addressProof:
        return Icons.home;
      case DocumentType.bankDocument:
        return Icons.account_balance;
      case DocumentType.medicalRecord:
        return Icons.medical_services;
      case DocumentType.corporateDocument:
        return Icons.business;
      case DocumentType.other:
        return Icons.description;
    }
  }

  Color _getStatusColor(DocumentVerificationStatus status) {
    switch (status) {
      case DocumentVerificationStatus.unverified:
        return Colors.grey;
      case DocumentVerificationStatus.pending:
        return Colors.blue;
      case DocumentVerificationStatus.verified:
        return Colors.green;
      case DocumentVerificationStatus.rejected:
        return Colors.red;
      case DocumentVerificationStatus.expired:
        return Colors.orange;
    }
  }

  String _getVerificationStatusText(DocumentVerificationStatus status) {
    switch (status) {
      case DocumentVerificationStatus.unverified:
        return 'Non vérifié';
      case DocumentVerificationStatus.pending:
        return 'En attente';
      case DocumentVerificationStatus.verified:
        return 'Vérifié';
      case DocumentVerificationStatus.rejected:
        return 'Rejeté';
      case DocumentVerificationStatus.expired:
        return 'Expiré';
    }
  }
}
