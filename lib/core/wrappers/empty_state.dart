import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_codebase/core/helpers/responsive/screen_size.dart';

/// Empty state widget for lists/screens.
class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onRetry;
  final double titleSize;

  const EmptyState({
    super.key,
    this.title = 'EMPTY!',
    this.subtitle = 'No data found',
    this.buttonText = 'Try again',
    this.onRetry,
    this.titleSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.setWidth(24),
          vertical: ScreenSize.setHeight(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: ScreenSize.setSp(titleSize),
                fontWeight: FontWeight.w700,
                height: 0.9,
                color: const Color(0xFF0F172A),
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    offset: const Offset(0, 8),
                    blurRadius: 18,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ScreenSize.setHeight(8)),
            Text(
              subtitle.toUpperCase(),
              style: GoogleFonts.openSans(
                fontSize: ScreenSize.setSp(14),
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
                color: const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ScreenSize.setHeight(24)),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.setWidth(32),
                  vertical: ScreenSize.setHeight(14),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenSize.setWidth(12)),
                ),
                elevation: 8,
                shadowColor: Colors.black38,
                backgroundColor: const Color(0xFF0F172A),
                disabledBackgroundColor: const Color(0xFF0F172A),
                disabledForegroundColor: Colors.white,
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.poppins(
                  fontSize: ScreenSize.setSp(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
