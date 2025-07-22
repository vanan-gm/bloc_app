import 'dart:ui';

extension LocaleExt on Locale {
  bool get isVietnamese => languageCode.toLowerCase() == 'vi';
  bool get isEnglish => languageCode.toLowerCase() == 'en';
}
