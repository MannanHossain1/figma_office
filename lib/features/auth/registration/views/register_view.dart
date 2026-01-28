import 'package:b_potash/core/global_widgets/custom_height_gap.dart';
import 'package:b_potash/core/global_widgets/custom_text.dart';
import 'package:b_potash/core/global_widgets/custom_textfield.dart';
import 'package:b_potash/core/global_widgets/primary_button.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:b_potash/features/auth/registration/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.linearGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  height30(),
                  Image.asset('assets/logos/app_logo.png', height: 40),
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Create An Account',
                    color: AppColors.primary,
                    fontWeight: .w800,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text:
                        'Create your account to get into the unlimited options of payments & convenience.',
                    color: AppColors.textSecondary.withValues(alpha: .4),
                    textAlign: .center,
                    fontSize: 14,
                    fontWeight: .w500,
                  ),
                  SizedBox(height: 38),
                  CustomTextfield(
                    hintText: 'Enter your full name here',
                    isObscure: false,
                    headertext: 'Full Name',
                  ),
                  height20(),
                  CustomTextfield(
                    hintText: 'Enter your email here',
                    isObscure: false,
                    headertext: 'Email',
                  ),
                  height20(),
                  Obx(
                    () => CustomTextfield(
                      hintText: 'Enter your password here',
                      isObscure: controller.isPassVisible.value,
                      headertext: 'Password',
                      suffixWidget: IconButton(
                        onPressed: controller.togglePassVisibility,
                        icon: controller.isPassVisible.value
                            ? Icon(
                                Icons.visibility_off_rounded,
                                color: AppColors.primary.withValues(alpha: .4),
                              )
                            : Icon(
                                Icons.visibility_rounded,
                                color: AppColors.primary.withValues(alpha: .4),
                              ),
                      ),
                    ),
                  ),

                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      overflow: .clip,
                      text:
                          'By continuing, you confirm that you are 18 years or older and agree to our Term\'s & Conditions and Privacy Policy.',
                      fontSize: 12,
                      fontWeight: .w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  height20(),
                  PrimaryButton(
                    text: 'Sign Up',
                    onPressed: controller.onTapRegister,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        CustomText(
                          overflow: .clip,
                          text: 'Already have an account? ',
                          fontSize: 12,
                          fontWeight: .w400,
                          color: AppColors.textSecondary,
                        ),
                        InkWell(
                          onTap: controller.navigateToLogin,
                          child: CustomText(
                            overflow: .clip,
                            text: 'Log In',
                            fontSize: 12,
                            fontWeight: .w400,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
