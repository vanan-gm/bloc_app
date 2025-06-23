import 'package:bloc_app/core/enums/theme_mode.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';

abstract class SettingsRepository {
  Future<void> setLocale(String localeCode);
  String? getSavedLocale();

  Future<void> setTheme(ThemeMode theme);
  ThemeMode getSavedTheme();

  Future<void> setBlogCategories(List<BlogCategory> categories);
  List<BlogCategory> getBlogCategories();
}
