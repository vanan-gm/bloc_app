import 'package:bloc_app/core/common/extensions/string_ext.dart';
import 'package:bloc_app/core/common/service/shared_preference_service.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/theme_mode.dart';
import 'package:bloc_app/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferenceService service;
  SettingsRepositoryImpl({required this.service});

  @override
  String? getSavedLocale() {
    return service.getData<String>(AppConstants.appLocale);
  }

  @override
  Future<void> setLocale(String localeCode) async {
    await service.setData<String>(AppConstants.appLocale, localeCode);
  }

  @override
  ThemeMode getSavedTheme() {
    return service.getData<String>(AppConstants.appTheme).getAppTheme;
  }

  @override
  Future<void> setTheme(ThemeMode theme) async {
    await service.setData<String>(
      AppConstants.appTheme,
      theme.toString().toLowerCase(),
    );
  }
}
