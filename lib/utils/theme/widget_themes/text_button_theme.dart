import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class YHMTextButtonTheme {
  YHMTextButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightTextButtonTheme = TextButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: YHMColors.dark,
      elevation: 0,
      textStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: YHMColors.dark,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: YHMSizes.buttonHeight, horizontal: 20),
    ),
  );

  /* -- Dark Theme -- */
  static final darkTextButtonTheme = TextButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: YHMColors.light,
      textStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: YHMColors.light,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: YHMSizes.buttonHeight, horizontal: 20),
    ),
  );
}
