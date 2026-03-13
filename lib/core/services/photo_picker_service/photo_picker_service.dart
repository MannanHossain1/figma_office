import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerService extends GetxService {
  final RxList<File> imageList = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  Future<File?> _pickImage({
    required ImageSource source,
    bool compress = true,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: compress ? 70 : 100,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        _addImageToList(file);
        return file;
      } else {
        Get.snackbar('No Image Selected', 'Please select an image.');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
      return null;
    }
  }

  Future<List<File>> pickMultipleImages({bool compress = true}) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: compress ? 70 : 100,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFiles.isEmpty) {
        Get.snackbar('No Images Selected', 'Please select at least one image.');
        return [];
      }

      final files = pickedFiles.map((file) => File(file.path)).toList();
      for (final file in files) {
        _addImageToList(file);
      }

      return files;
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick images: $e');
      return [];
    }
  }

  Future<File?> pickSingleImageFromGallery({bool compress = true}) async {
    return await _pickImage(source: ImageSource.gallery, compress: compress);
  }

  Future<File?> pickSingleImageFromCamera({bool compress = true}) async {
    return await _pickImage(source: ImageSource.camera, compress: compress);
  }

  Future<dynamic> pickImageDialog(
    BuildContext context, {
    bool allowMultiple = false,
  }) async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      // backgroundColor: AppLightColors.primarySCBgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.of(sheetContext).pop('gallery');
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.of(sheetContext).pop('camera');
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.red),
                title: const Text('Cancel'),
                onTap: () => Navigator.of(sheetContext).pop('cancel'),
              ),
            ],
          ),
        );
      },
    );

    if (result == 'gallery') {
      if (allowMultiple) {
        return await pickMultipleImages();
      } else {
        return await _pickImage(source: ImageSource.gallery);
      }
    } else if (result == 'camera') {
      final file = await _pickImage(source: ImageSource.camera);
      if (allowMultiple) {
        return file != null ? [file] : <File>[];
      } else {
        return file;
      }
    }

    return null;
  }

  void _addImageToList(File file) {
    if (!imageList.any((f) => f.path == file.path)) {
      imageList.add(file);
    }
  }

  void removeImage(File file) {
    imageList.removeWhere((f) => f.path == file.path);
  }

  void clearAllImages() {
    imageList.clear();
  }
}
