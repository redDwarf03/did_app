import 'package:did_app/application/document/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Screen displaying the version history of a document
class DocumentVersionsScreen extends ConsumerStatefulWidget {
  const DocumentVersionsScreen({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  ConsumerState<DocumentVersionsScreen> createState() =>
      _DocumentVersionsScreenState();
}

class _DocumentVersionsScreenState
    extends ConsumerState<DocumentVersionsScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  List<DocumentVersion> _versions = [];
  DocumentVersion? _selectedVersion;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref
          .read(documentNotifierProvider.notifier)
          .loadDocument(widget.documentId);

      final document = ref.read(documentNotifierProvider).selectedDocument;
      if (document == null) {
        setState(() {
          _errorMessage = 'Document not found';
        });
        return;
      }

      final versions = ref.read(documentNotifierProvider).documentVersions;
      setState(() {
        _versions = List.from(versions);
        if (_versions.isNotEmpty) {
          // Select the most recent version by default
          _selectedVersion = _versions.first;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading document: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _viewVersionContent(DocumentVersion version) async {
    if (_selectedVersion?.id == version.id) {
      return; // Already selected
    }

    setState(() {
      _selectedVersion = version;
    });
  }

  Future<void> _compareVersions() async {
    // In a real implementation, this would show a diff view between versions

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Compare Versions'),
        content: const Text(
          'The version comparison feature will be implemented in a future release.',
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

  @override
  Widget build(BuildContext context) {
    final document = ref.watch(documentNotifierProvider).selectedDocument;

    return Scaffold(
      appBar: AppBar(
        title: Text(document?.title ?? 'Document Versions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare),
            tooltip: 'Compare versions',
            onPressed: _versions.length > 1 ? _compareVersions : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: _isLoading ? null : _loadDocument,
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
              : _buildVersionsScreen(context),
    );
  }

  Widget _buildVersionsScreen(BuildContext context) {
    if (_versions.isEmpty) {
      return const Center(
        child: Text('No version history available for this document'),
      );
    }

    return Row(
      children: [
        // Version list - left sidebar
        SizedBox(
          width: 280,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Version History (${_versions.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: _versions.length,
                    itemBuilder: (context, index) {
                      final version = _versions[index];
                      final isSelected = _selectedVersion?.id == version.id;

                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: Colors.blue.withOpacity(0.1),
                        leading: CircleAvatar(
                          backgroundColor: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade200,
                          foregroundColor:
                              isSelected ? Colors.white : Colors.grey.shade700,
                          child: Text('v${version.versionNumber}'),
                        ),
                        title: Text(
                          'Version ${version.versionNumber}',
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd HH:mm')
                              .format(version.createdAt),
                        ),
                        onTap: () => _viewVersionContent(version),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // Version content - right panel
        Expanded(
          child: _selectedVersion != null
              ? _buildVersionDetails(_selectedVersion!)
              : const Center(
                  child: Text('Select a version to view details'),
                ),
        ),
      ],
    );
  }

  Widget _buildVersionDetails(DocumentVersion version) {
    final dateFormat = DateFormat('dd MMM yyyy HH:mm');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Version header
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                radius: 24,
                child: Text('v${version.versionNumber}'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Version ${version.versionNumber}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Created on ${dateFormat.format(version.createdAt)}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _downloadVersionContent(version),
                icon: const Icon(Icons.download),
                label: const Text('Download'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Change notes
          if (version.changeNote != null) ...[
            const Text(
              'Change Notes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(version.changeNote!),
            ),
            const SizedBox(height: 24),
          ],

          // Document preview placeholder
          const Text(
            'Document Preview:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text('Document preview not available'),
                  SizedBox(height: 8),
                  Text(
                    'Download the document to view its contents',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Technical details
          const Text(
            'Technical Details:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Version ID:', version.id),
                  const Divider(),
                  _buildInfoRow('Document Hash:', version.documentHash),
                  const Divider(),
                  _buildInfoRow(
                    'Storage Path:',
                    version.encryptedStoragePath,
                  ),
                  if (version.blockchainTxId != null) ...[
                    const Divider(),
                    _buildInfoRow(
                      'Blockchain Transaction:',
                      version.blockchainTxId!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadVersionContent(DocumentVersion version) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Downloading version...'),
          ],
        ),
      ),
    );

    try {
      final content = await ref
          .read(documentNotifierProvider.notifier)
          .getVersionContent(widget.documentId, version.id);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show success message
      if (context.mounted) {
        if (content != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Downloaded version ${version.versionNumber} '
                '(${(content.length / 1024).toStringAsFixed(2)} KB)',
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to download version content'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
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
            content: Text('Error: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
