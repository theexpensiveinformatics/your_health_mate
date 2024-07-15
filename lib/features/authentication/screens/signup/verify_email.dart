import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../controllers/signup/verify_email_controller.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () =>AuthenticationRepository.instance.logout(),
              icon: const Icon(Icons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(YHMSizes.defaultSpace),
          child: Column(
            children: [
              //IMAGE
              Image(
                image: AssetImage(YHMImages.verificationIllustration),
                width: YHMHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),

              // Title and Subtitle
              Text(
                YHMTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),
              Text(
                email ?? ' ',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: YHMSizes.spaceBtwSections),
              Text(
                YHMTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>controller.checkEmailVerificationStatus(),
                  child: Text(YHMTexts.YHMContinue),
                ),
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>controller.sendEmailVerification(),
                  child: Text(YHMTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
