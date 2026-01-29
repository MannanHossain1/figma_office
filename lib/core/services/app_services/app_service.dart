import 'package:b_potash/core/exported_files/exported_file.dart';

/// App-wide reactive state and lightweight session values.
///
/// Keep this service small: only store values that are truly global.
class AppService extends GetxService {
  /// Access token used by `ApiClient` for Authorization header.
  final RxnString accessToken = RxnString();

  /// Example: user id / email can be kept here later if needed.
  final RxnString userId = RxnString();

  /// Clear session-related values (e.g. on logout).
  void clearSession() {
    accessToken.value = null;
    userId.value = null;
  }
}

