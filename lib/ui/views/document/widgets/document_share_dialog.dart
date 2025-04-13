import 'package:did_app/application/document/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.shareDocument),
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
                decoration: InputDecoration(
                  labelText: l10n.recipient,
                  hintText: l10n.recipientHint,
                  border: const OutlineInputBorder(),
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
                  Text(l10n.expires),
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
              Text(l10n.accessType),
              SizedBox(height: 8),
              DropdownButtonFormField<DocumentShareAccessType>(
                value: _accessType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: [
                  DropdownMenuItem(
                    value: DocumentShareAccessType.readOnly,
                    child: Text(l10n.readOnly),
                  ),
                  DropdownMenuItem(
                    value: DocumentShareAccessType.download,
                    child: Text(l10n.download),
                  ),
                  DropdownMenuItem(
                    value: DocumentShareAccessType.verify,
                    child: Text(l10n.verificationOnly),
                  ),
                  DropdownMenuItem(
                    value: DocumentShareAccessType.fullAccess,
                    child: Text(l10n.fullAccess),
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
                  Text(l10n.maxAccesses),
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
                        DropdownMenuItem(
                          child: Text(l10n.unlimited),
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
                title: Text(l10n.requireAccessCode),
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
                  decoration: InputDecoration(
                    labelText: l10n.accessCode,
                    hintText: l10n.accessCodeHint,
                    border: const OutlineInputBorder(),
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
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _shareDocument,
          child: Text(l10n.share),
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
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text(AppLocalizations.of(context)!.creatingShare),
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
            SnackBar(
              content: Text(AppLocalizations.of(context)!.shareCreationFailed),
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
            content:
                Text(AppLocalizations.of(context)!.errorOccurred(e.toString())),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showShareSuccess(BuildContext context, DocumentShare share) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.documentShared),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.shareUrl),
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
                        SnackBar(
                          content: Text(l10n.urlCopied),
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
            Text(l10n.recipientInfo(share.recipientDescription)),
            Text(l10n.accessCodeInfo(share.accessCode ?? '')),
            if (share.maxAccessCount != null)
              Text(l10n.maxAccessesInfo(share.maxAccessCount ?? 0)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }
}
