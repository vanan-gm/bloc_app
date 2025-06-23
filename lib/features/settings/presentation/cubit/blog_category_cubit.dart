import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogCategoryCubit extends Cubit<List<BlogCategory>> {
  final SettingsRepository settingsRepository;

  BlogCategoryCubit({required this.settingsRepository}) : super([]) {
    loadStoredBlogCategories();
  }

  void loadStoredBlogCategories() async {
    try {
      final categories = settingsRepository.getBlogCategories() ?? [];
      emit(categories);
    } catch (e) {}
  }

  Future<void> setDataForBlogCategories(List<BlogCategory> categories) async {
    await settingsRepository.setBlogCategories(categories);
    emit(categories);
  }
}
