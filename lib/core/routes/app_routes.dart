import 'package:b_potash/features/auth/login/views/login_view.dart';
import 'package:b_potash/features/auth/registration/views/register_verify_view.dart';
import 'package:b_potash/features/auth/registration/views/register_view.dart';
import 'package:b_potash/features/onboarding/views/onboarding_view.dart';
import 'package:b_potash/features/splash/views/splash_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const init = "/";
  static const login = "/login";
  static const onboarding = "/onboarding";
  static const register = "/register";
  static const registerVerify = "/register_verify";
  static const forgetPass = "/forget_pass";
  static const passVerify = "/pass_verify";
  static const newPass = "/new_pass";
  static const home = "/home";

  static List<GetPage> routes = [
    GetPage(name: init, page: () => SplashView()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: onboarding, page: () => OnboardingView()),
    GetPage(name: register, page: () => RegisterView()),
    GetPage(name: registerVerify, page: () => RegisterVerifyView()),
    // GetPage(name: forgetPass, page: () => ForgetPassView()),
    // GetPage(name: passVerify, page: () => PassVerifyView()),
    // GetPage(name: forgetPass, page: () => ForgetPassView()),
    // GetPage(name: forgetPass, page: () => ForgetPassView()),
  ];
}
