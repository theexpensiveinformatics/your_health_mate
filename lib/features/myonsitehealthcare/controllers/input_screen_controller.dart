import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_health_mate/features/myonsitehealthcare/screens/timeline_screen/timeline_screen.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helper/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';


class InputScreenController extends GetxController {
  final isLoading = false.obs;
  final appointmentCode = TextEditingController();
  GlobalKey<FormState> appointmentForm = GlobalKey<FormState>(); // form key for validation

  //-- method of get timeline
  Future<void> checkStatus() async {
    try {
      isLoading.value = true;

      // - Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        YHMLoaders.errorSnackBar(title: "No Internet");
        isLoading.value = false;

      }

      //- Form validation
      if (!appointmentForm.currentState!.validate()) {
        isLoading.value = false;

      }

      // - Check if the document exists in Firestore
      final appointmentCodeText = appointmentCode.text.trim();
      final docSnapshot = await FirebaseFirestore.instance
          .collection('appointment')
          .doc(appointmentCodeText)
          .get();

      if (docSnapshot.exists) {
        final bookId = docSnapshot.data()?['bookId'];
        if (bookId != null) {
          Get.to(() => IPTimeline(bookId: bookId,));
        } else {
          YHMLoaders.errorSnackBar(
              title: 'Error', message: 'Booking ID not found.');
        }
      } else {
        YHMLoaders.errorSnackBar(
            title: 'Not Found', message: 'No appointment found with this code.');
      }

      isLoading.value = false;
    } catch (e) {
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e.toString());
      isLoading.value = false;
    }
  }
}
