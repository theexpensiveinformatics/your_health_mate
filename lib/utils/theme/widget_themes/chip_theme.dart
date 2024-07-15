import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class YHMChipTheme {
  YHMChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: YHMColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: YHMColors.black),
    selectedColor: YHMColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: YHMColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: YHMColors.darkerGrey,
    labelStyle: TextStyle(color: YHMColors.white),
    selectedColor: YHMColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: YHMColors.white,
  );
}
