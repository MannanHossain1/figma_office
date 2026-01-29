import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';

/// Controlled, responsive switch widget.
///
/// Production pattern: the parent owns state (`value`) and updates it via
/// `onChanged`.
class ResponsiveSwitch extends StatelessWidget {
  const ResponsiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 46,
    this.height = 28,
    this.padding = 2,
    this.knobSize = 20,
    this.borderRadius = 33,
    this.activeColor,
    this.inactiveColor,
    this.knobColor = AppColors.whiteColor,
    this.duration = const Duration(milliseconds: 250),
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  /// All sizes are "design units" scaled by `ScreenSize`.
  final double width;
  final double height;
  final double padding;
  final double knobSize;
  final double borderRadius;

  final Color? activeColor;
  final Color? inactiveColor;
  final Color knobColor;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final w = ScreenSize.setWidth(width);
    final h = ScreenSize.setHeight(height);
    final p = ScreenSize.setWidth(padding);
    final k = ScreenSize.setWidth(knobSize);
    final r = ScreenSize.setWidth(borderRadius);

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeInOut,
        width: w,
        height: h,
        padding: EdgeInsets.all(p),
        decoration: BoxDecoration(
          color: value
              ? (activeColor ?? AppColors.primaryColor)
              : (inactiveColor ?? AppColors.greyColor),
          borderRadius: BorderRadius.circular(r),
        ),
        child: AnimatedAlign(
          duration: duration,
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: k,
            width: k,
            decoration: BoxDecoration(color: knobColor, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}

/// Convenience adapter for GetX apps using `RxBool`.
class RxResponsiveSwitch extends StatelessWidget {
  const RxResponsiveSwitch({
    super.key,
    required this.value,
    this.width = 46,
    this.height = 28,
    this.padding = 2,
    this.knobSize = 20,
    this.borderRadius = 33,
    this.activeColor,
    this.inactiveColor,
    this.knobColor = AppColors.whiteColor,
    this.duration = const Duration(milliseconds: 250),
  });

  final RxBool value;
  final double width;
  final double height;
  final double padding;
  final double knobSize;
  final double borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color knobColor;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ResponsiveSwitch(
        value: value.value,
        onChanged: (v) => value.value = v,
        width: width,
        height: height,
        padding: padding,
        knobSize: knobSize,
        borderRadius: borderRadius,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        knobColor: knobColor,
        duration: duration,
      ),
    );
  }
}
