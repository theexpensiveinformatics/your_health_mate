import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/timeline_screen_controller.dart';

class IPNameSection extends StatelessWidget {
  final String bookId;
  const IPNameSection({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimelineScreenController(bookId));
    return Obx(() => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: YHMColors.dark.withOpacity(0.08),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Blood Donate by', style: Theme.of(context).textTheme.bodySmall),
              Text(controller.donatorName.value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        const SizedBox(width: YHMSizes.spaceBtwInputFields),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: YHMColors.dark.withOpacity(0.08),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Phlebotomist', style: Theme.of(context).textTheme.bodySmall),
              Text(controller.phlebotomistName.value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )
      ],
    ));
  }
}
