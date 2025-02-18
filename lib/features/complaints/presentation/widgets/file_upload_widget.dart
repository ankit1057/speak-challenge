import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileUploadWidget extends StatelessWidget {
  final List<File> selectedFiles;
  final Function(List<File>) onFilesSelected;

  const FileUploadWidget({
    super.key,
    required this.selectedFiles,
    required this.onFilesSelected,
  });

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
      );

      if (result != null) {
        final files = result.paths
            .where((path) => path != null)
            .map((path) => File(path!))
            .toList();
        onFilesSelected(files);
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              if (selectedFiles.isEmpty)
                _buildEmptyState(context)
              else
                _buildFileList(context),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickFiles,
                icon: const FaIcon(FontAwesomeIcons.plus, size: 16),
                label: Text(selectedFiles.isEmpty ? 'Add Files' : 'Add More Files'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        const FaIcon(
          FontAwesomeIcons.fileCirclePlus,
          size: 48,
          color: Colors.grey,
        ),
        const SizedBox(height: 16),
        Text(
          'Add supporting documents',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Accepted formats: JPG, PNG, PDF, DOC',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildFileList(BuildContext context) {
    return Column(
      children: [
        ...selectedFiles.map((file) => _buildFileItem(context, file)),
      ],
    );
  }

  Widget _buildFileItem(BuildContext context, File file) {
    final fileName = file.path.split('/').last;
    final extension = fileName.split('.').last.toLowerCase();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FaIcon(
            _getFileIcon(extension),
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          fileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark, size: 16),
          onPressed: () {
            onFilesSelected(
              selectedFiles.where((f) => f.path != file.path).toList(),
            );
          },
        ),
      ),
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return FontAwesomeIcons.fileImage;
      case 'pdf':
        return FontAwesomeIcons.filePdf;
      case 'doc':
      case 'docx':
        return FontAwesomeIcons.fileWord;
      default:
        return FontAwesomeIcons.file;
    }
  }
} 