import 'package:flutter/material.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';

class ResponsiveSizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final VoidCallback? onTap;
  final Color? color;

  const ResponsiveSizedBox({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.child,
    this.alignment,
    this.constraints,
    this.onTap,
    this.color,
  });

  EdgeInsetsGeometry? _responsivePadding(EdgeInsetsGeometry? padding) {
    if (padding is EdgeInsets) {
      return EdgeInsets.only(
        left: ScreenSize.setWidth(padding.left),
        right: ScreenSize.setWidth(padding.right),
        top: ScreenSize.setHeight(padding.top),
        bottom: ScreenSize.setHeight(padding.bottom),
      );
    }
    return padding;
  }

  EdgeInsetsGeometry? _responsiveMargin(EdgeInsetsGeometry? margin) {
    if (margin is EdgeInsets) {
      return EdgeInsets.only(
        left: ScreenSize.setWidth(margin.left),
        right: ScreenSize.setWidth(margin.right),
        top: ScreenSize.setHeight(margin.top),
        bottom: ScreenSize.setHeight(margin.bottom),
      );
    }
    return margin;
  }

  @override
  Widget build(BuildContext context) {
    final Widget container = Container(
      width: width != null ? ScreenSize.setWidth(width!) : null,
      height: height != null ? ScreenSize.setHeight(height!) : null,
      padding: _responsivePadding(padding),
      margin: _responsiveMargin(margin),
      alignment: alignment,
      constraints: constraints,
      color: color,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: container);
    }

    return container;
  }
}
