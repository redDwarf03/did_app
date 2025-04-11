import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

    if (identityState.identity == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Documents'),
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
                'Identity Required',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You must create a digital identity to access your documents',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
                softWrap: true,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pushNamed('createIdentity'),
                child: const Text('Create an Identity'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Documents'),
        actions: [
          // Button to refresh the list
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: documentState.isLoading ? null : _loadDocuments,
            tooltip: 'Refresh',
          ),
          // Button to display documents shared with me
          IconButton(
            icon: const Icon(Icons.download_for_offline),
            onPressed: documentState.isLoading
                ? null
                : () => _showSharedWithMe(context),
            tooltip: 'Documents shared with me',
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
        tooltip: 'Add document',
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
              'No document',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add documents to store and share securely',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddDocumentDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add document'),
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
    // Formatter dates
    final dateFormat = DateFormat('dd/MM/yyyy');
    final issuedAt = dateFormat.format(document.issuedAt);
    final expiresAt = document.expiresAt != null
        ? dateFormat.format(document.expiresAt!)
        : 'Non applicable';

    // Color based on verification status
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
              // Title and document type
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
                      color: statusColor.withValues(alpha: 0.1),
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

              // Issuer
              Row(
                children: [
                  const Icon(Icons.business, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Issuer: ${document.issuer}',
                    style: const TextStyle(fontSize: 14),
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
                    'Issued: $issuedAt',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 16),
                  if (document.expiresAt != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.event_busy,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Expire: $expiresAt',
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
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          labelStyle: const TextStyle(fontSize: 12),
                          padding: EdgeInsets.zero,
                        ),
                      )
                      .toList(),
                ),

              const SizedBox(height: 8),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Download button
                  IconButton(
                    icon: const Icon(Icons.download),
                    tooltip: 'Download',
                    onPressed: () => _downloadDocument(context, document),
                  ),
                  // Share button (if document is shareable)
                  if (document.isShareable)
                    IconButton(
                      icon: const Icon(Icons.share),
                      tooltip: 'Share',
                      onPressed: () => _showShareDialog(context, document),
                    ),
                  // Verify button
                  IconButton(
                    icon: const Icon(Icons.verified_user),
                    tooltip: 'Verify authenticity',
                    onPressed: () => _verifyDocument(context, document),
                  ),
                  // Context menu button
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        _handleMenuAction(context, value, document),
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'versions',
                        child: Text('View versions'),
                      ),
                      if (document.verificationStatus !=
                          DocumentVerificationStatus.verified)
                        const PopupMenuItem<String>(
                          value: 'sign',
                          child: Text('Sign'),
                        ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
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

  // Show document add dialog
  Future<void> _showAddDocumentDialog(BuildContext context) async {
    // In a complete implementation, this would open a file selection dialog
    // and input document metadata
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add document'),
        content: const Text('This feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Open document details
  void _openDocumentDetails(BuildContext context, Document document) {
    // For a complete implementation, this would navigate to the document details screen
    // context.push('/documents/${document.id}');

    // For now, show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(document.title),
        content: const Text(
          'The document details screen will be implemented soon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Download document
  Future<void> _downloadDocument(
    BuildContext context,
    Document document,
  ) async {
    // For a complete implementation, this would download the document
    // final content = await ref.read(documentNotifierProvider.notifier).getDocumentContent(document.id);

    // For now, show a simple dialog
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download document'),
        content: const Text(
          'The document download feature will be implemented soon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show document share dialog
  Future<void> _showShareDialog(BuildContext context, Document document) async {
    // For a complete implementation, this would open a share dialog
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share document'),
        content: const Text(
          'The document sharing feature will be implemented soon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Verify document authenticity
  Future<void> _verifyDocument(BuildContext context, Document document) async {
    // Show loading indicator
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Verification in progress...'),
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
            title: const Text('Verification result'),
            content: Text(
              status != null
                  ? 'Status: ${_getVerificationStatusText(status)}'
                  : 'Verification failed. Please try again.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
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
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    }
  }

  // Show documents shared with user
  Future<void> _showSharedWithMe(BuildContext context) async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) return;

    try {
      // Load shared documents
      await ref
          .read(documentNotifierProvider.notifier)
          .loadSharedWithMe(identity.identityAddress);

      // Navigate to shared documents screen
      // context.push('/documents/shared-with-me');

      // For now, show a simple dialog
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Documents shared with me'),
            content: const Text(
              'The shared documents screen will be implemented soon.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    }
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
    // For a complete implementation, this would open an edit dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit document'),
        content: const Text(
          'The document editing feature will be implemented soon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show document versions history
  void _showVersions(BuildContext context, Document document) {
    // For a complete implementation, this would display document versions history
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Document versions history'),
        content: const Text(
          'The document versions history feature will be implemented soon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Sign document
  Future<void> _signDocument(BuildContext context, Document document) async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) return;

    // Show loading indicator
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Signing in progress...'),
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
            title: const Text('Document signed'),
            content: Text(
              signedDocument != null
                  ? 'The document was signed successfully.'
                  : 'Signing failed. Please try again.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
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
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    }
  }

  // Confirm document deletion
  void _confirmDeleteDocument(BuildContext context, Document document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm deletion'),
        content: Text('Are you sure you want to delete "${document.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
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
