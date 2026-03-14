import '../../../../core/exported_files/exported_file.dart';
import 'sample_section_title.dart';

class SampleContentShowcaseWidget extends StatefulWidget {
  const SampleContentShowcaseWidget({super.key});

  @override
  State<SampleContentShowcaseWidget> createState() =>
      _SampleContentShowcaseWidgetState();
}

class _SampleContentShowcaseWidgetState
    extends State<SampleContentShowcaseWidget> {
  final RxInt _selectedRating = 3.obs;

  @override
  void dispose() {
    _selectedRating.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SampleSectionTitle(title: 'Expandable + Dotted Divider + Rating'),
        const ExpandableText(
          text:
              'This wrapper helps you keep long content compact. Tap See More to expand and See Less to collapse while preserving your custom text style.',
          maxLines: 2,
          fontSize: 14,
        ),
        const ResponsiveSpace(12),
        const DottedLine(),
        const ResponsiveSpace(12),
        InteractiveRatingWidget(
          initialRating: 3,
          selectedRating: _selectedRating,
          updateButtonLabel: 'Update Rating',
          onRatingChanged: (rating) {
            _selectedRating.value = rating;
          },
          onUpdatePressed: () {
            CustomLoader.showInfo('Rating updated to ${_selectedRating.value}');
          },
        ),
      ],
    );
  }
}
