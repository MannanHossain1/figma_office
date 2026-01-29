import 'package:flutter/material.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';
import 'package:b_potash/core/wrappers/responsive_image.dart';
import 'package:b_potash/core/wrappers/responsive_space.dart';
import 'package:b_potash/core/wrappers/responsive_text.dart';

class ResponsiveButton extends StatelessWidget {
  const ResponsiveButton({
    super.key,
    this.title,
    this.onTap,
    this.height = 48,
    // this.borderRadius = 33,
    this.borderRadius = 16,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.width,
    this.titleColor,
    this.fontWeight,
    this.fontSize,
    this.isLoading = false,
    this.trailingIcon,
    this.leadingIcon,
    this.iconColor,
    this.iconHeight,
    this.iconWidth,
  }) : assert(
         (leadingIcon == null || trailingIcon == null),
         "You cannot provide both leadingIcon and trailingIcon. Use only one.",
       );

  final String? title;
  final VoidCallback? onTap;
  final double height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color? titleColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool isLoading;
  final String? trailingIcon;
  final String? leadingIcon;
  final Color? iconColor;
  final double? iconHeight;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: ScreenSize.setHeight(height),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenSize.setWidth(borderRadius),
          ),
          boxShadow: backgroundColor == Colors.transparent
              ? null
              : [
                  BoxShadow(
                    color: AppColors.greyColor.withValues(alpha: 0.2),
                    blurRadius: ScreenSize.setWidth(4),
                    spreadRadius: ScreenSize.setWidth(4),
                  ),
                ],
          color: backgroundColor ?? AppColors.primaryColor,
          border: Border.all(
            width: borderWidth ?? 1,
            // color: borderColor ?? AppColors.primaryColor,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                height: ScreenSize.setHeight(24),
                width: ScreenSize.setWidth(24),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ResponsiveImage(
                          path: leadingIcon!,
                          width: iconWidth ?? 22,
                          height: iconHeight ?? iconWidth ?? 22,
                          color: iconColor,
                        ),
                        if (title != null && title!.isNotEmpty)
                          const ResponsiveSpace(8),
                      ],
                    ),

                  if (title != null && title!.isNotEmpty)
                    ResponsiveText(
                      text: title!,
                      fontSize: fontSize ?? 15,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      color: titleColor ?? AppColors.whiteColor,
                    ),

                  if (trailingIcon != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null && title!.isNotEmpty)
                          const ResponsiveSpace(8),
                        ResponsiveImage(
                          path: trailingIcon!,
                          width: iconWidth ?? 22,
                          height: iconHeight ?? iconWidth ?? 22,
                          color: iconColor,
                        ),
                      ],
                    ),
                ],
              ),
      ),
    );
  }
}
