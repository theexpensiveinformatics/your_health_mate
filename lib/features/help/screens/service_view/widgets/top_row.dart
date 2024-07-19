import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/round_icon_container.dart';

import '../../../../../utils/constants/sizes.dart';


class YHMServiceViewTopBar extends StatelessWidget {
  const YHMServiceViewTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              // back to preivise screen
                onTap: () {
                  Get.back();
                },
                child:
                RoundIconContainer(icon: Iconsax.arrow_left)),
          ],
        ),
        Row(
          children: [
            RoundIconContainer(icon: Iconsax.flag),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            RoundIconContainer(icon: Iconsax.more),
          ],
        ),
      ],
    );
  }
}
