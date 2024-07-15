import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class YHMTermsAndConditionCheckbox extends StatelessWidget {
  const YHMTermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = YHMHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(height: 24, width: 24, child: Obx(()=> Checkbox(onChanged: (value)=> controller.privacyPolicy.value = !controller.privacyPolicy.value ,value: controller.privacyPolicy.value)), ),
        const SizedBox(width: YHMSizes.spaceBtwItems,),
        Text.rich(
            TextSpan( 
                children: [
                  TextSpan(text: '${YHMTexts.iAgreeTo} ',style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: '${YHMTexts.privacyPolicy}',style: Theme.of(context).textTheme.bodySmall!.apply(color: dark ? YHMColors.white : YHMColors.primary ,decoration: TextDecoration.underline ,decorationColor: dark ? YHMColors.white : YHMColors.primary)),
                  TextSpan(text: ' ${YHMTexts.and} ',style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: '${YHMTexts.termsOfUse}.',style: Theme.of(context).textTheme.bodySmall!.apply(color: dark ? YHMColors.white : YHMColors.primary ,decoration: TextDecoration.underline ,decorationColor: dark ? YHMColors.white : YHMColors.primary)),
                ]
            ),
        ),
      ],
    );
  }
}
