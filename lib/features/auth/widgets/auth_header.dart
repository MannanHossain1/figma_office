import '../../../core/exported_files/exported_file.dart';
class AuthHeader extends StatelessWidget {
  final String?title;
  final String? subtitle;
  const AuthHeader ({super.key,
    this.title,
    this.subtitle,
   });
  @override
  Widget build(BuildContext context) {
    return Column(
 crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          text: title??'',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ResponsiveText(
          text: subtitle ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        )
      ],
    );
  }
}
