import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../utils/constants/colors.dart';

class YHMCellLayout extends StatelessWidget {
  const YHMCellLayout({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.firstColor,
    required this.secondColor,
    this.topPadding = 6.0,
    this.bottomPadding = 6.0,
    this.leftPadding = 10.0,
    this.rightPadding = 14.0,
    this.radius = 14.0,
  });

  final String text;
  final IconData icon;
  final Color iconColor;
  final Color firstColor;
  final Color secondColor;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: secondColor.withOpacity(0.5), width: 0.8),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  firstColor,
                  secondColor
                ]),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: leftPadding,right: rightPadding,top: topPadding,bottom: bottomPadding),
            child: Row(
              children: [
                Icon(icon,size: 20,color: iconColor,),
                SizedBox(width: 7,),
                Text(text,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: iconColor,fontSize: 12),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
