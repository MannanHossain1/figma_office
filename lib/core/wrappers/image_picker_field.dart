import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/services/photo_picker_service/photo_picker_service.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';
import 'package:b_potash/core/wrappers/responsive_image.dart';

/// Image picker field widget (shows dotted placeholder and optional fallback).
class ImagePickerField extends StatefulWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final double borderRadius;
  final Function(File)? onImagePicked;

  final String? fallbackImagePath;
  final double? fallbackImageHeight;
  final double? fallbackImageWidth;

  const ImagePickerField({
    super.key,
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
    this.borderRadius = 0,
    this.onImagePicked,
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
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final ValueNotifier<File?> _selectedImage = ValueNotifier<File?>(null);

  Future<void> _pickImage() async {
    final photoPicker = Get.find<PhotoPickerService>();
    final file = await photoPicker.pickImageDialog(context);

    if (file != null) {
      _selectedImage.value = file;
      widget.onImagePicked?.call(file);
    }
  }

  @override
  void dispose() {
    _selectedImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: ValueListenableBuilder<File?>(
        valueListenable: _selectedImage,
        builder: (context, file, _) {
          return _buildFallbackOrIcon();
        },
      ),
    );
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
    }

    return DottedBorder(
      color: Colors.grey.shade300,
      strokeWidth: ScreenSize.setWidth(3),
      dashPattern: [ScreenSize.setWidth(6), ScreenSize.setWidth(4)],
      borderType:
          widget.shape == BoxShape.circle ? BorderType.Circle : BorderType.RRect,
      radius: Radius.circular(ScreenSize.setWidth(15)),
      child: Container(
        width: ScreenSize.setWidth(widget.width),
        height: ScreenSize.setHeight(widget.height),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.grey.shade600,
                size: ScreenSize.setSp(20),
              ),
              SizedBox(width: ScreenSize.setWidth(8)),
              Text(
                'Add image (optional)',
                style: TextStyle(
                  color: AppColors.secondaryTxtColor,
                  fontSize: ScreenSize.setSp(14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

