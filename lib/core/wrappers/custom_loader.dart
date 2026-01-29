import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';

/// Global loader & toast helper configured to match app theme.
class CustomLoader {
  CustomLoader._();

  /// Configure EasyLoading with custom styling
  static void configureLoader() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.clear
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.primaryColor
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..dismissOnTap = false
      ..userInteractions = false
      ..boxShadow = [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: ScreenSize.setWidth(10),
          offset: const Offset(0, 4),
        ),
      ];
  }

  /// Show loading indicator
  static void show({String? message}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.clear
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.primaryColor;

    EasyLoading.show(
      status: message ?? 'Loading...',
      maskType: EasyLoadingMaskType.clear,
    );
  }

  /// Hide loader
  static Future<void> dismiss() async {
    await EasyLoading.dismiss();
  }

  /// Show success message
  static void showSuccess(String message, {Duration? duration}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.none
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.primaryColor;

    EasyLoading.showSuccess(
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// Show error message
  static void showError(String message, {Duration? duration}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.none
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.redColor;

    EasyLoading.showError(
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// Show info message
  static void showInfo(String message, {Duration? duration}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.none
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.primaryColor;

    EasyLoading.showInfo(
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// Show warning message
  static void showWarning(String message, {Duration? duration}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.none
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.orangeColor;

    EasyLoading.showToast(
      message,
      duration: duration ?? const Duration(seconds: 2),
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }

  /// Show toast message
  static void showToast(
    String message, {
    Duration? duration,
    EasyLoadingToastPosition? position,
    Color? backgroundColor,
  }) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.none
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = backgroundColor ?? AppColors.primaryColor;

    EasyLoading.showToast(
      message,
      duration: duration ?? const Duration(seconds: 2),
      toastPosition: position ?? EasyLoadingToastPosition.bottom,
      dismissOnTap: true,
    );
  }

  /// Show progress with percentage
  static void showProgress(double progress, {String? message}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.clear
      ..textColor = Colors.white
      ..fontSize = ScreenSize.setSp(16)
      ..backgroundColor = AppColors.primaryColor;

    EasyLoading.showProgress(
      progress,
      status: message ?? '${(progress * 100).toInt()}%',
    );
  }
}
