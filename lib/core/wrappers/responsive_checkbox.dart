import 'package:flutter/material.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';

class ResponsiveCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final double? size;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const ResponsiveCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.size,
    this.shape,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: size != null ? ScreenSize.setWidth(size!) : null,
      height: size != null ? ScreenSize.setHeight(size!) : null,
      child: Transform.scale(
        scale: size != null ? size! / 24 : 1.0,
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppColors.primaryColor,
          checkColor: checkColor ?? Colors.white,
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenSize.setWidth(4)),
              ),
        ),
      ),
    );
  }
}
