import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/wage_form_controller.dart';


class WageReportScreen extends StatelessWidget {
  final String employeeId; // Accept employee ID as a parameter

  const WageReportScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WageReportController(employeeId: employeeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Wage Report'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Type Dropdown
                DropdownButtonFormField<String>(
                  value: controller.selectedWageType.value,
                  onChanged: (value) {
                    controller.selectedWageType.value = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Payment Type',
                    prefixIcon: Icon(Icons.payment),
                  ),
                  items: controller.wageTypes
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  validator: (value) => value == null ? 'Please select payment type' : null,
                ),
                const SizedBox(height: 16.0),

                // Payment Frequency Dropdown
                DropdownButtonFormField<String>(
                  value: controller.selectedPaymentFrequency.value,
                  onChanged: (value) {
                    controller.selectedPaymentFrequency.value = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Payment Frequency',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  items: controller.paymentFrequencies
                      .map((frequency) => DropdownMenuItem(
                    value: frequency,
                    child: Text(frequency),
                  ))
                      .toList(),
                  validator: (value) => value == null ? 'Please select payment frequency' : null,
                ),
                const SizedBox(height: 16.0),

                // Hourly Rate Input Field
                Obx(() => Visibility(
                  visible: controller.isHourlyRateVisible.value,
                  child: TextFormField(
                    controller: controller.hourlyRate,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hourly Rate',
                      prefixIcon: Icon(Icons.money),
                    ),
                    validator: (value) {
                      if (controller.isHourlyRateVisible.value && (value == null || value.isEmpty)) {
                        return 'Please enter hourly rate';
                      }
                      return null;
                    },
                  ),
                )),
                const SizedBox(height: 16.0),

                // Annual Salary Input Field
                Obx(() => Visibility(
                  visible: controller.isAnnualSalaryVisible.value,
                  child: TextFormField(
                    controller: controller.annualSalary,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Annual Salary',
                      prefixIcon: Icon(Icons.money),
                    ),
                    validator: (value) {
                      if (controller.isAnnualSalaryVisible.value && (value == null || value.isEmpty)) {
                        return 'Please enter annual salary';
                      }
                      return null;
                    },
                  ),
                )),
                const SizedBox(height: 24.0),

                // Generate Report Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.generateReport(),
                    child: const Text('Generate Report'),
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
