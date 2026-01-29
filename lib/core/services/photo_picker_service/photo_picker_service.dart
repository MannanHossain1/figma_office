import 'dart:io';

import 'package:b_potash/core/exported_files/exported_file.dart';
import 'package:image_picker/image_picker.dart';

/// Centralized image picking (camera/gallery) with a simple dialog UI.
class PhotoPickerService extends GetxService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromGallery() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery);
    return xFile == null ? null : File(xFile.path);
  }

  Future<File?> pickFromCamera() async {
    final xFile = await _picker.pickImage(source: ImageSource.camera);
    return xFile == null ? null : File(xFile.path);
  }

  Future<File?> pickImageDialog(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Gallery'),
                onTap: () async {
                  final file = await pickFromGallery();
                  if (ctx.mounted) Navigator.of(ctx).pop(file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Camera'),
                onTap: () async {
                  final file = await pickFromCamera();
                  if (ctx.mounted) Navigator.of(ctx).pop(file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.of(ctx).pop(null),
              ),
            ],
          ),
        );
      },
    );
  }
}

