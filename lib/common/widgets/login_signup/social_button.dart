import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../features/authentication/controllers/login/login_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/loaders.dart';

class YHMSocialButton extends StatelessWidget {
  const YHMSocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: YHMColors.grey),borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed:() {controller.googleSignIn();},
            icon: const Image(
              width: YHMSizes.iconMd,
              height: YHMSizes.iconMd,
              image: AssetImage(YHMImages.googleLogo),
            ),
          ),
        ),

        const SizedBox(width: YHMSizes.spaceBtwItems,),

        Container(
          decoration: BoxDecoration(border: Border.all(color: YHMColors.grey),borderRadius: BorderRadius.circular(100)),
          child: IconButton(

            onPressed:() {YHMLoaders.successSnackBar(title: 'Successfully Account Created',message: 'Data uploaded on firebase with your security');},
            icon: const Image(
              width: YHMSizes.iconMd,
              height: YHMSizes.iconMd,
              image: AssetImage(YHMImages.facebookLogo),
            ),
          ),
        ),
      ],
    );
  }
}