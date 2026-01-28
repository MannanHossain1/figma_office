import 'package:b_potash/core/global_widgets/custom_height_gap.dart';
import 'package:b_potash/core/global_widgets/custom_text.dart';
import 'package:b_potash/core/global_widgets/primary_button.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:b_potash/features/auth/registration/controllers/verify_success_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifySuccessView extends StatelessWidget {
  const VerifySuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifySuccessController());
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
                  Spacer(),
                  Image.asset('assets/images/verification.png', height: 136),
                  height30(),
                  CustomText(
                    text: 'Successfully Verified',
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: .w700,
                  ),
                  height10(),
                  CustomText(
                    text:
                        'Your account has been registered succesfully, now let\'s enjoy Car features!',
                    textAlign: .center,
                    color: AppColors.textThird,
                    fontSize: 14,
                    fontWeight: .w500,
                  ),
                  Spacer(),
                  PrimaryButton(text: 'Go to Home', onPressed: () {}),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
