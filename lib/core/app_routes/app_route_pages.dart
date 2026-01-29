import 'package:b_potash/core/exported_files/exported_file.dart';
import 'package:b_potash/features/onboarding/views/onboarding_view.dart';
import 'package:b_potash/features/splash/bindings/splash_bindings.dart';
import 'package:b_potash/features/splash/views/splash_view.dart';

class AppRoutePages {
  AppRoutePages._();

  static Widget Function() _builder(Widget screen) =>
      () => screen;

  static final Map<String, AppRoute> pages = {
    AppRoutePaths.splashScreen: AppRoute(
      page: _builder(SplashView()),
      binding: SplashBindings(),
    ),
    AppRoutePaths.onboarding: AppRoute(
      page: _builder(OnboardingView()),
      // binding: SplashBinding(),
    ),
  };
}
