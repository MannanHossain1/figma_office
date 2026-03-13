import 'package:b_potash/features/sample/controllers/sample_controller.dart';
import 'package:b_potash/features/sample/services/sample_service.dart';
import '../../../core/exported_files/exported_file.dart';

class SampleBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SampleService());
    Get.lazyPut(() => SampleController());
  }
}
