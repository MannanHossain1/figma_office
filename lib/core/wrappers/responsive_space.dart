import 'package:flutter/material.dart';

import 'package:b_potash/core/helpers/responsive/screen_size.dart';

class ResponsiveSpace extends StatelessWidget {
  final double value;

  const ResponsiveSpace(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<Flex>();
    if (parent == null) {
      return SizedBox(
        width: ScreenSize.setWidth(value),
        height: ScreenSize.setHeight(value),
      );
    }

    if (parent.direction == Axis.horizontal) {
      return SizedBox(width: ScreenSize.setWidth(value));
    } else {
      return SizedBox(height: ScreenSize.setHeight(value));
    }
  }
}
