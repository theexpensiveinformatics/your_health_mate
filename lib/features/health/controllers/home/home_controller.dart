import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart%20%20';

import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/personlized_treatment/diet_model.dart';
import '../../screens/personalized_treatment/personalized_treatment.dart';


class HomeController extends GetxController {
  /// -- variable
  final dName = TextEditingController();
  final userController = Get.find<UserController>();
  // make lenght rx double
  RxDouble length = 100.0.obs;
  // double  length = 100;

  /// userController.user.value.id -> userId

  var dietPlans = <DietPlan>[].obs;  // Use the DietPlan model instead of a Map
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDietPlans(userController.user.value.id);
  }

  void fetchDietPlans(String userId) async {
    try {
      if (userController.profileLoading.value) {
        isLoading.value = true;
        fetchDietPlans(userController.user.value.id);
      } else {
        isLoading.value = true;

        var querySnapshot = await FirebaseFirestore.instance
            .collection('dietPlans')
            .doc(userController.user.value.id)
            .collection('treatments')
            .get();

        dietPlans.value = querySnapshot.docs
            .map((doc) => DietPlan.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        isLoading.value = false;
        // - store lenght
        length.value = dietPlans.length.toDouble();
        print('Diet Plans: $dietPlans');
      }
    } catch (e) {
      print("Error fetching diet plans: $e");
      isLoading.value = false;
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void nextScreen() {
    if (dName.text.isNotEmpty) {
      Get.to(YHMPersonalTreatmanetScreen(dName: dName.text));
    } else {
      YHMLoaders.errorSnackBar(title: 'Enter Disease Name', message: 'Try again !!');
    }
  }
}
