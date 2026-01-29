/// Central place for storage keys.
///
/// - Put **SharedPreferences** keys here (user settings).
/// - Put **GetStorage** keys here (local cache / flags).
/// - Put **SecureStorage** keys here (tokens), but keep names generic.
class StorageKeys {
  StorageKeys._();

  // Secure storage
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  // SharedPreferences
  static const String isFirstLaunch = 'is_first_launch';
  static const String localeCode = 'locale_code';

  // GetStorage
  static const String themeMode = 'theme_mode';
}

