import '../exported_files/exported_file.dart';
import '../services/translator_services/translator_service.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;
  final VoidCallback? onTap;
  final bool translate;

  const ResponsiveText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
    this.height,
    this.onTap,
    this.translate = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!translate) {
      return _buildText(text);
    }

    final locale =
        Get.locale?.languageCode ??
        Localizations.localeOf(context).languageCode;
    final rxText = TranslatorService.instance.watchTranslated(text, locale);

    return Obx(() => _buildText(rxText.value));
  }

  Widget _buildText(String displayText) {
    final textWidget = Text(
      displayText,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Lusail',
        fontSize: ScreenSize.setSp(fontSize),
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing != null
            ? ScreenSize.setSp(letterSpacing!)
            : null,
        height: height,
      ),

      // -------If want to use custom font----------

      // style: TextStyle(
      //   fontFamily: 'Lusail',
      //   fontSize: ScreenSize.setSp(fontSize),
      //   fontWeight: fontWeight ?? FontWeight.normal,
      //   color: color ?? Colors.black,
      //   letterSpacing: letterSpacing != null
      //       ? ScreenSize.setSp(letterSpacing!)
      //       : null,
      //   height: height,
      // ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: textWidget);
    }

    return textWidget;
  }
}
