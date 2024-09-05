import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart'; // For PDF generation
import 'package:pdf/widgets.dart' as pw; // For PDF generation
import 'package:path_provider/path_provider.dart'; // For file path
import 'dart:io'; // For file operations

class WageReportController extends GetxController {
  final String employeeId;

  WageReportController({required this.employeeId});

  final formKey = GlobalKey<FormState>();
  final selectedWageType = 'Hourly'.obs;
  final selectedPaymentFrequency = 'Weekly'.obs;
  final hourlyRate = TextEditingController();
  final annualSalary = TextEditingController();
  final isHourlyRateVisible = true.obs;
  final isAnnualSalaryVisible = false.obs;

  final List<String> wageTypes = ['Hourly', 'Annual'];
  final List<String> paymentFrequencies = ['Weekly', 'Monthly', 'Yearly'];

  @override
  void onInit() {
    super.onInit();
    // Automatically update field visibility based on selected wage type
    selectedWageType.listen((type) {
      isHourlyRateVisible.value = type == 'Hourly';
      isAnnualSalaryVisible.value = type == 'Annual';
    });
  }

  void generateReport() async {
    if (formKey.currentState?.validate() ?? false) {
      final wageType = selectedWageType.value;
      final paymentFrequency = selectedPaymentFrequency.value;

      try {
        // Fetch employee data from Firebase
        final employeeDoc = await FirebaseFirestore.instance.collection('Employees').doc(employeeId).get();
        final employeeData = employeeDoc.data();
        if (employeeData == null) {
          throw Exception('Employee data not found');
        }
        final employeeName = employeeData['firstName'] ?? 'Unknown';

        // Fetch schedule data from Firebase
        final scheduleDoc = await FirebaseFirestore.instance.collection('EmployeeSchedules').doc(employeeId).get();
        final scheduleData = scheduleDoc.data();
        if (scheduleData == null) {
          throw Exception('Schedule data not found');
        }

        // Cast and transform scheduleData
        final schedule = scheduleData['schedule'] as Map<String, dynamic>? ?? {};
        final formattedSchedule = schedule.map((key, value) {
          final valueMap = value as Map<String, dynamic>?;
          return MapEntry(
              key,
              valueMap?.map((k, v) => MapEntry(k, v as String)) ?? {}
          );
        });

        final pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              final now = DateTime.now();
              final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
              final formattedDate = formatter.format(now);

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Employee Wage Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  pw.Text('Employee Name: $employeeName'),
                  pw.Text('Date: $formattedDate'),
                  pw.SizedBox(height: 20),
                  pw.Table.fromTextArray(
                    headers: ['Period', 'Hours Worked', 'Wage'],
                    data: _generateWageTable(paymentFrequency, formattedSchedule),
                  ),
                ],
              );
            },
          ),
        );

        // Save the PDF file
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/wage_report.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        // Open the PDF file
        OpenFilex.open(filePath);

        // Inform user of completion
        Get.snackbar('Success', 'Wage report generated and opened successfully!');
      } catch (e) {
        Get.snackbar('Error', 'Failed to generate report.');
        print('Error generating report: $e');
      }
    }
  }

  List<List<String>> _generateWageTable(String frequency, Map<String, Map<String, String>> schedule) {
    final List<List<String>> data = [];
    double totalWage = 0.0;

    print('Generating wage table for frequency: $frequency');

    if (frequency == 'Weekly') {
      // Iterate over the schedule to calculate weekly wages
      double weeklyHours = 0.0;

      schedule.forEach((day, dayData) {
        final totalHours = dayData['total'] ?? '0h 0m';
        final hoursWorked = _parseHours(totalHours); // Custom method to parse '7h 30m' format
        weeklyHours += hoursWorked;

        print('Day: $day, Hours Worked: $hoursWorked');
      });

      final wage = isHourlyRateVisible.value
          ? double.parse(hourlyRate.text) * weeklyHours
          : (double.parse(annualSalary.text) / 52) * weeklyHours; // Annual salary divided by 52 weeks
      totalWage += wage;

      print('Weekly Hours Worked: $weeklyHours, Weekly Wage: $wage');
      data.add(['Week', weeklyHours.toStringAsFixed(2), wage.toStringAsFixed(2)]);
    } else if (frequency == 'Monthly' || frequency == 'Yearly') {
      // Monthly or Yearly Wage Calculation
      schedule.forEach((day, dayData) {
        final totalHours = dayData['total'] ?? '0h 0m';
        final hoursWorked = _parseHours(totalHours);

        final wage = isHourlyRateVisible.value
            ? double.parse(hourlyRate.text) * hoursWorked
            : (double.parse(annualSalary.text) / (frequency == 'Monthly' ? 12 : 365)) * hoursWorked;

        print('Day: $day, Hours Worked: $hoursWorked, Wage: $wage');
        data.add([day, hoursWorked.toString(), wage.toStringAsFixed(2)]);
      });
    }

    print('Generated data: $data');
    return data;
  }

// Helper function to parse "7h 30m" format to hours in double
  double _parseHours(String total) {
    final regex = RegExp(r'(\d+)h (\d+)m');
    final match = regex.firstMatch(total);

    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      return hours + (minutes / 60);
    }
    return 0.0;
  }






  Map<String, List<Map<String, String>>> groupBy(Map<String, Map<String, String>> items, String Function(Map<String, String>) keyFunction) {
    final Map<String, List<Map<String, String>>> grouped = {};

    for (var item in items.values) {
      final key = keyFunction(item);
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(item);
    }

    return grouped;
  }
}
