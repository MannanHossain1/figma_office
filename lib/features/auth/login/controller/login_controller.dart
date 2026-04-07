import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "fill all fields");
      return;
    }
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));
      Get.snackbar("Success", "Login Successful");
    } catch (e) {
      Get.snackbar("Error", "Login failed");
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
