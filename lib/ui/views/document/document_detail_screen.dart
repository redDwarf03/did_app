import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:did_app/ui/views/document/widgets/document_share_dialog.dart';
import 'package:did_app/ui/views/document/document_versions_screen.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.documentDetailTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (document == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.documentDetailTitle)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                l10n.documentNotFoundTitle,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(l10n.documentNotFoundContent(widget.documentId)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadDocument,
                child: Text(l10n.retryButton),
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
        : l10n.noExpirationDate;
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
            tooltip: l10n.shareDocumentAction,
          ),
          IconButton(
            icon: const Icon(Icons.verified_user),
            onPressed: () => _verifyDocument(context, document),
            tooltip: l10n.verifyAuthenticityAction,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadDocument(context, document),
            tooltip: l10n.downloadDocumentAction,
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value, document),
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text(l10n.editDocumentAction),
              ),
              PopupMenuItem<String>(
                value: 'versions',
                child: Text(l10n.viewVersionsAction),
              ),
              if (document.verificationStatus !=
                  DocumentVerificationStatus.verified)
                PopupMenuItem<String>(
                  value: 'sign',
                  child: Text(l10n.signDocumentAction),
                ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text(l10n.deleteDocumentAction),
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
                    Text(l10n.documentPreviewNotAvailable),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => _downloadDocument(context, document),
                      icon: const Icon(Icons.download),
                      label: Text(l10n.downloadToViewButton),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Document details sections
            _buildInfoSection(
              context: context,
              title: l10n.documentInfoSectionTitle,
              icon: Icons.description,
              children: [
                _buildInfoRow(context, l10n.documentTypeLabel,
                    _getDocumentTypeName(document.type, context)),
                _buildInfoRow(
                    context,
                    l10n.documentStatusLabel,
                    _getVerificationStatusText(
                        document.verificationStatus, context)),
                if (document.description != null)
                  _buildInfoRow(context, l10n.documentDescriptionLabel,
                      document.description!),
                _buildInfoRow(context, l10n.documentVersionLabel,
                    document.version.toString()),
              ],
            ),
            const SizedBox(height: 16),

            _buildInfoSection(
              context: context,
              title: l10n.issuerAndDatesSectionTitle,
              icon: Icons.business,
              children: [
                _buildInfoRow(context, l10n.issuerLabelDetail, document.issuer),
                _buildInfoRow(context, l10n.issueDateLabelDetail, issuedAt),
                _buildInfoRow(
                    context, l10n.expirationDateLabelDetail, expiresAt),
                _buildInfoRow(context, l10n.lastUpdatedLabel, updatedAt),
              ],
            ),
            const SizedBox(height: 16),

            if (document.verificationStatus ==
                DocumentVerificationStatus.verified)
              _buildInfoSection(
                context: context,
                title: l10n.verificationSectionTitle,
                icon: Icons.verified_user,
                children: [
                  _buildInfoRow(context, l10n.verifiedLabel, l10n.yesVerified),
                  if (document.issuerAddress != null)
                    _buildInfoRow(context, l10n.issuerAddressLabel,
                        document.issuerAddress!),
                  if (document.blockchainTxId != null)
                    _buildInfoRow(context, l10n.blockchainTxLabel,
                        document.blockchainTxId!),
                  _buildInfoRow(context, l10n.eidasLevelLabelDetail,
                      _getEidasLevelText(document.eidasLevel, context)),
                ],
              ),
            const SizedBox(height: 16),

            if (document.tags != null && document.tags!.isNotEmpty)
              _buildTagsSection(context, document.tags!),
            const SizedBox(height: 16),

            if (state.documentShares.isNotEmpty)
              _buildSharesSection(context, state.documentShares),
            const SizedBox(height: 16),

            _buildMetadataSection(context, document.metadata),
            const SizedBox(height: 16),

            _buildTechnicalSection(context, document),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentHeader(BuildContext context, Document document) {
    final l10n = AppLocalizations.of(context)!;
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
            _getVerificationStatusText(document.verificationStatus, context),
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
    required BuildContext context,
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

  Widget _buildInfoRow(BuildContext context, String label, String value) {
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

  Widget _buildTagsSection(BuildContext context, List<String> tags) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.tag, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              l10n.tagsSectionTitle,
              style: const TextStyle(
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

  Widget _buildSharesSection(BuildContext context, List<DocumentShare> shares) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.share, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              l10n.activeSharesSectionTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Show add share dialog in full implementation
              },
              child: Text(l10n.shareNewButton),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        ...shares.map((share) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(share.recipientDescription),
            subtitle: Text(
                '${l10n.expiresShareLabel}: ${dateFormat.format(share.expiresAt)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _revokeShare(context, share),
              tooltip: l10n.revokeShareTooltip,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMetadataSection(
      BuildContext context, Map<String, dynamic>? metadata) {
    final l10n = AppLocalizations.of(context)!;
    if (metadata == null || metadata.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.data_object, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              l10n.metadataSectionTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        ...metadata.entries.map(
          (entry) => _buildInfoRow(context, entry.key, entry.value.toString()),
        ),
      ],
    );
  }

  Widget _buildTechnicalSection(BuildContext context, Document document) {
    final l10n = AppLocalizations.of(context)!;
    return ExpansionTile(
      title: Text(l10n.technicalDetailsSectionTitle),
      collapsedIconColor: Colors.grey,
      children: [
        ListTile(
          title: Text(l10n.documentIdLabelDetail),
          subtitle: Text(document.id),
          dense: true,
        ),
        ListTile(
          title: Text(l10n.documentHashLabel),
          subtitle: Text(document.documentHash),
          dense: true,
        ),
        if (document.issuerSignature != null)
          ListTile(
            title: Text(l10n.issuerSignatureLabel),
            subtitle: Text(document.issuerSignature!),
            dense: true,
          ),
        ListTile(
          title: Text(l10n.ownerIdentityLabel),
          subtitle: Text(document.ownerIdentityId),
          dense: true,
        ),
      ],
    );
  }

  // Actions
  Future<void> _downloadDocument(
      BuildContext context, Document document) async {
    final l10n = AppLocalizations.of(context)!;
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

  Future<void> _shareDocument(BuildContext context, Document document) async {
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
                      _getVerificationStatusText(status, context))
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

  Future<void> _revokeShare(BuildContext context, DocumentShare share) async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmRevocationDialogTitle),
        content: Text(
            l10n.confirmRevocationDialogContent(share.recipientDescription)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _doRevokeShare(context, share);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.revokeShareButton),
          ),
        ],
      ),
    );
  }

  Future<void> _doRevokeShare(BuildContext context, DocumentShare share) async {
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
            Text(l10n.revokingShareDialog),
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
              success ? l10n.shareRevokedSuccess : l10n.failedToRevokeShare,
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
            content: Text(l10n.genericErrorMessage(e.toString())),
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
    final l10n = AppLocalizations.of(context)!;
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
    final l10n = AppLocalizations.of(context)!;
    // For a complete implementation, this would open an edit dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editDocumentDialogTitle),
        content: Text(l10n.editFeatureNotAvailable),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.closeButton),
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
    final l10n = AppLocalizations.of(context)!;
    if (identity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.needIdentityToSignError),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

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
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDocument(BuildContext context, Document document) async {
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
            Text(l10n.deletionInProgressDialog),
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
                  ? l10n.documentDeletedSuccess
                  : l10n.documentDeletionFailed,
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
            content: Text(l10n.genericErrorMessage(e.toString())),
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

  String _getDocumentTypeName(DocumentType type, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case DocumentType.nationalId:
        return l10n.documentTypeNationalId;
      case DocumentType.passport:
        return l10n.documentTypePassport;
      case DocumentType.drivingLicense:
        return l10n.documentTypeDrivingLicense;
      case DocumentType.diploma:
        return l10n.documentTypeDiploma;
      case DocumentType.certificate:
        return l10n.documentTypeCertificate;
      case DocumentType.addressProof:
        return l10n.documentTypeAddressProof;
      case DocumentType.bankDocument:
        return l10n.documentTypeBankDocument;
      case DocumentType.medicalRecord:
        return l10n.documentTypeMedicalRecord;
      case DocumentType.corporateDocument:
        return l10n.documentTypeCorporateDocument;
      case DocumentType.other:
        return l10n.documentTypeOther;
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

  String _getVerificationStatusText(
      DocumentVerificationStatus status, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case DocumentVerificationStatus.unverified:
        return l10n.verificationStatusUnverified;
      case DocumentVerificationStatus.pending:
        return l10n.verificationStatusPending;
      case DocumentVerificationStatus.verified:
        return l10n.verificationStatusVerified;
      case DocumentVerificationStatus.rejected:
        return l10n.verificationStatusRejectedDetail;
      case DocumentVerificationStatus.expired:
        return l10n.verificationStatusExpiredDetail;
    }
  }

  String _getEidasLevelText(EidasLevel level, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (level) {
      case EidasLevel.low:
        return l10n.eidasLevelLow;
      case EidasLevel.substantial:
        return l10n.eidasLevelSubstantial;
      case EidasLevel.high:
        return l10n.eidasLevelHigh;
    }
  }
}
