import 'package:b_potash/core/exported_files/exported_file.dart';
import 'package:b_potash/features/common/views/widgets/app_bar_back_button.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.isLeading = true,
    required this.title,
    this.subtitle,
    this.onTapBack,
    this.leadingWidget,
    this.rightWidget,
    this.translateTitle = false,
    this.translateSubtitle = false,
  });

  final bool isLeading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTapBack;
  final Widget? leadingWidget;
  final Widget? rightWidget;
  final bool translateTitle;
  final bool translateSubtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      title: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLeading == false && leadingWidget != null) leadingWidget!,
            if (isLeading) _buildBackButton(),
            if (isLeading == true && leadingWidget == null)
              const ResponsiveSpace(25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveText(
                    text: title,
                    translate: translateTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryTxtColor,
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    ResponsiveSpace(3),
                    ResponsiveText(
                      text: subtitle!,
                      translate: translateSubtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryTxtColor,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ],
              ),
            ),
            if (isLeading) const ResponsiveSpace(24),
            if (rightWidget != null) rightWidget!,
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return AppBarBackButton(onTapBack: onTapBack);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
