import 'package:flutter/material.dart';

import 'package:flutter_codebase/core/helpers/responsive/screen_size.dart';
import 'package:flutter_codebase/core/themes/colors/app_colors.dart';
import 'package:flutter_codebase/core/wrappers/responsive_space.dart';
import 'package:flutter_codebase/core/wrappers/responsive_text.dart';

/// Expandable text with "See More/Less".
class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.color,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  final ValueNotifier<bool> isExpanded = ValueNotifier(false);
  final ValueNotifier<bool> showSeeMore = ValueNotifier(false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkTextOverflow();
  }

  void _checkTextOverflow() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.color ?? AppColors.primaryTxtColor,
        ),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    showSeeMore.value = textPainter.didExceedMaxLines;
  }

  @override
  void dispose() {
    isExpanded.dispose();
    showSeeMore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return ValueListenableBuilder<bool>(
      valueListenable: showSeeMore,
      builder: (context, hasMore, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isExpanded,
              builder: (context, expanded, child) {
                return ResponsiveText(
                  text: widget.text,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: widget.color ?? AppColors.primaryTxtColor,
                  maxLines: expanded ? null : widget.maxLines,
                  overflow: TextOverflow.fade,
                );
              },
            ),
            if (hasMore) ...[
              const ResponsiveSpace(4),
              ValueListenableBuilder<bool>(
                valueListenable: isExpanded,
                builder: (context, expanded, child) {
                  return GestureDetector(
                    onTap: () => isExpanded.value = !expanded,
                    child: ResponsiveText(
                      text: expanded ? "See Less..." : "See More...",
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
