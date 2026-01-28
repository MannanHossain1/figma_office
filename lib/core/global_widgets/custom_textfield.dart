import 'package:b_potash/core/global_widgets/custom_text.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final Color? fillColor;
  final String? hintText;
  final String headertext;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isObscure;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final TextEditingController? textController;
  final String? Function(String?)? validator;

  const CustomTextfield({
    super.key,
    this.fillColor,
    required this.hintText,
    this.hintTextColor,
    required this.isObscure,
    required this.headertext,
    this.textColor,
    this.prefixIcon,
    this.suffixWidget,
    this.textController,
    this.validator,
  });

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: .circular(15),
      borderSide: BorderSide(
        color: AppColors.textSecondary.withValues(alpha: .4),
        width: 1,
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        color: AppColors.textSecondary.withValues(alpha: .34),
        fontSize: 14,
        fontWeight: .w300,
      ),
      suffixIcon: suffixWidget,
      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      disabledBorder: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      focusedErrorBorder: _outlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CustomText(
            text: headertext,
            color: AppColors.textThird,
            fontSize: 16,
            fontWeight: .w500,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: textController,
            obscureText: isObscure!,
            decoration: _inputDecoration(),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
