import 'package:b_potash/features/splash/controllers/splash_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
