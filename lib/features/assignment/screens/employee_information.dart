import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/common/appbar/blur_appbar.dart';
import 'package:your_health_mate/common/styles/spacing_style.dart';
import 'package:your_health_mate/features/assignment/controllers/employee_information_controller.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/validators/validation.dart';

class AEmployeeInformation extends StatelessWidget {
  const AEmployeeInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeInformationController());
    return Scaffold(
      appBar: YHMBlurAppBar(title: 'Employee Information', showBackArrow: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(YHMSizes.defaultSpace),
          child: Form(
            key: controller.employeeForm, // Add form key here
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Photo Picker
                GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: controller.photo != null ? FileImage(controller.photo!) : null,
                    child: controller.photo == null ? Icon(Icons.add_a_photo) : null,
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwSections),

                // Name Fields
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.firstName,
                        validator: (value) => YHMValidator.validateEmptyText('First Name', value),
                        decoration: const InputDecoration(
                          labelText: YHMTexts.firstName,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                    ),
                    const SizedBox(width: YHMSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastName,
                        validator: (value) => YHMValidator.validateEmptyText('Last Name', value),
                        decoration: const InputDecoration(
                          labelText: YHMTexts.lastName,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Date Picker for DOB
                TextFormField(
                  controller: controller.dob,
                  readOnly: true,
                  onTap: () => controller.selectDate(context, controller.dob),
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    prefixIcon: Icon(Iconsax.calendar),
                  ),
                  validator: (value) => YHMValidator.validateEmptyText('DOB', value),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: controller.gender.value.isEmpty ? null : controller.gender.value, // Ensure value is either null or a valid item
                  onChanged: (value) {
                    controller.gender.value = value!; // Update the value
                  },
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: Icon(Iconsax.man),
                  ),
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  validator: (value) => value == null ? 'Please select a gender' : null,
                ),

                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Department Field
                TextFormField(
                  controller: controller.department,
                  validator: (value) => YHMValidator.validateEmptyText('Department', value),
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    prefixIcon: Icon(Iconsax.building),
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Job Title Field
                TextFormField(
                  controller: controller.jobTitle,
                  validator: (value) => YHMValidator.validateEmptyText('Job Title', value),
                  decoration: const InputDecoration(
                    labelText: 'Job Title',
                    prefixIcon: Icon(Iconsax.activity),
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Start Date Picker
                TextFormField(
                  controller: controller.startDate,
                  readOnly: true,
                  onTap: () => controller.selectDate(context, controller.startDate),
                  decoration: const InputDecoration(
                    labelText: 'Start Date',
                    prefixIcon: Icon(Iconsax.calendar),
                  ),
                  validator: (value) => YHMValidator.validateEmptyText('Start Date', value),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Address Fields
                TextFormField(
                  controller: controller.address,
                  validator: (value) => YHMValidator.validateEmptyText("Address", value),
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Iconsax.location),
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // City Field
                TextFormField(
                  controller: controller.city,
                  validator: (value) => YHMValidator.validateEmptyText("City", value),
                  decoration: const InputDecoration(
                    labelText: 'City',
                    prefixIcon: Icon(Iconsax.building_3),
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // State Field
                TextFormField(
                  controller: controller.state,
                  validator: (value) => YHMValidator.validateEmptyText("State", value),
                  decoration: const InputDecoration(
                    labelText: 'State',
                    prefixIcon: Icon(Iconsax.map),
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                // Zip Code Field
                TextFormField(
                  controller: controller.zipCode,
                  validator: (value) => YHMValidator.validateEmptyText("Zip Code", value),
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    prefixIcon: Icon(Iconsax.code),
                  ),
                ),
                const SizedBox(height: YHMSizes.spaceBtwSections),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.nextButton(),
                    child: Text('Next'),
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

