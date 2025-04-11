import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:did_app/ui/views/document/document_detail_screen.dart';
import 'package:did_app/ui/views/document/document_form_screen.dart';
import 'package:did_app/ui/views/document/shared_documents_screen.dart';
import 'package:did_app/ui/views/document/widgets/document_card.dart';
import 'package:did_app/ui/views/document/widgets/document_share_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen displaying the user's document list
class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  @override
  void initState() {
    super.initState();
    // Load documents on startup
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
    final l10n = AppLocalizations.of(context)!;

    if (identityState.identity == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.documentListTitle),
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
              Text(
                l10n.identityRequiredTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.identityRequiredContent,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
                softWrap: true,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pushNamed('createIdentity'),
                child: Text(l10n.createIdentityButtonList),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.documentListTitle),
        actions: [
          // Button to refresh the list
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: documentState.isLoading ? null : _loadDocuments,
            tooltip: l10n.refreshListAction,
          ),
          // Button to display documents shared with me
          IconButton(
            icon: const Icon(Icons.download_for_offline),
            onPressed: documentState.isLoading
                ? null
                : () => _showSharedWithMe(context),
            tooltip: l10n.sharedWithMeAction,
          ),
        ],
      ),
      // Display loading indicator if needed
      body: documentState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDocumentList(context, documentState),
      // Document add button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDocumentDialog(context),
        tooltip: l10n.addDocumentTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDocumentList(BuildContext context, DocumentState state) {
    final l10n = AppLocalizations.of(context)!;
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
            Text(
              l10n.noDocumentsTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noDocumentsContent,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddDocumentDialog(context),
              icon: const Icon(Icons.add),
              label: Text(l10n.addDocumentButtonList),
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
    return DocumentCard(
      document: document,
      onTap: () => _openDocumentDetails(context, document),
      onDownload: () => _downloadDocument(context, document),
      onShare: document.isShareable
          ? () => _showShareDialog(context, document)
          : null,
      onVerify: () => _verifyDocument(context, document),
      onEdit: () => _editDocument(context, document),
      onDelete: () => _confirmDeleteDocument(context, document),
    );
  }

  // Show document add dialog
  Future<void> _showAddDocumentDialog(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DocumentFormScreen(),
      ),
    );
  }

  // Open document details
  void _openDocumentDetails(BuildContext context, Document document) {
    // Navigate to the document details screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DocumentDetailScreen(documentId: document.id),
      ),
    );
  }

  // Download document
  Future<void> _downloadDocument(
    BuildContext context,
    Document document,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    // For a complete implementation, this would download the document
    // final content = await ref.read(documentNotifierProvider.notifier).getDocumentContent(document.id);

    // For now, show a simple dialog
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.downloadDialogTitle),
        content: Text(l10n.downloadFeatureNotAvailable),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  // Show document share dialog
  Future<void> _showShareDialog(BuildContext context, Document document) async {
    final l10n = AppLocalizations.of(context)!;
    if (!document.isShareable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.documentNotShareable),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => DocumentShareDialog(document: document),
    );
  }

  // Verify document authenticity
  Future<void> _verifyDocument(BuildContext context, Document document) async {
    final l10n = AppLocalizations.of(context)!;
    // Show loading indicator
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(l10n.verificationInProgressDialog),
          ],
        ),
      ),
    );

    try {
      // Verify authenticity
      final status = await ref
          .read(documentNotifierProvider.notifier)
          .verifyDocumentAuthenticity(document.id);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show result
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.verificationResultDialogTitle),
            content: Text(
              status != null
                  ? l10n.verificationStatusResult(
                      _getVerificationStatusText(status),)
                  : l10n.verificationFailedError,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.closeButton),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.errorDialogTitle),
            content: Text(l10n.genericErrorMessage(e.toString())),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.closeButton),
              ),
            ],
          ),
        );
      }
    }
  }

  // Show documents shared with user
  Future<void> _showSharedWithMe(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SharedDocumentsScreen(),
      ),
    );
  }

  // Handle context menu actions
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
        await _signDocument(context, document);
        break;
      case 'delete':
        _confirmDeleteDocument(context, document);
        break;
    }
  }

  // Edit document
  void _editDocument(BuildContext context, Document document) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DocumentFormScreen(documentId: document.id),
      ),
    );
  }

  // Show document versions history
  void _showVersions(BuildContext context, Document document) {
    final l10n = AppLocalizations.of(context)!;
    // For a complete implementation, this would display document versions history
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.documentVersionsHistoryDialogTitle),
        content: Text(l10n.documentVersionsHistoryFeatureNotAvailable),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.closeButton),
          ),
        ],
      ),
    );
  }

  // Sign document
  Future<void> _signDocument(BuildContext context, Document document) async {
    final identity = ref.read(identityNotifierProvider).identity;
    final l10n = AppLocalizations.of(context)!;
    if (identity == null) return;

    // Show loading indicator
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(l10n.signingInProgressDialog),
          ],
        ),
      ),
    );

    try {
      // Sign document
      final signedDocument =
          await ref.read(documentNotifierProvider.notifier).signDocument(
                documentId: document.id,
                signerIdentityAddress: identity.identityAddress,
              );

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show result
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.documentSignedDialogTitle),
            content: Text(
              signedDocument != null
                  ? l10n.documentSignedSuccess
                  : l10n.documentSigningFailed,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.closeButton),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.errorDialogTitle),
            content: Text(l10n.genericErrorMessage(e.toString())),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.closeButton),
              ),
            ],
          ),
        );
      }
    }
  }

  // Confirm document deletion
  void _confirmDeleteDocument(BuildContext context, Document document) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmDeletionDialogTitle),
        content: Text(l10n.confirmDeletionDialogContent(document.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteDocument(context, document);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Delete document
  Future<void> _deleteDocument(BuildContext context, Document document) async {
    // Show loading indicator
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Deletion in progress...'),
          ],
        ),
      ),
    );

    try {
      // Delete document
      final success = await ref
          .read(documentNotifierProvider.notifier)
          .deleteDocument(document.id);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show result
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Document deleted successfully'
                  : 'Document deletion failed',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Utilities
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
        return 'Unverified';
      case DocumentVerificationStatus.pending:
        return 'Pending';
      case DocumentVerificationStatus.verified:
        return 'Verified';
      case DocumentVerificationStatus.rejected:
        return 'Rejected';
      case DocumentVerificationStatus.expired:
        return 'Expired';
    }
  }
}
