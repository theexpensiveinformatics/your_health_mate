import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';

class RoundIconContainer extends StatelessWidget{
   RoundIconContainer({super.key, required this.icon});
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(color: YHMColors.grey.withOpacity(0.8))
      ),
      child: Icon(icon,size: 20,),
    );
  }

}