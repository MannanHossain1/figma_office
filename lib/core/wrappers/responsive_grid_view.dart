import 'package:flutter/material.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';

/// Responsive `GridView.builder` helper.
class ResponsiveGridView extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double heightFactor;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final IndexedWidgetBuilder itemBuilder;
  final bool? primary;
  final double? minItemHeight;

  const ResponsiveGridView({
    super.key,
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.heightFactor = 1.27,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.primary,
    this.minItemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double scaledCrossAxisSpacing = ScreenSize.setWidth(
          crossAxisSpacing,
        );
        final double itemWidth =
            (width - (scaledCrossAxisSpacing * (crossAxisCount - 1))) /
            crossAxisCount;
        double itemHeight = itemWidth * heightFactor;

        // Ensure minimum height if specified
        if (minItemHeight != null && itemHeight < minItemHeight!) {
          itemHeight = minItemHeight!;
        }

        // Add small buffer to prevent sub-pixel overflow issues
        itemHeight = (itemHeight + 0.5).floorToDouble();

        final double aspectRatio = itemWidth / itemHeight;
        return GridView.builder(
          primary: primary,
          itemCount: itemCount,
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding ?? EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: scaledCrossAxisSpacing,
            mainAxisSpacing: ScreenSize.setHeight(mainAxisSpacing),
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}

