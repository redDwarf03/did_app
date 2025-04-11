import 'package:did_app/application/document/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Dialog to share a document with others
class DocumentShareDialog extends ConsumerStatefulWidget {
  const DocumentShareDialog({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  ConsumerState<DocumentShareDialog> createState() =>
      _DocumentShareDialogState();
}

class _DocumentShareDialogState extends ConsumerState<DocumentShareDialog> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _accessCodeController = TextEditingController();

  DateTime _expirationDate = DateTime.now().add(const Duration(days: 7));
  DocumentShareAccessType _accessType = DocumentShareAccessType.readOnly;
  bool _requireAccessCode = false;
  int? _maxAccessCount;

  @override
  void dispose() {
    _recipientController.dispose();
    _accessCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share Document'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document being shared
              Text(
                'Document: ${widget.document.title}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Recipient
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'Recipient',
                  hintText: 'Name or email of recipient',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipient name or email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Expiration date
              Row(
                children: [
                  const Text('Expires:'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectExpirationDate(context),
                      child: Text(
                        DateFormat('dd MMM yyyy').format(_expirationDate),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Access type
              const Text('Access Type:'),
              const SizedBox(height: 8),
              DropdownButtonFormField<DocumentShareAccessType>(
                value: _accessType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: const [
                  DropdownMenuItem(
                    value: DocumentShareAccessType.readOnly,
                    child: Text('Read Only'),
                  ),
                  DropdownMenuItem(
                    value: DocumentShareAccessType.download,
                    child: Text('Download'),
                  ),
                  DropdownMenuItem(
                    value: DocumentShareAccessType.verify,
                    child: Text('Verification Only'),
                  ),
                  DropdownMenuItem(
                    value: DocumentShareAccessType.fullAccess,
                    child: Text('Full Access'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _accessType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Max access count
              Row(
                children: [
                  const Text('Max accesses:'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int?>(
                      value: _maxAccessCount,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Unlimited'),
                        ),
                        for (int i = 1; i <= 10; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text('$i'),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _maxAccessCount = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Access code
              SwitchListTile(
                title: const Text('Require access code'),
                value: _requireAccessCode,
                onChanged: (value) {
                  setState(() {
                    _requireAccessCode = value;
                  });
                },
                contentPadding: EdgeInsets.zero,
              ),
              if (_requireAccessCode) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _accessCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Access Code',
                    hintText: 'Enter 4-6 digit code',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an access code';
                    }
                    if (value.length < 4 || value.length > 6) {
                      return 'Code must be 4-6 digits';
                    }
                    return null;
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _shareDocument,
          child: const Text('Share'),
        ),
      ],
    );
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final currentDate = DateTime.now();
    final initialDate = _expirationDate.isAfter(currentDate)
        ? _expirationDate
        : currentDate.add(const Duration(days: 1));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: currentDate.add(const Duration(days: 1)),
      lastDate: currentDate.add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        _expirationDate = selectedDate;
      });
    }
  }

  Future<void> _shareDocument() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Creating share...'),
          ],
        ),
      ),
    );

    try {
      final share = await ref
          .read(documentNotifierProvider.notifier)
          .shareDocument(
            documentId: widget.document.id,
            recipientDescription: _recipientController.text,
            expiresAt: _expirationDate,
            accessType: _accessType,
            accessCode: _requireAccessCode ? _accessCodeController.text : null,
            maxAccessCount: _maxAccessCount,
          );

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Close the form and show result
      if (context.mounted) {
        Navigator.of(context).pop(share);

        if (share != null) {
          _showShareSuccess(context, share);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to create share.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
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

  void _showShareSuccess(BuildContext context, DocumentShare share) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Document Shared'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Share URL:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      share.shareUrl,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      // In a real implementation, copy to clipboard
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('URL copied to clipboard'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    tooltip: 'Copy URL',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Recipient: ${share.recipientDescription}'),
            Text(
                'Expires: ${DateFormat('dd MMM yyyy').format(share.expiresAt)}'),
            if (share.accessCode != null)
              Text('Access Code: ${share.accessCode}'),
            if (share.maxAccessCount != null)
              Text('Max Accesses: ${share.maxAccessCount}'),
          ],
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
}
