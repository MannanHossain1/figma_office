import 'package:b_potash/core/global_widgets/custom_height_gap.dart';
import 'package:b_potash/core/global_widgets/custom_text.dart';
import 'package:b_potash/core/global_widgets/primary_button.dart';
import 'package:b_potash/core/global_widgets/secondary_button.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:b_potash/features/auth/registration/controllers/register_verify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class RegisterVerifyView extends StatelessWidget {
  const RegisterVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterVerifyController());

    final defaultPinTheme = PinTheme(
      height: 60,
      width: 60,
      textStyle: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: .w700,
        color: AppColors.primary,
      ),
      decoration: BoxDecoration(
        borderRadius: .circular(15),
        color: AppColors.black.withValues(alpha: .1),
        border: Border.all(
          color: AppColors.black.withValues(alpha: .2),
          width: 1,
        ),
      ),
    );

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
                    text: 'Verify E-mail',
                    color: AppColors.primary,
                    fontWeight: .w800,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text:
                        'Please check your email. Give correct authentication code here.',
                    color: AppColors.textSecondary.withValues(alpha: .4),
                    textAlign: .center,
                    fontSize: 14,
                    fontWeight: .w500,
                  ),
                  SizedBox(height: 38),
                  Form(
                    child: Pinput(
                      length: 4,
                      controller: controller.otpController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          borderRadius: .circular(15),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),

                  height20(),
                  PrimaryButton(
                    text: 'Apply Code',
                    onPressed: controller.onTapApply,
                  ),
                  height15(),
                  SecondaryButton(
                    text: 'Send OTP Again',
                    onPressed: controller.onTapSendOtp,
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
