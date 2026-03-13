import '../../../../core/exported_files/exported_file.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    super.key,
    this.message,
    this.icon,
    this.height = 200,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 12,
    this.borderColor,
    this.textStyle,
    this.iconSize = 48,
    this.iconColor,
  });

  final String? message;
  final IconData? icon;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ResponsiveContainer(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(width: 2, color: borderColor ?? AppColors.primaryColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ResponsiveIcon(
              icon: icon ?? Icons.inbox_rounded,
              size: iconSize,
              color: iconColor ?? AppColors.whiteColor,
            ),
            const SizedBox(height: 12),
            ResponsiveText(
             text:  message ?? "Data Not Found!",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}


