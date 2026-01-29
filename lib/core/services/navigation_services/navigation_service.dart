import 'package:b_potash/core/exported_files/exported_file.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService instance = NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? pushNamed(String route, {Object? arguments}) {
    return Get.toNamed(route, arguments: arguments);
  }

  Future<dynamic>? push(Widget page) {
    return Get.to(() => page);
  }

  void pop<T extends Object>([T? result]) {
    Get.back(result: result);
  }

  Future<void>? replaceNamed(String route, {Object? arguments}) {
    return Get.offNamed(route, arguments: arguments);
  }

  Future<void>? replaceAllNamed(String route, {Object? arguments}) {
    return Get.offAllNamed(route, arguments: arguments);
  }
}
