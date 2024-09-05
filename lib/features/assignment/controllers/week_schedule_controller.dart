import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/wage_form.dart';

class WeekScheduleController extends GetxController {
  final scheduleFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  // Controllers for each day's start and end times
  final Map<String, TextEditingController> startControllers = {};
  final Map<String, TextEditingController> endControllers = {};

  // Add this line to store the employee ID
  final String employeeId;

  // Update the constructor to accept employeeId
  WeekScheduleController({required this.employeeId}) {
    // Initialize controllers for each day
    for (var day in daysOfWeek) {
      startControllers[day] = TextEditingController();
      endControllers[day] = TextEditingController();
    }
  }

  // Method to select time
  Future<void> selectTime(BuildContext context, TextEditingController controller) async {
    isLoading.value = true;
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      controller.text = formattedTime;
    }
    isLoading.value = false;
  }

  // Get start controller by day
  TextEditingController getStartController(String day) {
    return startControllers[day]!;
  }

  // Get end controller by day
  TextEditingController getEndController(String day) {
    return endControllers[day]!;
  }

  // Helper function to parse time from string
  DateTime _parseTimeOfDay(String timeString) {
    final now = DateTime.now();

    // Clean up the time string
    final cleanedTimeString = timeString
        .trim()
        .replaceAll(RegExp(r'[^\x20-\x7E]'), '')
        .replaceAll(RegExp(r'\u00A0'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');

    print('Parsing cleaned time string: "$cleanedTimeString"');

    try {
      // Split the time string into components
      final components = cleanedTimeString.split(RegExp(r'[\s:]+'));
      if (components.length != 3) {
        throw FormatException('Invalid time format');
      }

      int hours = int.parse(components[0]);
      int minutes = int.parse(components[1]);
      String period = components[2].toUpperCase();

      // Adjust hours for PM
      if (period == 'PM' && hours != 12) {
        hours += 12;
      } else if (period == 'AM' && hours == 12) {
        hours = 0;
      }

      return DateTime(now.year, now.month, now.day, hours, minutes);
    } catch (e) {
      print('Error parsing time: $e');
      // Return the current time as a fallback
      return now;
    }
  }

  // Updated method to calculate total hours worked for a day, subtracting 30 minutes for break
  String calculateTotalHours(String day) {
    try {
      final startText = startControllers[day]!.text;
      final endText = endControllers[day]!.text;

      print('Start Time for $day: "$startText"');
      print('End Time for $day: "$endText"');

      if (startText.isEmpty || endText.isEmpty) return '0 Hours';

      DateTime startTime = _parseTimeOfDay(startText);
      DateTime endTime = _parseTimeOfDay(endText);

      // Handle time overlap (end time is past midnight)
      if (endTime.isBefore(startTime)) {
        endTime = endTime.add(const Duration(days: 1));
      }

      final duration = endTime.difference(startTime);

      // Subtract 30 minutes for break
      final adjustedDuration = duration - const Duration(minutes: 30);

      // Ensure the adjusted duration is not negative
      final finalDuration = adjustedDuration.isNegative ? Duration.zero : adjustedDuration;

      final totalHours = finalDuration.inHours;
      final totalMinutes = finalDuration.inMinutes.remainder(60);

      return '${totalHours}h ${totalMinutes}m';
    } catch (e) {
      print('Error calculating total hours: $e');
      return '0 Hours';
    }
  }

  // Submit the schedule data to Firebase Firestore
  Future<void> submitSchedule() async {
    if (!scheduleFormKey.currentState!.validate()) {
      Get.snackbar('Validation Error', 'Please fill all required fields.');
      return;
    }

    // Collect schedule data
    Map<String, Map<String, String>> scheduleData = {};
    for (var day in daysOfWeek) {
      scheduleData[day] = {
        'start': startControllers[day]!.text,
        'end': endControllers[day]!.text,
        'total': calculateTotalHours(day),
      };
    }

    try {
      // Save data to Firebase Firestore using the employeeId
      await FirebaseFirestore.instance.collection('EmployeeSchedules').doc(employeeId).set({
        'schedule': scheduleData,
      });

      Get.snackbar('Success', 'Schedule saved successfully.');
      // Navigate to the next form screen (e.g., Wage Form)
      Get.to(() => WageReportScreen(employeeId: employeeId)); // Ensure this screen is implemented
    } catch (e) {
      Get.snackbar('Error', 'Failed to save schedule.');
      print(e.toString());
    }
  }
}