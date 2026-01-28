import 'package:b_potash/core/global_widgets/circle_button.dart';
import 'package:b_potash/core/global_widgets/pill_button.dart';
import 'package:b_potash/core/utils/constants/app_colors.dart';
import 'package:b_potash/features/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});
  final _controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.linearGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller.pageController,
                      itemCount: _controller.onboardingData.length,
                      onPageChanged: _controller.onPageChanged,
                      itemBuilder: (context, index) {
                        return page(_controller.onboardingData[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        _controller.onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 10,
                          width: _controller.pageIndex.value == index ? 30 : 10,
                          decoration: BoxDecoration(
                            color: _controller.pageIndex.value == index
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
          
                  SizedBox(height: 30,), 
                  Obx(
                    ()=> Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
          
                        _controller.pageIndex.value !=
                                  0 ? CircleButton(
                          iconImage: 'assets/icons/onboarding_previous.svg',
                          onPressed: _controller.previousPage,
                          isOutlined: true,
                        ): Spacer(),
                        _controller.pageIndex.value ==
                                  _controller.onboardingData.length - 1 ? PillButton(text: 'Get Started', onPressed: _controller.nextPage, isOutlined: false,): CircleButton(
                          iconImage: 'assets/icons/onboarding_next.svg',
                          onPressed: _controller.nextPage,
                          isOutlined: false,
                        )
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

  Widget page(Map<String, String> onboardingData) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Image.asset(
          onboardingData['image']!,
          height: 327,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            onboardingData['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.figtree(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            onboardingData['subtitle']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
