import 'package:flutter/material.dart';
import 'package:your_health_mate/features/authentication/screens/login/widgets/login_form.dart';
import 'package:your_health_mate/features/authentication/screens/login/widgets/login_header.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_button.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helper/helper_functions.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///used to check dark mode is enable or not
    final dark = YHMHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
           padding: YHMSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo , Title & Sub Title
              const YHMLoginHeader(),

              ///Form
              const YHMLoginForm(),

              ///Divider
              const YHMFormDivider(
                dividerText: YHMTexts.orSignInWith,
              ),

              const SizedBox(
                height: YHMSizes.spaceBtwSections,
              ),

              /// Footer
              const YHMSocialButton(),

              ///
            ],
        ),
      )),
    );
  }
}
