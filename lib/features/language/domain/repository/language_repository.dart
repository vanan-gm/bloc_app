abstract class LanguageRepository {
  Future<void> setLocale(String localeCode);
  String? getSavedLocale();
}
