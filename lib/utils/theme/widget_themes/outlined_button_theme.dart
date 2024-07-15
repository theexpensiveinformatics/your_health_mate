import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class YHMOutlinedButtonTheme {
  YHMOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      backgroundColor: YHMColors.white,
      foregroundColor: YHMColors.dark,
      side: const BorderSide(color: YHMColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: YHMColors.black, fontWeight: FontWeight.w600,fontFamily: 'Satoshi'),
      padding: const EdgeInsets.symmetric(vertical: YHMSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(YHMSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: YHMColors.light,
      side: const BorderSide(color: YHMColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: YHMColors.textWhite, fontWeight: FontWeight.w600,fontFamily: 'Satoshi'),
      padding: const EdgeInsets.symmetric(vertical: YHMSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(YHMSizes.buttonRadius)),
    ),
  );
}
