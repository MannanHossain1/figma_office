import '../../../../core/exported_files/exported_file.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key, this.onTapBack});

  final VoidCallback? onTapBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapBack ?? Get.back(),
      child: ResponsiveContainer(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor.withValues(alpha: 0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 11),
        child: ResponsiveImage(
          path: IconsAssetsPaths.arrowBack,
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}
