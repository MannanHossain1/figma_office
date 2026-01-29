import 'package:b_potash/core/exported_files/exported_file.dart';

class AppThemes {
  AppThemes._internal();

  static ThemeData _lightThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.appBarBackgroundColor,
      ),
    );
  }

  static ThemeData get lightThemeData => _lightThemeData();
}
