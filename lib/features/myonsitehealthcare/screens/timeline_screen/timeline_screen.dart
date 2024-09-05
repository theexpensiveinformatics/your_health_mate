import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/common/appbar/blur_appbar.dart';
import 'package:your_health_mate/features/myonsitehealthcare/screens/timeline_screen/widgets/appointment_map.dart';
import 'package:your_health_mate/features/myonsitehealthcare/screens/timeline_screen/widgets/name_section.dart';
import 'package:your_health_mate/features/myonsitehealthcare/screens/timeline_screen/widgets/timline_step.dart';
import 'package:your_health_mate/utils/constants/sizes.dart';
import 'package:your_health_mate/features/myonsitehealthcare/controllers/timeline_screen_controller.dart';

class IPTimeline extends StatelessWidget {
  final String bookId;

  const IPTimeline({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimelineScreenController(bookId));

    return Scaffold(
      appBar: const YHMBlurAppBar(title: 'Appointment Status', showBackArrow: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-- map
              IPAppointmentMap(bookId: bookId),
              const SizedBox(height: 20),

              // -- name section
              IPNameSection(bookId: bookId),
              const SizedBox(height: YHMSizes.spaceBtwInputFields),

              // -- timeline
              IPBuildTimelineStep(bookId: bookId),
              const SizedBox(height: YHMSizes.spaceBtwInputFields),

              // -- Estimated time
              Obx(() => Text('Estimated Time: ${controller.estimatedTime.value}', style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
        ),
      ),
    );
  }
}
