import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_codebase/core/helpers/responsive/screen_size.dart';
import 'package:flutter_codebase/core/wrappers/responsive_container.dart';
import 'package:flutter_codebase/core/wrappers/responsive_image.dart';

/// Carousel slider wrapper for common app usage.
class AppCarouselSlider extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final bool showIndicators;
  final bool autoPlay;

  const AppCarouselSlider({
    super.key,
    required this.imageUrls,
    this.height = 200,
    this.showIndicators = true,
    this.autoPlay = true,
  });

  @override
  State<AppCarouselSlider> createState() => _AppCarouselSliderState();
}

class _AppCarouselSliderState extends State<AppCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return ResponsiveContainer(
        height: ScreenSize.setHeight(widget.height),
        color: Colors.grey.shade200,
        child: Center(
          child: Text(
            "No Image",
            style: TextStyle(
              fontSize: ScreenSize.setSp(14),
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = widget.imageUrls[index];
            return ResponsiveContainer(
              width: double.maxFinite,
              height: ScreenSize.setHeight(widget.height),
              child: ResponsiveImage(
                path: imageUrl,
                width: double.maxFinite,
                height: ScreenSize.setHeight(140),
                fit: BoxFit.cover,
                borderRadiusGeometry: BorderRadius.only(
                  topLeft: Radius.circular(ScreenSize.setWidth(8)),
                  topRight: Radius.circular(ScreenSize.setWidth(8)),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: ScreenSize.setHeight(widget.height),
            viewportFraction: 1.0,
            autoPlay: widget.autoPlay,
            autoPlayInterval: const Duration(seconds: 4),
          ),
        ),
      ],
    );
  }
}

