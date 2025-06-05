import 'package:bloc_app/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  final SettingsRepository settingsRepository;

  LanguageCubit({required this.settingsRepository}) : super(Locale('en')) {
    loadSavedLocale();
  }

  void loadSavedLocale() async {
    try {
      final savedCode = settingsRepository.getSavedLocale() ?? 'en';
      await Future.delayed(Duration.zero);
      emit(Locale(savedCode));
    } catch (e) {}
  }

  Future<void> changeLocale(String localeCode) async {
    await settingsRepository.setLocale(localeCode);
    emit(Locale(localeCode));
  }
}
