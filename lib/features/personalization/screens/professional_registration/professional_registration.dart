import 'package:flutter/material.dart';
import 'package:your_health_mate/features/personalization/screens/professional_registration/widgets/register_pro_form.dart';
import 'package:your_health_mate/features/personalization/screens/professional_registration/widgets/register_pro_header.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../utils/constants/sizes.dart';


class ProfessionalRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: YHMSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              ///-- Heading
              const RegisterAsAProHeader(),

              const SizedBox(
                height: YHMSizes.spaceBtwItems,
              ),

              ///-- Taking Details Form
               RegisterProForm()
            ],
          ),
        ),
      ),
    );
  }

}
