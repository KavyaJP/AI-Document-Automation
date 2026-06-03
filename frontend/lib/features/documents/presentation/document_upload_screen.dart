import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:doc_query/features/documents/data/document_service.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final DocumentService _documentService = DocumentService();

  bool _isDragging = false;
  bool _isUploading = false;

  Future<void> _handleFileUpload(String filePath, String fileName) async {
    setState(() {
      _isUploading = true;
    });

    try {
      final message = await _documentService.uploadDocument(
        filePath: filePath,
        fileName: fileName,
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Upload Failed', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<void> _pickFile(List<String> extensions) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null && result.files.single.path != null) {
      await _handleFileUpload(
        result.files.single.path!,
        result.files.single.name,
      );
    }
  }

  void _showErrorDialog(String title, String clearDetails) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(clearDetails),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Ingestion')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: DropTarget(
          onDragEntered: (details) => setState(() => _isDragging = true),
          onDragExited: (details) => setState(() => _isDragging = false),
          onDragDone: (details) async {
            setState(() => _isDragging = false);
            if (details.files.isNotEmpty) {
              final file = details.files.first;
              await _handleFileUpload(file.path, file.name);
            }
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: _isDragging
                  ? Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withOpacity(0.5)
                  : Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: _isDragging
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isUploading)
                    const CircularProgressIndicator()
                  else ...[
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 64,
                      color: _isDragging
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Drag & drop any file here',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Supports PDF, Images (PNG, JPG, JPEG), and Text files (TXT, MD)',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCategoryCard(
                          title: 'PDF Document',
                          icon: Icons.picture_as_pdf,
                          color: Colors.redAccent,
                          extensions: ['pdf'],
                        ),
                        const SizedBox(width: 16),
                        _buildCategoryCard(
                          title: 'Image File',
                          icon: Icons.image,
                          color: Colors.blueAccent,
                          extensions: ['png', 'jpg', 'jpeg'],
                        ),
                        const SizedBox(width: 16),
                        _buildCategoryCard(
                          title: 'Text File',
                          icon: Icons.description,
                          color: Colors.green,
                          extensions: ['txt', 'md'],
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<String> extensions,
  }) {
    return SizedBox(
      width: 180,
      height: 140,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _pickFile(extensions),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 36),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  extensions.map((e) => '.$e').join(', '),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
