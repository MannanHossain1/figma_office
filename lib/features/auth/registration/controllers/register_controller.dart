import 'package:b_potash/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final isPassVisible = true.obs;

  void togglePassVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void onTapRegister() {
    Get.toNamed(AppRoutes.registerVerify);
  }

  void navigateToLogin() {
    Get.back();
  }
}
