import 'package:b_potash/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(SplashController());
    return Scaffold(backgroundColor: Color(0xFF001B36),
    body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Image.asset('assets/logos/app_logo.png', height: 171, width: 171),
                Spacer(),
                SpinKitCircle(color: AppColors.textWhite,size: 68),
                SizedBox(height: 48,)
              ],
            ),
          ),
        ),
      ),);
  }
}