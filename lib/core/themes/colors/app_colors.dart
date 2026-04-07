import 'package:flutter/material.dart';

class AppColors {
  AppColors.internal();

  static const Color primaryColor = Color(0xff00695C);
  static const Color secondaryColor = Color(0xFFB3A28A);
  static const Color screen = Color(0xFFB3A28A);
  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color appBarBackgroundColor = Color(0xFFFFFFFF);
  static const Color outerCardColor = Color(0xFFECF3F6);
  static const Color innerCardColor = Color(0xFFF5F9FF);
  static const Color cartImgBgColor = Color(0xFFEADFCD);
  static const Color primarySCBgColor = Color(0xFFFEF4E6);
  static const Color primaryTxtColor = Color(0xFF20222C);
  static const Color secondaryTxtColor = Color(0xFF818898);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color redColor = Color(0xFF891638);
  static const Color greyColor = Colors.grey;
  static const Color greenColor = Color(0xFF00CB72);
  static const Color orangeColor = Color(0xFFFF6900);
  static const Color shimmerContentColor = Colors.grey;
  static const Color blackColor = Color(0xFF000000);
  static final Color shimmerBaseColor = Colors.grey.shade300;
  static final Color shimmerHighlightColor = Colors.grey.shade100;
  static final Color cardBackground = Color(0XFFF6F8FA);
  static final Color primaryColor2 = Color(0XFFDEF1FC);
  static final Color blueAccentColor = Colors.blueAccent;
  static final Color tealColor = Colors.teal;
  static final Color amberColor = Colors.amber;

  static LinearGradient primaryGradientColor = LinearGradient(
    colors: [Color(0xFF4A8CA5), Color(0xFFC0C4C6)],
  );

  static LinearGradient primaryScreenBackgroundGradientColor = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
