import 'package:b_potash/core/global_widgets/primary_text.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const PrimaryButton({
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
          backgroundColor: isOutlined ? Colors.white : AppColors.primary,
          foregroundColor: AppColors.textWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutlined
                ? BorderSide(color: AppColors.primary)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(text, style: GoogleFonts.inter(color: AppColors.textWhite,height: 14,fontWeight: .w700),)
      ),
    );
  }
}
