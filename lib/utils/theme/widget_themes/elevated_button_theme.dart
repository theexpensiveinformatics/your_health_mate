import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class YHMElevatedButtonTheme {
  YHMElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: YHMColors.light,
      backgroundColor: YHMColors.primary,
      disabledForegroundColor: YHMColors.darkGrey,
      disabledBackgroundColor: YHMColors.buttonDisabled,
      side: const BorderSide(color: YHMColors.primary),
      padding: const EdgeInsets.symmetric(vertical: YHMSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16,
          color: YHMColors.textWhite,
          fontWeight: FontWeight.w600,
          fontFamily: 'Satoshi'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(YHMSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: YHMColors.light,
      backgroundColor: YHMColors.primary,
      disabledForegroundColor: YHMColors.darkGrey,
      disabledBackgroundColor: YHMColors.darkerGrey,
      side: const BorderSide(color: YHMColors.primary),
      padding: const EdgeInsets.symmetric(
        vertical: YHMSizes.buttonHeight,
      ),
      textStyle: const TextStyle(
          fontSize: 16,
          color: YHMColors.textWhite,
          fontWeight: FontWeight.w600,
          fontFamily: 'Satoshi'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(YHMSizes.buttonRadius)),
    ),
  );
}
