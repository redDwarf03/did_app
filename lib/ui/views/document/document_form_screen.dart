import 'dart:io';
import 'dart:typed_data';

import 'package:did_app/application/document/providers.dart';
import 'package:did_app/application/identity/providers.dart';
import 'package:did_app/domain/document/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.pickDocumentFileDialogTitle),
        content:
            Text(AppLocalizations.of(context)!.pickDocumentFeatureNotAvailable),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.closeButton),
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
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.pleaseSelectDocumentFileError),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final identity = ref.read(identityNotifierProvider).identity;
    if (identity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.needIdentityToAddError),
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
                  changeNote: AppLocalizations.of(context)!.changeNoteAppUpdate,
                );

        if (success != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.updateDocumentSuccess),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          setState(() {
            _errorMessage =
                AppLocalizations.of(context)!.failedToUpdateDocumentError;
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
              SnackBar(
                content: Text(AppLocalizations.of(context)!.addDocumentSuccess),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          setState(() {
            _errorMessage =
                AppLocalizations.of(context)!.failedToAddDocumentError;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            AppLocalizations.of(context)!.genericErrorMessage(e.toString());
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
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.addTagDialogTitle),
        content: TextField(
          controller: tagController,
          decoration: InputDecoration(
            labelText: l10n.tagLabel,
            hintText: l10n.tagHintText,
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
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              _addTag(tagController.text);
              Navigator.of(context).pop();
            },
            child: Text(l10n.addTagButton),
          ),
        ],
      ),
    );
  }

  String _getDocumentTypeName(DocumentType type) {
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

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.documentId != null;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editDocumentTitle : l10n.addDocumentTitle),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveDocument,
            child: Text(l10n.saveButton),
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
                          size: 64, color: Colors.red,),
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
                                    Text(
                                      l10n.documentFileSectionTitle,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton.icon(
                                      onPressed: _pickFile,
                                      icon: const Icon(Icons.upload_file),
                                      label: Text(l10n.selectFileButton),
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
                                                        FontWeight.bold,),
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
                                          tooltip: l10n.removeFileTooltip,
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .noFileSelected,
                                      style: const TextStyle(
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
                                Text(
                                  AppLocalizations.of(context)!
                                      .basicInfoSectionTitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Document title
                                TextFormField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .titleLabel,
                                    hintText: AppLocalizations.of(context)!
                                        .titleHintText,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .titleValidationError;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Document type
                                DropdownButtonFormField<DocumentType>(
                                  value: _documentType,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .documentTypeLabelForm,
                                    border: const OutlineInputBorder(),
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
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .descriptionLabel,
                                    hintText: AppLocalizations.of(context)!
                                        .descriptionHintText,
                                    border: const OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 16),

                                // Issuer
                                TextFormField(
                                  controller: _issuerController,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .issuerLabelForm,
                                    hintText: AppLocalizations.of(context)!
                                        .issuerHintText,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .issuerValidationError;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Expiration date
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!
                                        .expirationDateLabelForm,),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: _selectExpirationDate,
                                        child: Text(
                                          _expirationDate != null
                                              ? DateFormat('dd/MM/yyyy')
                                                  .format(_expirationDate!)
                                              : AppLocalizations.of(context)!
                                                  .noExpirationDateButton,
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
                                        tooltip: AppLocalizations.of(context)!
                                            .clearDateTooltip,
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
                                Text(
                                  AppLocalizations.of(context)!
                                      .additionalOptionsSectionTitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Shareable switch
                                SwitchListTile(
                                  title: Text(AppLocalizations.of(context)!
                                      .documentIsShareableSwitch,),
                                  subtitle: Text(
                                    AppLocalizations.of(context)!
                                        .documentIsShareableSubtitle,
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
                                Text(AppLocalizations.of(context)!
                                    .eidasLevelLabelForm,),
                                const SizedBox(height: 8),
                                SegmentedButton<EidasLevel>(
                                  segments: [
                                    ButtonSegment(
                                      value: EidasLevel.low,
                                      label: Text(AppLocalizations.of(context)!
                                          .eidasLevelLowLabel,),
                                    ),
                                    ButtonSegment(
                                      value: EidasLevel.substantial,
                                      label: Text(AppLocalizations.of(context)!
                                          .eidasLevelSubstantialLabel,),
                                    ),
                                    ButtonSegment(
                                      value: EidasLevel.high,
                                      label: Text(AppLocalizations.of(context)!
                                          .eidasLevelHighLabel,),
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
                                    Text(AppLocalizations.of(context)!
                                        .tagsLabelForm,),
                                    const Spacer(),
                                    TextButton.icon(
                                      onPressed: _showTagDialog,
                                      icon: const Icon(Icons.add),
                                      label: Text(AppLocalizations.of(context)!
                                          .addTagButtonForm,),
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
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      AppLocalizations.of(context)!.noTagsAdded,
                                      style: const TextStyle(
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
