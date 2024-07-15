import 'package:flutter/cupertino.dart';
import 'package:get/get.dart%20%20';

import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/password_configuration/reset_password.dart';


class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      YHMFullScreenLoader.openLoadingDialog('Processing your request...', YHMImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {YHMFullScreenLoader.stopLoading(); return;}

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()){
        YHMFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Remove Loader
      YHMFullScreenLoader.stopLoading();
      
      // Show Success Screen
      YHMLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));

    } catch (e) {
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail (String email) async {
    try {
      // Start Loading
      YHMFullScreenLoader.openLoadingDialog('Processing your request...', YHMImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {YHMFullScreenLoader.stopLoading(); return;}


      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Remove Loader
      YHMFullScreenLoader.stopLoading();

      // Show Success Screen
      YHMLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);



    } catch (e) {
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}