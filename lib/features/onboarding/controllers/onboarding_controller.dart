import 'package:b_potash/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;
  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Your Camp, Simplified",
      "subtitle": "Access your room details, group assignments, and personal dashboard in one clean, easy-to-use place.",
      "image": "assets/images/onboarding_1.png",
    },
    {
      "title": "Grab Your Spot First",
      "subtitle": "Don't miss out on the best Chaborahs. See exactly how many seats are left and join your favorite activities with a single tap. ",
      "image": "assets/images/onboarding_2.png",
    },
    {
      "title": "Never Miss a Reminder",
      "subtitle": "Stay ahead with a live schedule. Get instant alerts for activity changes, meal times, and special broadcasts.",
      "image": "assets/images/onboarding_3.png",
    },
  ];

  void onPageChanged(int index) {        
    pageIndex.value = index;
  }

  void nextPage() {
    if (pageIndex.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }
  void previousPage() {

      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
  }
}