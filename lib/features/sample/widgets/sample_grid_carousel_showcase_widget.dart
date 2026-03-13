import '../../../core/exported_files/exported_file.dart';
import 'sample_section_title.dart';

class SampleGridCarouselShowcaseWidget extends StatelessWidget {
  const SampleGridCarouselShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SampleSectionTitle(title: 'Grid + Carousel'),
        ResponsiveSizedBox(
          height: 180,
          child: ResponsiveGridView(
            itemCount: 4,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ResponsiveContainer(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? AppColors.primaryColor.withValues(alpha: 0.12)
                      : AppColors.secondaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: ResponsiveText(
                  text: 'Item ${index + 1}',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
        const ResponsiveSpace(12),
        const AppCarouselSlider(
          imageUrls: [
            'https://picsum.photos/900/400?1',
            'https://picsum.photos/900/400?2',
            'https://picsum.photos/900/400?3',
          ],
          height: 170,
        ),
      ],
    );
  }
}
