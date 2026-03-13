import 'package:firebase_messaging/firebase_messaging.dart';
import '../../exported_files/exported_file.dart';
import '../local_notification_services/local_notification_service.dart';

class FcmService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final RxString _fcmToken = ''.obs;

  String get fcmToken => _fcmToken.value;

  Future<FcmService> init() async {
    await _requestPermission();
    await _fetchToken();
    _setupTokenRefresh();
    _setupForegroundListener();
    _setupBackgroundListener();
    return this;
  }

  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      DService().warning("FCM: Notification permission denied");
    }
  }

  Future<void> _fetchToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        _updateToken(token);
      }
    } catch (e) {
      DService().error("FCM: Failed to fetch token: $e");
    }
  }

  void _setupTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen(
      (newToken) => _updateToken(newToken),
    );
  }

  void _updateToken(String token) {
    _fcmToken.value = token;

    // Keep a copy in AppService for easy access and persistence
    final appService = Get.find<AppService>();
    appService.fcmToken.value = token;
    StorageServiceProvider.secureStorage.saveData('fcm_token', token);

    DService().info("FCM Token: $token");
    // _sendTokenToBackend(token);
  }

  void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  void _setupBackgroundListener() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    DService().info("FCM Foreground message: ${message.data}");
    if (message.notification != null) {
      // Show heads-up notification using local notifications
      LocalNotificationService().showNotificationFromMessage(message);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    DService().info("FCM Background message: ${message.data}");
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }
}
