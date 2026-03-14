import '../../../../core/exported_files/exported_file.dart';
import 'sample_section_title.dart';

class SampleProfileShowcaseWidget extends StatelessWidget {
  const SampleProfileShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SampleSectionTitle(title: 'Text + Container + Image'),
        ResponsiveContainer(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ResponsiveImage(
                path: ImageAssetsPaths.userProfile,
                width: 64,
                height: 64,
                shape: BoxShape.circle,
              ),
              const ResponsiveSpace(12),
              const Expanded(
                child: ResponsiveText(
                  text:
                      'Reusable profile tile built with ResponsiveContainer, ResponsiveImage, and ResponsiveText.',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTxtColor,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
