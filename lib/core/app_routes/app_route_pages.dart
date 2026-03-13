import '../exported_files/exported_file.dart';
import '../../features/sample/screens/sample_screen.dart';

class AppRoutePages {
  AppRoutePages._();

  static final Map<String, AppRoute> pages = {
    AppRoutePaths.splashScreen: AppRoute(page: () => const SampleScreen()),
  };
}
