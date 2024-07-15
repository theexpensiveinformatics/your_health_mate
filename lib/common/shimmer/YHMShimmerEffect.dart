import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helper/helper_functions.dart';

class YHMShimmerEffect extends StatelessWidget{
  const YHMShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this. radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = YHMHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 800),
      baseColor: dark? Colors.grey[850]! : Colors.grey[100]!,
      highlightColor: dark? Colors.grey[700]! : Colors.grey[50]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? YHMColors.darkerGrey : YHMColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}