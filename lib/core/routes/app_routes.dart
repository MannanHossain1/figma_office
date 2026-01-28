import 'package:b_potash/features/auth/login/views/login_view.dart';
import 'package:b_potash/features/auth/registration/views/otp_verify_view.dart';
import 'package:b_potash/features/auth/registration/views/register_view.dart';
import 'package:b_potash/features/auth/registration/views/verify_success_view.dart';
import 'package:b_potash/features/onboarding/views/onboarding_view.dart';
import 'package:b_potash/features/splash/views/splash_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const init = "/";
  static const login = "/login";
  static const onboarding = "/onboarding";
  static const register = "/register";
  static const otpVerify = "/otpVerify";
  static const otpVerifySuccess = "/otpVerifySuccess";
  static const forgetPass = "/forgetPass";
  static const newPass = "/newPass";
  static const home = "/home";

  static List<GetPage> routes = [
    GetPage(name: init, page: () => SplashView()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: onboarding, page: () => OnboardingView()),
    GetPage(name: register, page: () => RegisterView()),
    GetPage(name: otpVerify, page: () => OtpVerifyView()),
    GetPage(name: otpVerifySuccess, page: () => VerifySuccessView()),
    // GetPage(name: forgetPass, page: () => ForgetPassView()),
    // GetPage(name: passVerify, page: () => PassVerifyView()),
    // GetPage(name: forgetPass, page: () => ForgetPassView()),
    // GetPage(name: forgetPass, page: () => ForgetPassView()),
  ];
}
