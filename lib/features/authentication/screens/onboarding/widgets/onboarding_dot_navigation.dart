import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/devices/device_utility.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = YHMHelperFunctions.isDarkMode(context);

    return Positioned(
        bottom: YHMDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: YHMSizes.defaultSpace,
        child: SmoothPageIndicator(
            onDotClicked: OnBoardingController.instance.dotNavigationClick,
            effect: ExpandingDotsEffect(
                activeDotColor: dark ? YHMColors.light : YHMColors.dark,
                dotHeight: 4),
            controller: controller.pageController,
            count: 3));
  }
}
