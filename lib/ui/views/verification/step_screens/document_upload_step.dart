import 'dart:math';

import 'package:did_app/application/verification/providers.dart';
import 'package:did_app/domain/verification/verification_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic document upload step component for verification process
class DocumentUploadStep extends ConsumerStatefulWidget {
  const DocumentUploadStep({
    super.key,
    required this.step,
    required this.title,
    required this.description,
    required this.documentType,
  });

  /// The verification step being processed
  final VerificationStep step;

  /// Title for this document upload step
  final String title;

  /// Detailed description for this document upload step
  final String description;

  /// Type of document being uploaded (e.g. "ID Document", "Proof of Address")
  final String documentType;

  @override
  ConsumerState<DocumentUploadStep> createState() => _DocumentUploadStepState();
}

class _DocumentUploadStepState extends ConsumerState<DocumentUploadStep> {
  // Mock list of uploaded documents
  final List<String> _uploadedDocuments = [];

  // Random generator for mock file paths
  final _random = Random();

  // Loading state
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),

        // Document upload section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload ${widget.documentType}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              // Upload buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUploadButton(
                    'Take Photo',
                    Icons.camera_alt,
                    _takePhoto,
                  ),
                  _buildUploadButton(
                    'Upload File',
                    Icons.upload_file,
                    _uploadFile,
                  ),
                ],
              ),

              // Instructions
              const SizedBox(height: 16),
              const Text(
                'Make sure your documents are:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              _buildCheckItem('Clear and readable'),
              _buildCheckItem('Showing all 4 corners'),
              _buildCheckItem('Not expired'),
              _buildCheckItem('Without glare or shadows'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Uploaded documents list
        if (_uploadedDocuments.isNotEmpty) ...[
          const Text(
            'Uploaded Documents',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ..._uploadedDocuments.map(_buildUploadedItem),
          const SizedBox(height: 24),
        ],

        // Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isUploading || _uploadedDocuments.isEmpty
                ? null
                : _submitDocuments,
            icon: _isUploading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.send),
            label: Text(_isUploading ? 'Submitting...' : 'Submit Documents'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  /// Build an upload button with an icon and label
  Widget _buildUploadButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  /// Build a check item with a bullet point
  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  /// Build an item representing an uploaded document
  Widget _buildUploadedItem(String document) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.description),
        title: Text(document),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => _removeDocument(document),
        ),
      ),
    );
  }

  /// Remove a document from the uploaded list
  void _removeDocument(String document) {
    setState(() {
      _uploadedDocuments.remove(document);
    });
  }

  /// Handle taking a photo (mock implementation)
  void _takePhoto() {
    setState(() {
      final mockFilename = 'PHOTO_${DateTime.now().millisecondsSinceEpoch}.jpg';
      _uploadedDocuments.add(mockFilename);
    });
  }

  /// Handle uploading a file (mock implementation)
  void _uploadFile() {
    setState(() {
      final fileTypes = ['.jpg', '.png', '.pdf'];
      final randomType = fileTypes[_random.nextInt(fileTypes.length)];
      final mockFilename =
          '${widget.documentType.toUpperCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}$randomType';
      _uploadedDocuments.add(mockFilename);
    });
  }

  /// Submit the documents to the verification process
  Future<void> _submitDocuments() async {
    if (_uploadedDocuments.isEmpty) return;

    setState(() {
      _isUploading = true;
    });

    // Submit documents to the verification provider
    await ref
        .read(verificationNotifierProvider.notifier)
        .submitVerificationStep(_uploadedDocuments);

    setState(() {
      _isUploading = false;
    });
  }
}
