import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_style.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppFlexTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // Using FlexColorScheme built-in FlexScheme enum based colors
    scheme: FlexScheme.purpleM3,
    // Component theme configurations for light mode.
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: AppConstants.borderButton,
      inputDecoratorBorderSchemeColor: SchemeColor.onPrimary,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // Using FlexColorScheme built-in FlexScheme enum based colors.
    scheme: FlexScheme.purpleM3,
    // Component theme configurations for dark mode.
    textTheme: textTheme,
    subThemesData: FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: AppConstants.borderButton,
      inputDecoratorBorderSchemeColor: SchemeColor.onPrimary,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

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
}
