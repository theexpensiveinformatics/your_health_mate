import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:your_health_mate/features/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_button.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(YHMSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///Title
              Text(
                YHMTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: YHMSizes.spaceBtwSections,),

              ///Form
              const YHMSignUpForm(),

              const SizedBox(height: YHMSizes.spaceBtwSections,),

              ///Divider
              YHMFormDivider(dividerText: YHMTexts.orSignUpWith.capitalize!),
              const SizedBox(height: YHMSizes.spaceBtwSections,),

              ///Social Icons
              YHMSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
