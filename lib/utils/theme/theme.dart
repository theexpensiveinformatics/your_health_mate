import 'package:flutter/material.dart';
import 'package:your_health_mate/utils/theme/widget_themes/appbar_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/chip_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/text_button_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/text_field_theme.dart';
import 'package:your_health_mate/utils/theme/widget_themes/text_theme.dart';
import '../constants/colors.dart';

class YHMAppTheme {
  YHMAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Satoshi',
    disabledColor: YHMColors.grey,
    brightness: Brightness.light,
    primaryColor: YHMColors.primary,
    textTheme: YHMTextTheme.lightTextTheme,
    textButtonTheme: YHMTextButtonTheme.lightTextButtonTheme,
    chipTheme: YHMChipTheme.lightChipTheme,
    scaffoldBackgroundColor: YHMColors.newScaffoldBackground,
    appBarTheme: YHMAppBarTheme.lightAppBarTheme,
    checkboxTheme: YHMCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: YHMBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: YHMElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: YHMOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: YHMTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Satoshi',
    disabledColor: YHMColors.grey,
    brightness: Brightness.dark,
    primaryColor: YHMColors.primary,
    textTheme: YHMTextTheme.darkTextTheme,
    chipTheme: YHMChipTheme.darkChipTheme,
    scaffoldBackgroundColor: YHMColors.black,
    appBarTheme: YHMAppBarTheme.darkAppBarTheme,
    checkboxTheme: YHMCheckboxTheme.darkCheckboxTheme,
    textButtonTheme: YHMTextButtonTheme.darkTextButtonTheme,
    bottomSheetTheme: YHMBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: YHMElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: YHMOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: YHMTextFormFieldTheme.darkInputDecorationTheme,
  );
}
