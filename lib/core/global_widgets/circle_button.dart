import 'package:flutter_codebase/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return GestureDetector(onTap: onPressed,
      child: Container(
        padding: .all(24),
        decoration: BoxDecoration(
          color: isOutlined
              ? Color(0xFFF9FAFB).withValues(alpha: .6)
              : AppColors.primary,
          shape: .circle,
        ),
        child: SvgPicture.asset(iconImage, height: 18),
      ),
    );

    // return SizedBox(
    //   // height: 60,
    //   width: 60,
    //   child: ElevatedButton(
    //     onPressed: onPressed,
    //     style: ElevatedButton.styleFrom(
    //       shadowColor: Colors.transparent,
    //       backgroundColor: isOutlined ?  : AppColors.primary,
    //       foregroundColor: AppColors.textWhite,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(100),

    //       ),
    //       elevation: 0,
    //     ),
    //     child: SvgPicture.asset(iconImage,height: 18,)
    //   ),
    // );
  }
}
