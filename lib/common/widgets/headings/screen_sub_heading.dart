import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';


class ScreenSubHeading extends StatelessWidget {
  const ScreenSubHeading({
    super.key,
    required this.title,  this.size=23,
  });

  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: YHMSizes.spaceBtwItems),
        child: Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: size),
    ));
  }
}
