import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helper/helper_functions.dart';

class YHMFormDivider extends StatelessWidget {
  const YHMFormDivider({
    super.key, required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = YHMHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Flexible(child: Divider(color: dark ? YHMColors.darkGrey : YHMColors.grey,thickness: 0.5,indent: 60,endIndent: 5,)),
        Text(dividerText,style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color: dark ? YHMColors.darkGrey : YHMColors.grey,thickness: 0.5,indent: 5,endIndent: 60,)),
      ],
    );
  }
}
