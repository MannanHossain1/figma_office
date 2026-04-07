import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_codebase/core/exported_files/exported_file.dart';
import 'package:flutter_codebase/features/common/views/widgets/common_appbar.dart';
import 'package:flutter_codebase/features/auth/widgets/auth_header.dart';
import 'package:flutter_codebase/features/auth/widgets/auth_text_form_field.dart';
import '../controller/signup_controller.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: CommonAppBar(
        isLeading: true,
        title: 'Create Your Account',
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             AuthHeader(
              title: "Create Your Account",
              subtitle: "Create account and apply all services",
            ),
             ResponsiveSizedBox(height: 32),
            AuthTextFormField(
              controller: controller.fullNameController, hintText: "Full name", headerText: "Full Name",
            ),
            AuthTextFormField(
              controller: controller.emailController, hintText: "Email", headerText: "Email",
            ),
            AuthTextFormField(
              controller: controller.phoneController, hintText: "Phone Number", headerText: "Phone Number",
            ),
            AuthTextFormField(
              controller: controller.passwordController, hintText: "Password", headerText: "Password", isPassword: true,
            ),
             ResponsiveSizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutePaths.signInScreen),
              child: ResponsiveText(
                text: 'Already have an account? Sign In',
                color: AppColors.primaryColor,
              ),
            ),

             ResponsiveSizedBox(height: 40),

            Obx(() => ResponsiveButton(
              title: controller.isLoading.value ? "Creating Account..." : 'Sign Up',
              backgroundColor: AppColors.primaryColor,
              onTap: controller.isLoading.value
                  ? null
                  : () => controller.signUp(),
            )),
          ],
        ),
      ),
    );
  }
}