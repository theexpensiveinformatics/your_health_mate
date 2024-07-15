import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({
    super.key, required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: YHMColors.grey,
      thickness: 0.6,
    );
  }
}