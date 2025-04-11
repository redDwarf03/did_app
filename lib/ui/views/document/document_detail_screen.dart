import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:did_app/ui/views/document/widgets/document_share_dialog.dart';
import 'package:did_app/ui/views/document/document_versions_screen.dart';

/// Screen displaying detailed information about a document
class DocumentDetailScreen extends ConsumerStatefulWidget {
  const DocumentDetailScreen({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  ConsumerState<DocumentDetailScreen> createState() =>
      _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends ConsumerState<DocumentDetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    await ref
        .read(documentNotifierProvider.notifier)
        .loadDocument(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(documentNotifierProvider);
    final document = state.selectedDocument;

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Document Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (document == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Document Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Document not found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                  'The document with ID ${widget.documentId} could not be found.'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadDocument,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Format dates
    final dateFormat = DateFormat('dd/MM/yyyy');
    final issuedAt = dateFormat.format(document.issuedAt);
    final expiresAt = document.expiresAt != null
        ? dateFormat.format(document.expiresAt!)
        : 'No expiration date';
    final updatedAt = dateFormat.format(document.updatedAt);

    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: document.isShareable
                ? () => _shareDocument(context, document)
                : null,
            tooltip: 'Share',
          ),
          IconButton(
            icon: const Icon(Icons.verified_user),
            onPressed: () => _verifyDocument(context, document),
            tooltip: 'Verify authenticity',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadDocument(context, document),
            tooltip: 'Download',
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value, document),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document header with type icon, title and verification status
            _buildDocumentHeader(context, document),
            const SizedBox(height: 24),

            // Document preview placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getDocumentTypeIcon(document.type),
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                        'Document preview not available in this version'),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => _downloadDocument(context, document),
                      icon: const Icon(Icons.download),
                      label: const Text('Download to view'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Document details sections
            _buildInfoSection(
              title: 'Document Information',
              icon: Icons.description,
              children: [
                _buildInfoRow('Type', _getDocumentTypeName(document.type)),
                _buildInfoRow('Status',
                    _getVerificationStatusText(document.verificationStatus)),
                if (document.description != null)
                  _buildInfoRow('Description', document.description!),
                _buildInfoRow('Version', document.version.toString()),
              ],
            ),
            const SizedBox(height: 16),

            _buildInfoSection(
              title: 'Issuer & Dates',
              icon: Icons.business,
              children: [
                _buildInfoRow('Issuer', document.issuer),
                _buildInfoRow('Issue Date', issuedAt),
                _buildInfoRow('Expiration Date', expiresAt),
                _buildInfoRow('Last Updated', updatedAt),
              ],
            ),
            const SizedBox(height: 16),

            if (document.verificationStatus ==
                DocumentVerificationStatus.verified)
              _buildInfoSection(
                title: 'Verification',
                icon: Icons.verified_user,
                children: [
                  _buildInfoRow('Verified', 'Yes'),
                  if (document.issuerAddress != null)
                    _buildInfoRow('Issuer Address', document.issuerAddress!),
                  if (document.blockchainTxId != null)
                    _buildInfoRow('Blockchain TX', document.blockchainTxId!),
                  _buildInfoRow(
                      'eIDAS Level', _getEidasLevelText(document.eidasLevel)),
                ],
              ),
            const SizedBox(height: 16),

            if (document.tags != null && document.tags!.isNotEmpty)
              _buildTagsSection(document.tags!),
            const SizedBox(height: 16),

            if (state.documentShares.isNotEmpty)
              _buildSharesSection(state.documentShares),
            const SizedBox(height: 16),

            _buildMetadataSection(document.metadata),
            const SizedBox(height: 16),

            _buildTechnicalSection(document),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentHeader(BuildContext context, Document document) {
    final statusColor = _getStatusColor(document.verificationStatus);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getDocumentTypeIcon(document.type),
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                document.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                document.issuer,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _getVerificationStatusText(document.verificationStatus),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.tag, size: 18, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Tags',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags
              .map(
                (tag) => Chip(
                  label: Text(tag),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSharesSection(List<DocumentShare> shares) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.share, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            const Text(
              'Active Shares',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Show add share dialog in full implementation
              },
              child: const Text('Share New'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        ...shares.map((share) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(share.recipientDescription),
            subtitle: Text('Expires: ${dateFormat.format(share.expiresAt)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _revokeShare(context, share),
              tooltip: 'Revoke',
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMetadataSection(Map<String, dynamic>? metadata) {
    if (metadata == null || metadata.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.data_object, size: 18, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Metadata',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        ...metadata.entries.map(
          (entry) => _buildInfoRow(entry.key, entry.value.toString()),
        ),
      ],
    );
  }

  Widget _buildTechnicalSection(Document document) {
    return ExpansionTile(
      title: const Text('Technical Details'),
      collapsedIconColor: Colors.grey,
      children: [
        ListTile(
          title: const Text('Document ID'),
          subtitle: Text(document.id),
          dense: true,
        ),
        ListTile(
          title: const Text('Document Hash'),
          subtitle: Text(document.documentHash),
          dense: true,
        ),
        if (document.issuerSignature != null)
          ListTile(
            title: const Text('Issuer Signature'),
            subtitle: Text(document.issuerSignature!),
            dense: true,
          ),
        ListTile(
          title: const Text('Owner Identity'),
          subtitle: Text(document.ownerIdentityId),
          dense: true,
        ),
      ],
    );
  }

  // Actions
  Future<void> _downloadDocument(
      BuildContext context, Document document) async {
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

  Future<void> _shareDocument(BuildContext context, Document document) async {
    if (!document.isShareable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This document is not shareable'),
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

  Future<void> _revokeShare(BuildContext context, DocumentShare share) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Revocation'),
        content: Text('Revoke access for ${share.recipientDescription}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _doRevokeShare(context, share);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Revoke'),
          ),
        ],
      ),
    );
  }

  Future<void> _doRevokeShare(BuildContext context, DocumentShare share) async {
    // Show loading indicator
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Revoking share...'),
          ],
        ),
      ),
    );

    try {
      // Revoke share
      final success = await ref
          .read(documentNotifierProvider.notifier)
          .revokeShare(share.id);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show result
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Share revoked successfully' : 'Failed to revoke share',
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
        _showVersionHistory();
        break;
      case 'sign':
        await _signDocument(context, document);
        break;
      case 'delete':
        _confirmDeleteDocument(context, document);
        break;
    }
  }

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

  void _showVersionHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DocumentVersionsScreen(
          documentId: widget.documentId,
        ),
      ),
    );
  }

  Future<void> _signDocument(BuildContext context, Document document) async {
    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need an identity to sign documents'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

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

      // Show result and go back to list
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

        // Go back to list
        Navigator.of(context).pop();
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

  // Utility methods
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

  String _getDocumentTypeName(DocumentType type) {
    switch (type) {
      case DocumentType.nationalId:
        return 'National ID';
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.drivingLicense:
        return 'Driving License';
      case DocumentType.diploma:
        return 'Diploma';
      case DocumentType.certificate:
        return 'Certificate';
      case DocumentType.addressProof:
        return 'Address Proof';
      case DocumentType.bankDocument:
        return 'Bank Document';
      case DocumentType.medicalRecord:
        return 'Medical Record';
      case DocumentType.corporateDocument:
        return 'Corporate Document';
      case DocumentType.other:
        return 'Other';
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

  String _getEidasLevelText(EidasLevel level) {
    switch (level) {
      case EidasLevel.low:
        return 'Low';
      case EidasLevel.substantial:
        return 'Substantial';
      case EidasLevel.high:
        return 'High';
    }
  }
}
