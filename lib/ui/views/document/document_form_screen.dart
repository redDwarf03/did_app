import 'dart:io';
import 'dart:typed_data';

import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Screen for adding new documents or editing existing ones
class DocumentFormScreen extends ConsumerStatefulWidget {
  const DocumentFormScreen({
    super.key,
    this.documentId,
  });

  /// If provided, the screen will edit an existing document instead of creating a new one
  final String? documentId;

  @override
  ConsumerState<DocumentFormScreen> createState() => _DocumentFormScreenState();
}

class _DocumentFormScreenState extends ConsumerState<DocumentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _issuerController = TextEditingController();

  late DocumentType _documentType = DocumentType.other;
  DateTime? _expirationDate;
  List<String> _tags = [];
  bool _isShareable = true;
  EidasLevel _eidasLevel = EidasLevel.low;

  File? _selectedFile;
  Uint8List? _fileBytes;
  String? _fileName;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.documentId != null) {
      _loadDocument();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _issuerController.dispose();
    super.dispose();
  }

  Future<void> _loadDocument() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(documentNotifierProvider.notifier)
          .loadDocument(widget.documentId!);

      final document = ref.read(documentNotifierProvider).selectedDocument;
      if (document != null) {
        _titleController.text = document.title;
        _descriptionController.text = document.description ?? '';
        _issuerController.text = document.issuer;
        setState(() {
          _documentType = document.type;
          _expirationDate = document.expiresAt;
          _tags = document.tags ?? [];
          _isShareable = document.isShareable;
          _eidasLevel = document.eidasLevel;
        });
      } else {
        setState(() {
          _errorMessage = 'Document not found';
        });
      }
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

  Future<void> _pickFile() async {
    // In a real implementation, this would use file_picker or similar
    // For now, we'll just show a dialog indicating this is pending implementation
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Document File'),
        content: const Text(
          'This feature is pending implementation. In a real app, '
          'you would be able to select a file from your device or '
          'take a picture of a document.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );

    // Mock file selection for demo purposes
    setState(() {
      _fileName = 'document.pdf';
      // Create some mock data (10KB of random data)
      _fileBytes = Uint8List(10 * 1024);
      for (var i = 0; i < _fileBytes!.length; i++) {
        _fileBytes![i] = i % 256;
      }
    });
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_fileBytes == null || _fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a document file'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need an identity to add documents'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.documentId != null) {
        // Update existing document
        final success =
            await ref.read(documentNotifierProvider.notifier).updateDocument(
                  documentId: widget.documentId!,
                  fileBytes: _fileBytes!,
                  title: _titleController.text,
                  description: _descriptionController.text.isNotEmpty
                      ? _descriptionController.text
                      : null,
                  issuer: _issuerController.text,
                  expiresAt: _expirationDate,
                  tags: _tags.isNotEmpty ? _tags : null,
                  isShareable: _isShareable,
                  eidasLevel: _eidasLevel,
                  changeNote: 'Updated via app',
                );

        if (success != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document updated successfully'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          setState(() {
            _errorMessage = 'Failed to update document';
          });
        }
      } else {
        // Add new document
        final document =
            await ref.read(documentNotifierProvider.notifier).addDocument(
                  identityAddress: identity.identityAddress,
                  fileBytes: _fileBytes!,
                  fileName: _fileName!,
                  documentType: _documentType,
                  title: _titleController.text,
                  description: _descriptionController.text.isNotEmpty
                      ? _descriptionController.text
                      : null,
                  issuer: _issuerController.text,
                  expiresAt: _expirationDate,
                  tags: _tags.isNotEmpty ? _tags : null,
                  isShareable: _isShareable,
                  eidasLevel: _eidasLevel,
                );

        if (document != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document added successfully'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          setState(() {
            _errorMessage = 'Failed to add document';
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _selectExpirationDate() async {
    final initialDate =
        _expirationDate ?? DateTime.now().add(const Duration(days: 365));
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );

    if (selectedDate != null) {
      setState(() {
        _expirationDate = selectedDate;
      });
    }
  }

  void _showTagDialog() {
    final tagController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: tagController,
          decoration: const InputDecoration(
            labelText: 'Tag',
            hintText: 'Enter tag text',
          ),
          autofocus: true,
          onSubmitted: (value) {
            _addTag(value);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _addTag(tagController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.documentId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Document' : 'Add Document'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveDocument,
            child: const Text('Save'),
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
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Document file section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.file_present),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Document File',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton.icon(
                                      onPressed: _pickFile,
                                      icon: const Icon(Icons.upload_file),
                                      label: const Text('Select File'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                if (_fileName != null)
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.insert_drive_file),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _fileName!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${(_fileBytes!.length / 1024).toStringAsFixed(2)} KB',
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            setState(() {
                                              _fileName = null;
                                              _fileBytes = null;
                                            });
                                          },
                                          tooltip: 'Remove',
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  const Center(
                                    child: Text(
                                      'No file selected',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Basic info section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Basic Information',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Document title
                                TextFormField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                    hintText: 'Enter document title',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Document type
                                DropdownButtonFormField<DocumentType>(
                                  value: _documentType,
                                  decoration: const InputDecoration(
                                    labelText: 'Document Type',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: DocumentType.values.map((type) {
                                    return DropdownMenuItem<DocumentType>(
                                      value: type,
                                      child: Text(_getDocumentTypeName(type)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _documentType = value;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Description
                                TextFormField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    labelText: 'Description (optional)',
                                    hintText: 'Enter a description',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 16),

                                // Issuer
                                TextFormField(
                                  controller: _issuerController,
                                  decoration: const InputDecoration(
                                    labelText: 'Issuer',
                                    hintText:
                                        'Enter issuing authority or organization',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an issuer';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Expiration date
                                Row(
                                  children: [
                                    const Text('Expiration Date (optional):'),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: _selectExpirationDate,
                                        child: Text(
                                          _expirationDate != null
                                              ? DateFormat('dd/MM/yyyy')
                                                  .format(_expirationDate!)
                                              : 'No expiration',
                                        ),
                                      ),
                                    ),
                                    if (_expirationDate != null)
                                      IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _expirationDate = null;
                                          });
                                        },
                                        tooltip: 'Clear date',
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Additional options section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Additional Options',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Shareable switch
                                SwitchListTile(
                                  title: const Text('Document is shareable'),
                                  subtitle: const Text(
                                    'Allow this document to be shared with other entities or individuals',
                                  ),
                                  value: _isShareable,
                                  onChanged: (value) {
                                    setState(() {
                                      _isShareable = value;
                                    });
                                  },
                                ),
                                const Divider(),

                                // eIDAS level
                                const Text('eIDAS Assurance Level:'),
                                const SizedBox(height: 8),
                                SegmentedButton<EidasLevel>(
                                  segments: const [
                                    ButtonSegment(
                                      value: EidasLevel.low,
                                      label: Text('Low'),
                                    ),
                                    ButtonSegment(
                                      value: EidasLevel.substantial,
                                      label: Text('Substantial'),
                                    ),
                                    ButtonSegment(
                                      value: EidasLevel.high,
                                      label: Text('High'),
                                    ),
                                  ],
                                  selected: {_eidasLevel},
                                  onSelectionChanged: (newSelection) {
                                    setState(() {
                                      _eidasLevel = newSelection.first;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                const Divider(),

                                // Tags
                                Row(
                                  children: [
                                    const Text('Tags:'),
                                    const Spacer(),
                                    TextButton.icon(
                                      onPressed: _showTagDialog,
                                      icon: const Icon(Icons.add),
                                      label: const Text('Add Tag'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: _tags.map((tag) {
                                    return Chip(
                                      label: Text(tag),
                                      onDeleted: () => _removeTag(tag),
                                      deleteIcon:
                                          const Icon(Icons.close, size: 18),
                                    );
                                  }).toList(),
                                ),
                                if (_tags.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'No tags added yet',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
