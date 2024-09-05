import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:your_health_mate/features/myonsitehealthcare/controllers/timeline_screen_controller.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class IPBuildTimelineStep extends StatelessWidget {
  final String bookId;
  const IPBuildTimelineStep({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimelineScreenController(bookId));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: YHMColors.dark.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: YHMSizes.spaceBtwInputFields),
          Text('Timeline', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: YHMSizes.spaceBtwInputFields),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTimelineStep('Appointment Requested', 0, double.parse(controller.currentStep.value)),
                _buildTimelineStep('Phlebotomist On The Way', 1, double.parse(controller.currentStep.value)),
                _buildTimelineStep('Phlebotomist Arrived', 2, double.parse(controller.currentStep.value)),
                _buildTimelineStep('Appointment Completed', 3, double.parse(controller.currentStep.value)),
              ],
            );
          }),
          const SizedBox(height: YHMSizes.spaceBtwInputFields),
        ],
      ),
    );
  }
  Widget _buildTimelineStep(String title, int step, double currentStep) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: currentStep >= step ? YHMColors.primary : Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: currentStep >= step ? FontWeight.bold : FontWeight.normal,
            color: currentStep >= step ? YHMColors.primary : Colors.grey,
          ),
        ),
      ],
    );
  }
}
