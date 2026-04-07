import 'package:flutter_codebase/core/exported_files/exported_file.dart';
import 'package:flutter_codebase/features/auth/login/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies()
  {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}