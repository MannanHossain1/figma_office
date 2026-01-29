import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;
  final VoidCallback? onTap;

  const ResponsiveText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: ScreenSize.setSp(fontSize),
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing != null
            ? ScreenSize.setSp(letterSpacing!)
            : null,
        height: height,
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: textWidget);
    }

    return textWidget;
  }
}
