import 'package:flutter/material.dart';
import 'package:flutter_codebase/core/exported_files/exported_file.dart';
import 'package:flutter_codebase/features/auth/widgets/auth_header.dart';
import 'package:flutter_codebase/features/common/views/widgets/common_appbar.dart';
import '../../widgets/auth_text_form_field.dart';
import '../controller/login_controller.dart';
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: const CommonAppBar(isLeading: true, title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: "Hey! Welcome back",subtitle: "Sign In to your Account",
              ),
              const ResponsiveSizedBox(height: 32),
              AuthTextFormField(
                controller: controller.emailController,
                hintText: "Email", headerText: "Email Address",
              ),
              AuthTextFormField(
                controller: controller.passwordController, hintText: "Password", headerText: "Password", isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                  },
                  child: const ResponsiveText(
                    text: 'Forgot Password?', color: AppColors.primaryColor, fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const ResponsiveSizedBox(height: 32),
              Obx(
                () => ResponsiveButton(
                  title: 'Sign In',
                  backgroundColor: AppColors.primaryColor,
                  isLoading: controller.isLoading.value,
                  onTap: () => controller.login(),
                ),
              ),
              const ResponsiveSizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ResponsiveText(
                    text: "Don't have an account? ",
                    fontSize: 14,
                    color: AppColors.secondaryTxtColor,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutePaths.signUpScreen),
                    child: const ResponsiveText(
                      text: 'Register', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
