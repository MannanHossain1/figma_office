import '../../exported_files/exported_file.dart';

class AppService {
  final Rxn<String> _accessToken = Rxn<String>(null);
  final Rxn<String> _fcmToken = Rxn<String>(null);

  Rxn<String> get accessToken => _accessToken;

  Rxn<String> get fcmToken => _fcmToken;

  AppService();

  /// Clear access token (for logout)
  Future<void> clearToken() async {
    _accessToken.value = null;
    await StorageServiceProvider.secureStorage.removeData('access_token');
  }

  /// Clear FCM token (if needed, e.g. on logout)
  Future<void> clearFcmToken() async {
    _fcmToken.value = null;
    await StorageServiceProvider.secureStorage.removeData('fcm_token');
  }

  static Future<void> init() async {
    await StorageServiceProvider.init();
    await _preloadData();
  }

  static Future<void> _preloadData() async {
    // Load tokens from secure storage
    final AppService appService = Get.find<AppService>();

    final String? accessToken = await StorageServiceProvider.secureStorage
        .getData<String>('access_token');
    if (accessToken != null) {
      appService._accessToken.value = accessToken;
    }

    final String? fcmToken = await StorageServiceProvider.secureStorage
        .getData<String>('fcm_token');
    if (fcmToken != null) {
      appService._fcmToken.value = fcmToken;
    }
  }
}
