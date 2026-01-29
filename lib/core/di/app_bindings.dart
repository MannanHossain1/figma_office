import 'package:b_potash/core/exported_files/exported_file.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    // add your bindings here. which will be used in the app from start.
    Get.put(AppService(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    Get.put(ApiService(), permanent: true);
    Get.put(PhotoPickerService(), permanent: true);
    Get.put(UserProfileService(), permanent: true);
    Get.put(LocationService(), permanent: true);
  }
}
