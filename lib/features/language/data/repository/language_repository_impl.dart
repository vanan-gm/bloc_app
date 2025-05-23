import 'package:bloc_app/core/common/service/shared_preference_service.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/language/domain/repository/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final SharedPreferenceService service;
  LanguageRepositoryImpl({required this.service});

  @override
  String? getSavedLocale() {
    return service.getData(AppConstants.appLocale);
  }

  @override
  Future<void> setLocale(String localeCode) async {
    await service.setData(AppConstants.appLocale, localeCode);
  }
}
