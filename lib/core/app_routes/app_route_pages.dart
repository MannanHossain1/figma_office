import 'package:flutter_codebase/features/auth/signup/views/sign_up_screen.dart';
import '../../features/auth/login/bindings/login_bindings.dart';
import '../../features/auth/login/views/sign_in_screen.dart';
import '../../features/auth/signup/bindings/sign_up_bindings.dart';
import '../../features/auth/verification/verification_screen.dart';
import '../exported_files/exported_file.dart';
class AppRoutePages {
  AppRoutePages._();
  static final Map<String, AppRoute> pages = {
    AppRoutePaths.splashScreen: AppRoute(page: () => const SignUpScreen()),
    AppRoutePaths.verificationScreen: AppRoute(page: () => const VerificationScreen()),
    AppRoutePaths.signInScreen: AppRoute(
      page: () =>  SignInScreen(),
      binding: LoginBindings(),
    ),

    AppRoutePaths.signUpScreen: AppRoute(page: () => SignUpScreen(),
    binding: SignupBindings(),
    ),
  };
}
