import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import '../exported_files/exported_file.dart';

class RImagePicker extends StatefulWidget {
  final String? title;
  final double width;
  final double height;
  final BoxShape shape;
  final double borderRadius;
  final Function(File)? onImagePicked;
  final Function(List<File>)? onMultipleImagesPicked;
  final bool allowMultiple;
  final bool isPreview;

  final String? fallbackImagePath;
  final double? fallbackImageHeight;
  final double? fallbackImageWidth;

  const RImagePicker({
    super.key,
    required this.width,
    required this.height,
    this.title,
    this.shape = BoxShape.rectangle,
    this.borderRadius = 0,
    this.onImagePicked,
    this.onMultipleImagesPicked,
    this.allowMultiple = false,
    this.isPreview = true,
    this.fallbackImagePath,
    this.fallbackImageHeight,
    this.fallbackImageWidth,
  }) : assert(
         (fallbackImagePath == null &&
                 fallbackImageHeight == null &&
                 fallbackImageWidth == null) ||
             (fallbackImagePath != null &&
                 fallbackImageHeight != null &&
                 fallbackImageWidth != null),
         'All fallback image properties (path, width, height) must be provided together.',
       );

  @override
  State<RImagePicker> createState() => _RImagePickerState();
}

class _RImagePickerState extends State<RImagePicker> {
  final ValueNotifier<List<File>> _selectedImages = ValueNotifier<List<File>>(
    [],
  );

  Future<void> _pickImage() async {
    final photoPicker = Get.find<PhotoPickerService>();
    final result = await photoPicker.pickImageDialog(
      context,
      allowMultiple: widget.allowMultiple,
    );

    if (result != null) {
      if (widget.allowMultiple && result is List<File>) {
        if (result.isNotEmpty) {
          _selectedImages.value = [..._selectedImages.value, ...result];
          widget.onMultipleImagesPicked?.call(_selectedImages.value);
        }
      } else if (result is File) {
        _selectedImages.value = [result];
        widget.onImagePicked?.call(result);
      }
    }
  }

  void _removeImage(int index) {
    final updated = List<File>.from(_selectedImages.value)..removeAt(index);
    _selectedImages.value = updated;
    widget.onMultipleImagesPicked?.call(updated);
  }

  void _clearImages() {
    _selectedImages.value = [];
    widget.onMultipleImagesPicked?.call([]);
  }

  @override
  void dispose() {
    _selectedImages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<File>>(
      valueListenable: _selectedImages,
      builder: (context, images, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(onTap: _pickImage, child: _buildPickerArea(images)),
            if (widget.isPreview && images.isNotEmpty) ...[
              ResponsiveSpace(8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.secondaryTxtColor.withValues(
                          alpha: 0.1,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.file(
                            images[index],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blackColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.close,
                                color: AppColors.secondaryTxtColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ResponsiveSpace(8),
              GestureDetector(
                onTap: _clearImages,
                child: ResponsiveText(
                  text: 'Cancel',
                  fontSize: 12,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildPickerArea(List<File> images) {
    return _buildFallbackOrIcon();
  }

  Widget _buildFallbackOrIcon() {
    if (widget.fallbackImagePath != null) {
      return Align(
        alignment: Alignment.center,
        child: ResponsiveImage(
          path: widget.fallbackImagePath!,
          width: widget.fallbackImageWidth!,
          height: widget.fallbackImageHeight!,
        ),
      );
    } else {
      return DottedBorder(
        color: Colors.grey.shade300,
        strokeWidth: 3,
        dashPattern: const [6, 4],
        borderType: widget.shape == BoxShape.circle
            ? BorderType.Circle
            : BorderType.RRect,
        radius: const Radius.circular(15),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                ResponsiveText(
                  text: widget.title ?? 'Add images (optional)',
                  color: AppColors.secondaryTxtColor,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
