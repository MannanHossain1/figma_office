import 'package:b_potash/core/app_routes/app_route_pages.dart';
import 'package:b_potash/core/app_routes/app_route_paths.dart';
import 'package:get/get.dart';

// import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed(AppRoutePaths.onboarding);
  }
}
