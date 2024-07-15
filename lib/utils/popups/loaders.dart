import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../constants/colors.dart';
import '../helper/helper_functions.dart';

class YHMLoaders {


  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: YHMHelperFunctions.isDarkMode(Get.context!)
              ? YHMColors.darkerGrey.withOpacity(0.9)
              : YHMColors.grey.withOpacity(0.9),
        ),
      ),
    ));
  }

  static successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      padding: EdgeInsets.only(top: 12,left: 18,bottom: 12,right: 12),
      colorText:  YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.white : YHMColors.black,
      backgroundColor: YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.black.withOpacity(0.8)
          : YHMColors.white.withOpacity(0.8),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      borderRadius: 12,
      borderColor: YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.white.withOpacity(0.1) : YHMColors.black.withOpacity(0.1),
      borderWidth: 1.5,
      barBlur: 7,
      icon: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Transform.scale(
          alignment: Alignment.center,
          scale: 2.3, // Adjust the scale factor as needed
          child: Lottie.asset('assets/lottie/done.json',repeat: true,),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: YHMHelperFunctions.isDarkMode(Get.context!)
              ? Colors.black.withOpacity(0.15): Colors.grey.withOpacity(0.15),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ],
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      padding: EdgeInsets.only(top: 12,left: 18,bottom: 12,right: 12),
      colorText:  YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.white : YHMColors.black,
      backgroundColor: YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.black.withOpacity(0.8)
          : YHMColors.white.withOpacity(0.8),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      borderRadius: 12,
      borderColor: YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.white.withOpacity(0.1) : YHMColors.black.withOpacity(0.1),
      borderWidth: 1.5,
      barBlur: 7,
      icon: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Transform.scale(
          alignment: Alignment.center,
          scale: 1.0, // Adjust the scale factor as needed
          child: Lottie.asset('assets/lottie/warning.json',repeat: true,),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: YHMHelperFunctions.isDarkMode(Get.context!)
              ? Colors.black.withOpacity(0.15): Colors.grey.withOpacity(0.15),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ],
    );
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      padding: EdgeInsets.only(top: 12,left: 18,bottom: 12,right: 12),
      colorText:  YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.white : YHMColors.black,
      backgroundColor: YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.black.withOpacity(0.8)
          : YHMColors.white.withOpacity(0.8),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      borderRadius: 12,
      borderColor: YHMHelperFunctions.isDarkMode(Get.context!)
          ? YHMColors.white.withOpacity(0.1) : YHMColors.black.withOpacity(0.1),
      borderWidth: 1.5,
      barBlur: 7,
      icon: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Transform.scale(
          alignment: Alignment.center,
          scale: 2.0, // Adjust the scale factor as needed
          child: Lottie.asset('assets/lottie/error.json',repeat: true,),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: YHMHelperFunctions.isDarkMode(Get.context!)
              ? Colors.black.withOpacity(0.15): Colors.grey.withOpacity(0.15),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ],
    );
  }
}
