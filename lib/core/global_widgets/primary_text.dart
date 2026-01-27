import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;

  const PrimaryText(String s, {
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
        height: height,
      ),
    );
    return textWidget;
  }
}
