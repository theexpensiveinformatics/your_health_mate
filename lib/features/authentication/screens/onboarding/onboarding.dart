import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:your_health_mate/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:your_health_mate/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';

import 'package:your_health_mate/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:your_health_mate/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: YHMImages.onBoardingImage1,
                title: YHMTexts.onBoardingTitle1,
                subTitle: YHMTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: YHMImages.onBoardingImage2,
                title: YHMTexts.onBoardingTitle2,
                subTitle: YHMTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: YHMImages.onBoardingImage3,
                title: YHMTexts.onBoardingTitle3,
                subTitle: YHMTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip button
          const OnBoardginSkip(),

          //Dot Navigation Smooth Page Indicator
          const OnBoardingDotNavigation(),

          //Circular Button
          OnBoardingNextButton()
        ],
      ),
    );
  }
}
