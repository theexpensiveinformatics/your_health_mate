import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../controllers/forget_password/forget_password_controller.dart';
import '../login/login.dart';



class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear))],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(YHMSizes.defaultSpace),
          child: Column(
            children: [
              // Image as same as verify_email screen
              Image(image: const AssetImage(YHMImages.successIllustration), width: YHMHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: YHMSizes.spaceBtwSections,),

              // Text and Subtitle as same as verify_email screen
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              const SizedBox(height: YHMSizes.spaceBtwItems,),
              Text(YHMTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: YHMSizes.spaceBtwSections,),
              Text(YHMTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),

              // Button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()) ,child: const Text(YHMTexts.done),
                ),
              ),
              const SizedBox(height: YHMSizes.spaceBtwItems,),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),child: const Text(YHMTexts.resendEmail),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
