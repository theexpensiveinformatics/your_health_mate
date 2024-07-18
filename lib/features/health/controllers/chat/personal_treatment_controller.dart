import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_health_mate/features/health/controllers/home/home_controller.dart';
import 'package:your_health_mate/features/personalization/controller/user_controller.dart';
import 'package:your_health_mate/utils/popups/full_screen_loader.dart';
import 'package:your_health_mate/utils/popups/loaders.dart';

import '../../../../utils/constants/image_strings.dart';

class PersonalTreatmentController extends GetxController {
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();
  final Gemini gemini = Gemini.instance;
  var finalResponse = ''.obs;
  var paragraph = ''.obs;
  var symptoms = <String>[].obs;
  var whatToDo = <String>[].obs;
  var whatNotToDo = <String>[].obs;
  var isLoading = false.obs;
  var graphXValues = <String>[].obs;
  var graphYValues = <double>[].obs;
  final fetchedCommand = ''.obs;
  final finalQuestion = ''.obs;
  var isFirstError = false.obs;

  @override
  void onInit() {
    super.onInit();
    isFirstError.value = false;
    fetchCommand();
    getDietPlan(homeController.dName.text);
  }

  Future<void> fetchCommand() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('commands')
          .doc('8')
          .get();

      if (doc.exists) {
        fetchedCommand.value = doc['command'] ?? '';
        print('Fetched command: ${fetchedCommand.value}');
      }
    } catch (e) {
      print('Error fetching command: $e');
    }
  }

  bool isValidJson(String json) {
    try {
      jsonDecode(json);
      return true;
    } catch (e) {
      return false;
    }
  }

  void processJsonResponse(String response) {
    try {
      if (isValidJson(response)) {
        final jsonResponse = jsonDecode(response);
        print('Decoded JSON: $jsonResponse');
        paragraph.value = jsonResponse['paragraph'] ?? '';
        symptoms.value = List<String>.from(jsonResponse['Symptoms'] ?? []);
        whatToDo.value = List<String>.from(jsonResponse['WhatToDo'] ?? []);
        whatNotToDo.value = List<String>.from(jsonResponse['WhatDont'] ?? []);
        graphXValues.value = List<String>.from(jsonResponse['GraphData']['xValues'] ?? []);
        graphYValues.value = List<double>.from(jsonResponse['GraphData']['yValues']?.map((e) => e.toDouble()) ?? []);
      } else {
        print('Invalid JSON: $response');
      }
    } catch (e) {
      print("Error parsing JSON: $e");
      if (!isFirstError.value) {
        YHMLoaders.errorSnackBar(title: 'Something went wrong', message: 'Please try again');
        isFirstError.value = true;
      }
    }
  }

  Future<void> getDietPlan(String question) async {
    isFirstError.value = false;
    print('Started fetching diet plan...');
    isLoading.value = true;
    finalResponse.value = '';
    paragraph.value = '';
    symptoms.clear();
    whatToDo.clear();
    whatNotToDo.clear();
    graphXValues.clear();
    graphYValues.clear();

    try {
      finalQuestion.value = '${fetchedCommand.value} $question';
      gemini.streamGenerateContent(finalQuestion.value).listen(
            (event) {
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          finalResponse.value += response;

          // Log the intermediate response for debugging
          print('Intermediate response: $response');

          // Process the accumulated response
          processJsonResponse(finalResponse.value);
        },
        onDone: () {
          isLoading.value = false;
          print('Stream completed.');
          print('Final response: ${finalResponse.value}');
          print('Paragraph: ${paragraph.value}');
          print('Symptoms: ${symptoms.join(", ")}');
          print('What to do: ${whatToDo.join(", ")}');
          print('What not to do: ${whatNotToDo.join(", ")}');
        },
        onError: (error) {
          isLoading.value = false;
          print('Error in stream: $error');
          YHMLoaders.errorSnackBar(title: 'Error', message: 'Failed to get diet plan');
        },
      );
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> saveRecord() async {

    // full screen loader
    try {
      // YHMFullScreenLoader.openLoadingDialog(
      //     'We are processing your information...', YHMImages.docerAnimation);
      final userID = userController.user.value.id;

      await FirebaseFirestore.instance
          .collection('dietPlans')
          .doc(userID)
          .collection('treatments')
          .add({
        'diseaseName': homeController.dName.text,
        'paragraph': paragraph.value,
        'symptoms': symptoms.toList(),
        'whatToDo': whatToDo.toList(),
        'whatNotToDo': whatNotToDo.toList(),
        'graphData': {
          'xValues': graphXValues.toList(),
          'yValues': graphYValues.toList(),
        },
        'timestamp': FieldValue.serverTimestamp(),
      });

      // YHMFullScreenLoader.stopLoading();
      YHMLoaders.successSnackBar(title: 'Success', message: 'Your record saved successfully.');
      homeController.fetchDietPlans(userID);
    } catch (e) {
      YHMLoaders.errorSnackBar(title: 'Something went wrong', message: 'Failed to save record');
      YHMFullScreenLoader.stopLoading();
    }
  }
}
