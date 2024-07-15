import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../styles/spacing_style.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});

  final String image,title,subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: YHMSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            // Image
            children: [
              // Image as same as verify_email screen
             Lottie.asset(image,width: MediaQuery.of(context).size.width *0.6,repeat: false),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),

              // Text and Subtitle as same as verify_email screen
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:onPressed,
                  child: Text(YHMTexts.YHMContinue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
