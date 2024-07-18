import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/newTheme/new_text_theme.dart';

class YHMTreatmentItemLayout extends StatelessWidget {
  const YHMTreatmentItemLayout({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: YHMColors.newDarkTreatment,
            borderRadius: BorderRadius.circular(100)
        ),
        height: 60,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(title,style: NewTextTheme.medium!.copyWith(fontSize: 15,color: YHMColors.newSecondaryTreatment),),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: YHMColors.newLightTreatment,borderRadius: BorderRadius.circular(100)),
                child: Icon(Iconsax.arrow_right_1),),
            ),

          ],
        ),
      ),
    );
  }
}
