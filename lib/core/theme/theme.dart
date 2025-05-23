import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/core/theme/app_style.dart';

class AppTheme {
  static customBorder({Color color = AppColors.borderColor}) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      );

  static style({double? fontSize}) => AppStyle.defaultStyle(fontSize: fontSize);

  static get textTheme => TextTheme(
    displayLarge: style(fontSize: AppConstants.textEnormousSize),
    displayMedium: style(fontSize: AppConstants.textGiantSize),
    displaySmall: style(fontSize: AppConstants.textHugeSize),

    titleLarge: style(fontSize: AppConstants.textBigSize),
    titleMedium: style(fontSize: AppConstants.textLargeSize),
    titleSmall: style(fontSize: AppConstants.textMediumLargeSize),

    bodyLarge: style(fontSize: AppConstants.textMediumSize),
    bodyMedium: style(fontSize: AppConstants.textSmallSize),
    bodySmall: style(fontSize: AppConstants.textTinySize),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppConstants.paddingMediumSmall),
      enabledBorder: customBorder(),
      border: customBorder(),
      focusedBorder: customBorder(color: AppColors.gradient1),
    ),
  );

  static final lightThemeMode1 = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme.apply(bodyColor: Colors.black87),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(Color(0xFFF2F2F2)),
      side: BorderSide.none,
      labelStyle: TextStyle(color: Colors.black87),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppConstants.paddingMediumSmall),
      enabledBorder: customBorder(color: Colors.grey),
      border: customBorder(color: Colors.grey),
      focusedBorder: customBorder(color: AppColors.gradient1),
    ),
  );

  static final lightThemeMode2 = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFFDFBFF), // slightly warm white
    textTheme: textTheme.apply(bodyColor: Colors.black87),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFDFBFF),
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(Color(0xFFEDE7F6)), // lavender tone
      side: BorderSide.none,
      labelStyle: TextStyle(color: Colors.black87),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppConstants.paddingMediumSmall),
      enabledBorder: customBorder(color: Color(0xFFBDBDBD)),
      border: customBorder(color: Color(0xFFBDBDBD)),
      focusedBorder: customBorder(color: AppColors.gradient1),
    ),
  );
}
