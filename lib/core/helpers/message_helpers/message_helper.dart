import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';
import 'package:b_potash/core/wrappers/responsive_container.dart';
import 'package:b_potash/core/wrappers/responsive_icon.dart';
import 'package:b_potash/core/wrappers/responsive_space.dart';
import 'package:b_potash/core/wrappers/responsive_text.dart';

enum AppSnackPosition { top, center, bottom }

class MessageHelper {
  static final MessageHelper _instance = MessageHelper._internal();
  MessageHelper._internal();
  factory MessageHelper() => _instance;

  void showWarning({
    required String title,
    required String message,
    AppSnackPosition position = AppSnackPosition.bottom,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.warning_amber_rounded,
      position: position,
    );
  }

  void showAlert({
    required String title,
    required String message,
    AppSnackPosition position = AppSnackPosition.bottom,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.primaryColor,
      icon: Icons.notifications_active_outlined,
      position: position,
    );
  }

  void _showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required AppSnackPosition position,
  }) {
    final context = Get.context;
    if (context == null) return;

    final textTheme = Theme.of(context).textTheme;
    final screenWidth = ScreenSize.screenWidth;
    final horizontalPadding = screenWidth * 0.05;

    double bottomMargin = 20;
    double topMargin = 0;
    Alignment alignment = Alignment.bottomCenter;

    switch (position) {
      case AppSnackPosition.top:
        alignment = Alignment.topCenter;
        topMargin = 40;
        bottomMargin = 0;
        break;
      case AppSnackPosition.center:
        alignment = Alignment.center;
        bottomMargin = 0;
        break;
      case AppSnackPosition.bottom:
        alignment = Alignment.bottomCenter;
        bottomMargin = 20;
        break;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: bottomMargin,
        top: topMargin,
      ),
      content: Align(
        alignment: alignment,
        child: ResponsiveContainer(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveIcon(icon: icon, color: Colors.white, size: 26),
              const ResponsiveSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ResponsiveText(
                      text: title,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    const ResponsiveSpace(4),
                    Text(
                      message,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
