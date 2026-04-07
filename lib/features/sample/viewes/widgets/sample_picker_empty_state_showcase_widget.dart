import '../../../../core/exported_files/exported_file.dart';
import 'sample_section_title.dart';
class SamplePickerEmptyStateShowcaseWidget extends StatelessWidget {
  const SamplePickerEmptyStateShowcaseWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SampleSectionTitle(title: 'Image Picker + Empty State'),
        RImagePicker(width: double.infinity, height: 50),
        const ResponsiveSpace(14),
        const ResponsiveSizedBox(
          height: 220,
          child: EmptyState(
            title: 'DEMO',
            subtitle: 'All custom wrappers are ready to reuse',
            buttonText: 'Refresh',
          ),
        ),
      ],
    );
  }
}
