import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_codebase/core/helpers/responsive/screen_size.dart';

class ResponsiveInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;

  final bool obscureText;
  final bool isNumber;
  final bool isReadOnly;
  final bool autoFocus;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderRadius;
  final double? borderWidth;

  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  const ResponsiveInputField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.isNumber = false,
    this.isReadOnly = false,
    this.autoFocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius,
    this.borderWidth,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
  });

  @override
  State<ResponsiveInputField> createState() => _ResponsiveInputFieldState();
}

class _ResponsiveInputFieldState extends State<ResponsiveInputField> {
  late final ValueNotifier<bool> _obscureNotifier;

  @override
  void initState() {
    super.initState();
    _obscureNotifier = ValueNotifier(widget.obscureText);
  }

  @override
  void dispose() {
    _obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureNotifier,
      builder: (context, isObscure, _) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          obscureText: isObscure,
          readOnly: widget.isReadOnly,
          autofocus: widget.autoFocus,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,

          keyboardType: widget.isNumber
              ? TextInputType.number
              : widget.keyboardType ?? TextInputType.text,

          inputFormatters: widget.isNumber
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,

          style:
              widget.textStyle ??
              GoogleFonts.poppins(
                fontSize: ScreenSize.setSp(14),
                color: const Color(0xFF6B6B6B),
                fontWeight: FontWeight.w500,
              ),

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: ScreenSize.setHeight(16),
              horizontal: ScreenSize.setWidth(12),
            ),
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle:
                widget.hintStyle ??
                GoogleFonts.poppins(
                  fontSize: ScreenSize.setSp(14),
                  color: const Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w400,
                ),
            labelStyle:
                widget.labelStyle ??
                GoogleFonts.poppins(
                  fontSize: ScreenSize.setSp(14),
                  color: Colors.grey.shade700,
                ),
            border: _outlineInputBorder(
              //  color: widget.borderColor ?? Colors.grey.withValues(alpha: 0.3),
              color: Colors.transparent,
            ),
            enabledBorder: _outlineInputBorder(
              // color: widget.borderColor ?? Colors.grey.withValues(alpha: 0.3),
              color: Colors.transparent,
            ),
            focusedBorder: _outlineInputBorder(
              // color: widget.focusedBorderColor ?? const Color(0xFF4A8CA5),
              color: Colors.transparent,
              borderWidth: 3,
            ),
            errorBorder: _outlineInputBorder(
              //  color: widget.errorBorderColor ?? Colors.red,
              color: Colors.transparent,
            ),
            disabledBorder: _outlineInputBorder(
              //  color: Colors.grey.withValues(alpha: 0.2),
              color: Colors.transparent,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF6B6B6B),
                    ),
                    onPressed: () {
                      _obscureNotifier.value = !_obscureNotifier.value;
                    },
                  )
                : widget.suffixIcon,
            filled: true,
            fillColor: widget.fillColor ?? Color(0xFFF6F8FA),
          ),
        );
      },
    );
  }

  OutlineInputBorder _outlineInputBorder({
    required Color color,
    double? borderWidth,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        ScreenSize.setWidth(widget.borderRadius ?? 10),
      ),
      borderSide: BorderSide(
        width: widget.borderWidth ?? borderWidth ?? ScreenSize.setWidth(1.2),
        color: color,
      ),
    );
  }
}
