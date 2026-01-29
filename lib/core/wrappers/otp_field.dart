import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';
import 'package:b_potash/core/themes/colors/app_colors.dart';

/// OTP input field wrapper.
class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.otpController,
    this.length = 4,
    this.fieldWidth,
    this.fieldHeight,
    this.borderRadius,
    this.spaceBetween,
    this.activeColor,
    this.inactiveColor,
    this.selectedColor,
    this.fillColor,
    this.selectedFillColor,
    this.activeFillColor,
    this.inactiveFillColor,
    this.backgroundColor,
    this.onCompleted,
    this.validator,
    this.keyboardType = TextInputType.number,
    this.autoDisposeControllers = false,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController otpController;
  final int length;
  final double? fieldWidth;
  final double? fieldHeight;
  final double? borderRadius;
  final double? spaceBetween;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? selectedColor;
  final Color? fillColor;
  final Color? selectedFillColor;
  final Color? activeFillColor;
  final Color? inactiveFillColor;
  final Color? backgroundColor;
  final Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool autoDisposeControllers;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final double defaultFieldWidth = fieldWidth ?? 55;
    final double defaultFieldHeight = fieldHeight ?? 55;
    final double defaultRadius = borderRadius ?? 16;
    final double defaultSpace = spaceBetween ?? 24;

    return SizedBox(
      width: ScreenSize.setWidth((defaultFieldWidth + defaultSpace) * length),
      child: PinCodeTextField(
        autoDisposeControllers: autoDisposeControllers,
        length: length,
        obscureText: false,
        animationType: AnimationType.fade,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        controller: otpController,
        appContext: context,
        onCompleted: onCompleted,
        validator: validator,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: backgroundColor ?? Colors.transparent,
        enableActiveFill: true,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: ScreenSize.setHeight(defaultFieldHeight),
          fieldWidth: ScreenSize.setWidth(defaultFieldWidth),
          borderRadius: BorderRadius.circular(
            ScreenSize.setWidth(defaultRadius),
          ),
          activeColor: activeColor ?? AppColors.primaryColor,
          inactiveColor: inactiveColor ?? Colors.grey,
          selectedColor: selectedColor ?? AppColors.primaryColor,
          activeFillColor: activeFillColor ?? Colors.transparent,
          inactiveFillColor: inactiveFillColor ?? Colors.transparent,
          selectedFillColor: selectedFillColor ?? const Color(0xFFFFFFFF),
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

