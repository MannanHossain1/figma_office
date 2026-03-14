import '../../../../core/exported_files/exported_file.dart';

class SampleSectionTitle extends StatelessWidget {
  const SampleSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ResponsiveText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
      ),
    );
  }
}
