import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/input_screen_controller.dart';

class IPAppointmentForm extends StatelessWidget {
  const IPAppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InputScreenController());
    return Form(
        key: controller.appointmentForm,
        child: Column(
          children: [
            ///-- Unique Code
            TextFormField(
                controller: controller.appointmentCode,
                validator: (value) =>
                    YHMValidator.validateEmptyText('Appointment Code', value),
                decoration: const InputDecoration(
                    labelText: 'Appointment Code',
                    prefixIcon: Icon(Iconsax.user_edit)),
                expands: false),
            const SizedBox(height: YHMSizes.spaceBtwInputFields),
            ElevatedButton(
                onPressed: () {
                  controller.checkStatus();
                },
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('Check Status')))
          ],
        ));
  }
}
