import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';

class AppStyle {
  AppStyle._();

  static TextStyle defaultStyle({
    double? fontSize,
    Color? textColor,
    FontWeight? fontWeight,
    bool useTextOverFlow = false,
  }) => TextStyle(
    fontSize: fontSize ?? AppConstants.textMediumSize,
    color: textColor ?? AppColors.white,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontFamily: 'Nunito',
    overflow: useTextOverFlow ? TextOverflow.ellipsis : null,
  );
}
