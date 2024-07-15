import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/devices/device_utility.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';


class OnBoardginSkip extends StatelessWidget {
  const OnBoardginSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: YHMDeviceUtils.getAppBarHeight(),
        right: YHMSizes.defaultSpace,
        child: TextButton(
            onPressed: () => OnBoardingController.instance.skipPage(),
            child: Text(YHMTexts.skipButton)));
  }
}
