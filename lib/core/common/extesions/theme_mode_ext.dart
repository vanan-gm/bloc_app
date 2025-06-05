import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/theme_mode.dart';

extension ThemeModeExt on ThemeMode {
  String get getThemeString =>
      this == ThemeMode.lightMode
          ? AppConstants.lightTheme
          : AppConstants.darkTheme;

  bool get isLightMode => this == ThemeMode.lightMode;
  bool get isDarkMode => this == ThemeMode.darkMode;
}
