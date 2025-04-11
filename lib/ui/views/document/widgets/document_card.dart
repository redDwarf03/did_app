import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A reusable widget to display a document card in the application
class DocumentCard extends StatelessWidget {
  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    this.onDownload,
    this.onShare,
    this.onVerify,
    this.onEdit,
    this.onDelete,
    this.compact = false,
  });

  /// The document to display
  final Document document;

  /// Callback when the card is tapped (usually to open details)
  final VoidCallback onTap;

  /// Callback to download the document
  final VoidCallback? onDownload;

  /// Callback to share the document
  final VoidCallback? onShare;

  /// Callback to verify the document
  final VoidCallback? onVerify;

  /// Callback to edit the document
  final VoidCallback? onEdit;

  /// Callback to delete the document
  final VoidCallback? onDelete;

  /// Whether to display a compact version of the card
  final bool compact;

  @override
  Widget build(BuildContext context) {
    // Format dates
    final dateFormat = DateFormat('dd/MM/yyyy');
    final issuedAt = dateFormat.format(document.issuedAt);
    final expiresAt = document.expiresAt != null
        ? dateFormat.format(document.expiresAt!)
        : 'No expiration';

    // Color based on verification status
    final statusColor = _getStatusColor(document.verificationStatus);

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

              // Description - show only if not compact
              if (!compact && document.description != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    document.description!,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              // Only show these fields if not in compact mode
              if (!compact) ...[
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
                            'Expires: $expiresAt',
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
              ],

              const SizedBox(height: 8),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Download button
                  if (onDownload != null)
                    IconButton(
                      icon: const Icon(Icons.download),
                      tooltip: 'Download',
                      onPressed: onDownload,
                    ),
                  // Share button (if document is shareable)
                  if (onShare != null && document.isShareable)
                    IconButton(
                      icon: const Icon(Icons.share),
                      tooltip: 'Share',
                      onPressed: onShare,
                    ),
                  // Verify button
                  if (onVerify != null)
                    IconButton(
                      icon: const Icon(Icons.verified_user),
                      tooltip: 'Verify authenticity',
                      onPressed: onVerify,
                    ),
                  // Edit and Delete available through popup menu
                  if (onEdit != null || onDelete != null)
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            if (onEdit != null) onEdit!();
                            break;
                          case 'delete':
                            if (onDelete != null) onDelete!();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        if (onEdit != null)
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                        if (onDelete != null)
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
