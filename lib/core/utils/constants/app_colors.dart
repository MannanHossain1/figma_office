import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF072C52);
  static Color secondary = Color(0xFFEFF7FF);
  static Color secondaryBottomNavbar = Color(0xFFF5EDE0);

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xFFEFF7FF),Color(0xFFFFFAFA)],
  );

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF1E1E24,);
  static const Color textThird = Color(0xFF565656);
  static const Color textBlue = Color(0xFF2196F3);
  static const Color textBlueE0 = Color(0xFF4DAEE0);
  static const Color textYellow = Color(0xffFFAB4C);
  static const Color textGrey = Color(0xFF94A3B8);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color blackText = Color(0xff403326);

}
