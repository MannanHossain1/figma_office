import 'package:b_potash/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final isPassVisible = true.obs;
  final isRememberMe = true.obs;

  void togglePassVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  void nextPage() {
    // Get.to(RegisterView());
  }
  void navigateToRegister() {
    // Get.toNamed(AppRoutes.register);
  }

  void navigateToForgotPass() {
    // Get.to(RegisterView());
  }
}
