import 'package:flutter/material.dart';

import 'package:flutter_codebase/core/themes/colors/app_colors.dart';
import 'package:flutter_codebase/core/wrappers/responsive_button.dart';

class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.title,
    required this.onTap,
    this.borderColor,
    this.titleColor,
  });

  final String title;
  final VoidCallback onTap;
  final Color? borderColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return ResponsiveButton(
      title: title,
      onTap: onTap,
      backgroundColor: Colors.transparent,
      borderWidth: 2,
      borderColor: borderColor ?? AppColors.primaryColor,
      titleColor: titleColor ?? AppColors.primaryColor,
    );
  }
}
