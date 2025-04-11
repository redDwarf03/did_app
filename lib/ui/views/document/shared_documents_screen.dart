import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:did_app/ui/views/document/document_detail_screen.dart';

/// Screen displaying documents shared with the user
class SharedDocumentsScreen extends ConsumerStatefulWidget {
  const SharedDocumentsScreen({super.key});

  @override
  ConsumerState<SharedDocumentsScreen> createState() =>
      _SharedDocumentsScreenState();
}

class _SharedDocumentsScreenState extends ConsumerState<SharedDocumentsScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSharedDocuments();
  }

  Future<void> _loadSharedDocuments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final identity = ref.read(identityNotifierProvider).identity;
      if (identity == null) {
        setState(() {
          _errorMessage = 'Identity required to view shared documents';
        });
        return;
      }

      await ref
          .read(documentNotifierProvider.notifier)
          .loadSharedWithMe(identity.identityAddress);
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading shared documents: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _accessSharedDocument(DocumentShare share) async {
    // Show access code dialog if required
    String? accessCode;
    if (share.accessCode != null) {
      accessCode = await _promptForAccessCode(context);
      if (accessCode == null) {
        // User cancelled
        return;
      }
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
            Text('Accessing shared document...'),
          ],
        ),
      ),
    );

    try {
      final document = await ref
          .read(documentNotifierProvider.notifier)
          .accessSharedDocument(share.shareUrl, accessCode);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Open document if successful
      if (document != null && context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DocumentDetailScreen(documentId: document.id),
          ),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to access shared document'),
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
            content: Text('Error: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<String?> _promptForAccessCode(BuildContext context) async {
    final codeController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Access Code Required'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This document requires an access code to view.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Access Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              autofocus: true,
              onSubmitted: (value) => Navigator.of(context).pop(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(codeController.text),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(documentNotifierProvider);
    final sharedDocuments = state.sharedWithMe;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared With Me'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadSharedDocuments,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : _buildSharedDocumentsList(context, sharedDocuments),
    );
  }

  Widget _buildSharedDocumentsList(
      BuildContext context, List<DocumentShare> shares) {
    if (shares.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.folder_shared_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No shared documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Documents shared with you will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadSharedDocuments,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shares.length,
      itemBuilder: (context, index) {
        final share = shares[index];
        return _buildSharedDocumentCard(context, share);
      },
    );
  }

  Widget _buildSharedDocumentCard(BuildContext context, DocumentShare share) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _accessSharedDocument(share),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.folder_shared, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      share.documentTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (share.accessCode != null)
                    const Tooltip(
                      message: 'Access code required',
                      child: Icon(Icons.lock, color: Colors.orange),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              const Divider(),

              // Shared by and dates
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Shared by: ${share.recipientDescription}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.date_range, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Shared on: ${dateFormat.format(share.createdAt)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.event_busy, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Expires on: ${dateFormat.format(share.expiresAt)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Access type info
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getAccessTypeIcon(share.accessType),
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getAccessTypeName(share.accessType),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Access button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => _accessSharedDocument(share),
                  icon: const Icon(Icons.visibility),
                  label: const Text('Access Document'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getAccessTypeIcon(DocumentShareAccessType type) {
    switch (type) {
      case DocumentShareAccessType.readOnly:
        return Icons.visibility;
      case DocumentShareAccessType.download:
        return Icons.download;
      case DocumentShareAccessType.verify:
        return Icons.verified_user;
      case DocumentShareAccessType.fullAccess:
        return Icons.edit;
    }
  }

  String _getAccessTypeName(DocumentShareAccessType type) {
    switch (type) {
      case DocumentShareAccessType.readOnly:
        return 'Read Only';
      case DocumentShareAccessType.download:
        return 'Download';
      case DocumentShareAccessType.verify:
        return 'Verification';
      case DocumentShareAccessType.fullAccess:
        return 'Full Access';
    }
  }
}
