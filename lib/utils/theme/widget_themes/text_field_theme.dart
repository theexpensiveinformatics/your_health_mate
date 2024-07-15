import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class YHMTextFormFieldTheme {
  YHMTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: YHMColors.dark,
    suffixIconColor: YHMColors.darkGrey,
    filled: true,
    fillColor: YHMColors.white,
    // constraints: const BoxConstraints.expand(height: ),
    labelStyle: const TextStyle().copyWith(fontSize: YHMSizes.fontSizeMd, color: YHMColors.darkGrey),
    hintStyle: const TextStyle().copyWith(fontSize: YHMSizes.fontSizeSm, color: YHMColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: YHMColors.black.withOpacity(0.78)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0.78, color: YHMColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0.78, color: YHMColors.grey),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0.78, color: YHMColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0.78, color: YHMColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0.78, color: YHMColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: YHMColors.darkGrey,
    suffixIconColor: YHMColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: YHMSizes.fontSizeMd, color: YHMColors.darkGrey),
    hintStyle: const TextStyle().copyWith(fontSize: YHMSizes.fontSizeSm, color: YHMColors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: YHMColors.white.withOpacity(0.78)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: YHMColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: YHMColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: YHMColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: YHMColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(YHMSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: YHMColors.warning),
    ),
  );
}
