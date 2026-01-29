import 'package:get_storage/get_storage.dart';

import 'secure_storage_service.dart';
import 'shared_preferences_helper.dart';

class StorageServiceProvider {
  StorageServiceProvider._();

  static late final SecureStorageService _secure;
  static final SharedPreferencesHelper _prefs = SharedPreferencesHelper();
  static final GetStorage _local = GetStorage();

  static Future<void> init() async {
    // Local (fast key-value; good for non-sensitive app cache/settings)
    await GetStorage.init();

    // SharedPreferences (small user preferences/settings)
    await _prefs.init();

    // Secure storage (tokens / secrets)
    await SecureStorageService.init();
    _secure = SecureStorageService();
  }

  static SecureStorageService get secureStorage => _secure;

  /// Non-sensitive local storage (GetStorage).
  static GetStorage get localStorage => _local;

  /// User preferences (SharedPreferences).
  static SharedPreferencesHelper get sharedPrefs => _prefs;
}
