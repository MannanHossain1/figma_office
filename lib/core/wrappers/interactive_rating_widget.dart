import '../exported_files/exported_file.dart';

/// A reusable interactive rating widget that displays stars which can be clicked to change rating.
/// Shows an update button when the rating changes from the initial value.
class InteractiveRatingWidget extends StatelessWidget {
  final int initialRating;
  final RxInt selectedRating;
  final Function(int rating) onRatingChanged;
  final VoidCallback? onUpdatePressed;
  final String updateButtonLabel;
  final bool showUpdateButton;
  final MainAxisAlignment starsAlignment;

  const InteractiveRatingWidget({
    super.key,
    required this.initialRating,
    required this.selectedRating,
    required this.onRatingChanged,
    this.onUpdatePressed,
    required this.updateButtonLabel,
    this.showUpdateButton = true,
    this.starsAlignment = MainAxisAlignment.start,
  });

  bool get hasRatingChanged => selectedRating.value != initialRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: starsAlignment,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  onRatingChanged(index + 1);
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: index < 4 ? 20 : 0),
                  child: ResponsiveImage(
                    path: index < selectedRating.value
                        ? IconsAssetsPaths.starFill
                        : IconsAssetsPaths.star,
                    width: 32,
                    height: 32,
                    color: index < selectedRating.value
                        ? Colors.yellow[700]
                        : AppColors.greyColor,
                  ),
                ),
              );
            }),
          ),
        ),
        if (showUpdateButton)
          Obx(
            () => hasRatingChanged && onUpdatePressed != null
                ? Column(
                    children: [
                      ResponsiveSpace(16),
                      ResponsiveButton(
                        title: updateButtonLabel,
                        onTap: onUpdatePressed!,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }
}
