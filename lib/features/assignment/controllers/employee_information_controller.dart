import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../../../utils/helper/network_manager.dart';
import '../screens/week_schedule.dart';

class EmployeeInformationController extends GetxController {
  //-- Variables for form fields
  final isLoading = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dob = TextEditingController();
  final department = TextEditingController();
  final jobTitle = TextEditingController();
  final startDate = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipCode = TextEditingController();
  final gender = ''.obs;
  File? photo; // Variable to store the selected image
  GlobalKey<FormState> employeeForm = GlobalKey<FormState>();

  // Method to select a date using a date picker
  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      controller.text = DateFormat('MM/dd/yyyy').format(pickedDate);
    }
  }

  // Method to pick an image using ImagePicker
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      update();
    }
  }

  // Method to upload the image to Firebase Storage and get its URL
  Future<String> uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('employee_photos/${image.path.split('/').last}');
    await imageRef.putFile(image);
    return await imageRef.getDownloadURL();
  }

  // Function to handle the Next button action
  Future<void> nextButton() async {
    try {
      isLoading.value = true;  // Show loading state

      // Check internet connectivity (optional)
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Get.snackbar('Connection Error', 'No internet connection available.');
        return;
      }

      // Validate form fields
      if (!employeeForm.currentState!.validate()) {
        Get.snackbar('Validation Error', 'Please fill all required fields.');
        return;
      }

      // Generate a unique ID
      String uniqueId = FirebaseFirestore.instance.collection('Employees').doc().id;

      // Prepare the data to be stored
      Map<String, dynamic> employeeData = {
        'id': uniqueId,  // Use the unique ID as the 'id' field
        'firstName': firstName.text,
        'lastName': lastName.text,
        'dob': dob.text,
        'gender': gender.value,
        'department': department.text,
        'jobTitle': jobTitle.text,
        'startDate': startDate.text,
        'address': address.text,
        'city': city.text,
        'state': state.text,
        'zipCode': zipCode.text,
      };

      // If a photo is selected, upload it and add the URL to the data
      if (photo != null) {
        String photoUrl = await uploadImage(photo!);
        employeeData['photoUrl'] = photoUrl;
      }

      // Save data to Firebase Firestore using the uniqueId as the document ID
      await FirebaseFirestore.instance.collection('Employees').doc(uniqueId).set(employeeData);

      // Show success message
      Get.snackbar('Success', 'Employee information saved successfully.');

      // Navigate to the next form screen (e.g., Week Schedule Form)
      Get.to(() => WeekScheduleFormScreen(employeeId: uniqueId));

    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Failed to save employee information.');
      print(e.toString());
    } finally {
      isLoading.value = false;  // Hide loading state
    }
  }
}