import 'package:flutter/material.dart';

import 'package:flutter_codebase/core/helpers/responsive/screen_size.dart';
import 'package:flutter_codebase/core/themes/colors/app_colors.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DottedLine({
    super.key,
    this.height = 2,
    this.color = AppColors.primaryColor,
    this.dashWidth = 6,
    this.dashSpace = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: ScreenSize.setHeight(height),
      child: CustomPaint(
        painter: _DottedLinePainter(
          color: color,
          dashWidth: ScreenSize.setWidth(dashWidth),
          dashSpace: ScreenSize.setWidth(dashSpace),
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  _DottedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

