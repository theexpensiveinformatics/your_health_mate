import 'package:flutter/material.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helper/helper_functions.dart';


class YHMLoginHeader extends StatelessWidget {
  const YHMLoginHeader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = YHMHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 100,
          width: 80,
          image: AssetImage(
              dark ? YHMImages.lightAppLogo : YHMImages.darkAppLogo),
        ),
        Text(
          YHMTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: YHMSizes.sm,
        ),
        Text(
          YHMTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
