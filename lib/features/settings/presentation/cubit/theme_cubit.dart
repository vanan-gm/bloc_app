import 'package:bloc_app/core/enums/theme_mode.dart';
import 'package:bloc_app/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SettingsRepository settingsRepository;

  ThemeCubit({required this.settingsRepository}) : super(ThemeMode.darkMode) {
    loadSavedTheme();
  }

  void loadSavedTheme() async {
    try {
      final savedTheme = settingsRepository.getSavedTheme();
      await Future.delayed(Duration.zero);
      emit(savedTheme);
    } catch (e) {}
  }

  Future<void> changeTheme(ThemeMode theme) async {
    await settingsRepository.setTheme(theme);
    emit(theme);
  }
}
