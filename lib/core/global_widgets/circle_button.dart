import 'package:b_potash/core/global_widgets/primary_text.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleButton extends StatelessWidget {
  final String iconImage;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CircleButton({
    super.key,
    required this.iconImage,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: isOutlined ? Colors.white : AppColors.primary,
          foregroundColor: AppColors.textWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: isOutlined
                ? BorderSide(color: AppColors.primary)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: SvgPicture.asset(iconImage,alignment: .center,fit: .contain,)
      ),
    );
  }
}
