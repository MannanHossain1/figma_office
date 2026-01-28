import 'package:b_potash/core/global_widgets/custom_text.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';


class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: isOutlined
              ? AppColors.primary
              : AppColors.textSecondary.withValues(alpha: .04),
          foregroundColor: AppColors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: isOutlined
                ? BorderSide(color: AppColors.primary)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: CustomText(
          text: text,
          fontSize: 16,
          fontWeight: .w700,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
