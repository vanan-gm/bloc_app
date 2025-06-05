import 'package:bloc_app/core/enums/theme_mode.dart';

abstract class SettingsRepository {
  Future<void> setLocale(String localeCode);
  String? getSavedLocale();

  Future<void> setTheme(ThemeMode theme);
  ThemeMode getSavedTheme();
}
