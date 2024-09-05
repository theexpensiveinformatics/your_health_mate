import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/utils/constants/sizes.dart';
import '../controllers/week_schedule_controller.dart';


class WeekScheduleFormScreen extends StatelessWidget {
  final String employeeId;

  const WeekScheduleFormScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeekScheduleController(employeeId: employeeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Week Schedule Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(YHMSizes.defaultSpace),
          child: Form(
            key: controller.scheduleFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Schedule Inputs for Each Day of the Week
                ...controller.daysOfWeek.map((day) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: YHMSizes.spaceBtwInputFields),

                      // Start Time Picker
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.getStartController(day),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '$day Start Time',
                                prefixIcon: const Icon(Iconsax.clock),
                              ),
                              onTap: () => controller.selectTime(context, controller.getStartController(day)),
                              validator: (value) => value!.isEmpty ? 'Please select start time' : null,
                            ),
                          ),
                          const SizedBox(width: YHMSizes.spaceBtwInputFields),

                          // End Time Picker
                          Expanded(
                            child: TextFormField(
                              controller: controller.getEndController(day),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '$day End Time',
                                prefixIcon: const Icon(Iconsax.clock),
                              ),
                              onTap: () => controller.selectTime(context, controller.getEndController(day)),
                              validator: (value) => value!.isEmpty ? 'Please select end time' : null,
                            ),
                          ),
                        ],
                      ),

                      // Total Hours Display
                      const SizedBox(height: YHMSizes.spaceBtwInputFields),
                      Obx(()=>  controller.isLoading.value == false ? Text('Total Hours: ${controller.calculateTotalHours(day)}'): Text('Total Hours: ${controller.calculateTotalHours(day)}')),

                      const SizedBox(height: YHMSizes.spaceBtwSections),
                    ],
                  );
                }).toList(),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.submitSchedule(),
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
