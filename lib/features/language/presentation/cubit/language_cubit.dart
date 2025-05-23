import 'package:bloc_app/features/language/domain/repository/language_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  final LanguageRepository languageRepository;

  LanguageCubit({required this.languageRepository}) : super(Locale('en')) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final savedCode = languageRepository.getSavedLocale() ?? 'en';
    emit(Locale(savedCode));
  }

  Future<void> changeLocale(String localeCode) async {
    await languageRepository.setLocale(localeCode);
    emit(Locale(localeCode));
  }
}
