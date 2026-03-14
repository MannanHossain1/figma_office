import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_codebase/core/helpers/responsive/screen_size.dart';

class ResponsiveImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BoxFit fit;
  final BoxShape shape;
  final double borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? color;

  const ResponsiveImage({
    super.key,
    required this.path,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.borderRadius = 0.0,
    this.borderRadiusGeometry,
    this.color,
  }) : assert(
         borderRadius == 0.0 || borderRadiusGeometry == null,
         'You cannot use both borderRadius and borderRadiusGeometry at the same time.\n'
         'borderRadiusGeometry will override borderRadius.',
       );

  bool get _isNetwork => path.startsWith('http');
  bool get _isSVG => path.toLowerCase().endsWith('.svg');

  bool get _isFile {
    try {
      return File(path).existsSync();
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (_isSVG) {
      if (_isNetwork) {
        imageWidget = SvgPicture.network(
          path,
          width: ScreenSize.setWidth(width),
          height: ScreenSize.setHeight(height),
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
          placeholderBuilder: (context) => Center(
            child: SizedBox(
              width: ScreenSize.setWidth(24),
              height: ScreenSize.setHeight(24),
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      } else if (_isFile) {
        imageWidget = SvgPicture.file(
          File(path),
          width: ScreenSize.setWidth(width),
          height: ScreenSize.setHeight(height),
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      } else {
        imageWidget = SvgPicture.asset(
          path,
          width: ScreenSize.setWidth(width),
          height: ScreenSize.setHeight(height),
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      }
    } else {
      if (_isNetwork) {
        imageWidget = CachedNetworkImage(
          imageUrl: path,
          width: ScreenSize.setWidth(width),
          height: ScreenSize.setHeight(height),
          fit: fit,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: ScreenSize.setWidth(24),
              height: ScreenSize.setHeight(24),
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.broken_image,
            size: ScreenSize.setWidth(width * 0.5),
            color: Colors.grey,
          ),
        );
      } else if (_isFile) {
        imageWidget = Image.file(
          File(path),
          width: ScreenSize.setWidth(width),
          height: ScreenSize.setHeight(height),
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.broken_image,
            size: ScreenSize.setWidth(width * 0.5),
            color: Colors.grey,
          ),
        );
      } else {
        imageWidget = Image.asset(
          path,
          width: ScreenSize.setWidth(width),
          height: ScreenSize.setHeight(height),
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.broken_image,
            size: ScreenSize.setWidth(width * 0.5),
            color: Colors.grey,
          ),
        );
      }
    }

    if (width == height) {
      imageWidget = SizedBox.square(
        dimension: ScreenSize.setWidth(width),
        child: imageWidget,
      );
    }

    if (shape == BoxShape.circle) {
      return ClipOval(child: imageWidget);
    } else if (borderRadius > 0 || borderRadiusGeometry != null) {
      return ClipRRect(
        borderRadius:
            borderRadiusGeometry ?? BorderRadius.circular(borderRadius),
        child: imageWidget,
      );
    } else {
      return imageWidget;
    }
  }
}
