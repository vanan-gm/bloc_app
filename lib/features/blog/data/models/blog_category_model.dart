import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';

class BlogCategoryModel {
  final String categoryId;
  final String titleEn;
  final String titleVi;
  final DateTime createdAt;

  BlogCategoryModel({
    required this.categoryId,
    required this.titleEn,
    required this.titleVi,
    required this.createdAt,
  });

  factory BlogCategoryModel.fromEntity(BlogCategory entity) {
    return BlogCategoryModel(
      categoryId: entity.categoryId,
      titleEn: entity.titleEn,
      titleVi: entity.titleVi,
      createdAt: entity.createdAt,
    );
  }

  BlogCategory toEntity() => BlogCategory(
    categoryId: categoryId,
    titleEn: titleEn,
    titleVi: titleVi,
    createdAt: createdAt,
  );

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'titleEn': titleEn,
    'titleVi': titleVi,
    'createdAt': createdAt.toIso8601String(),
  };

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) {
    return BlogCategoryModel(
      categoryId: json['category_id'],
      titleEn: json['title_en'],
      titleVi: json['title_vi'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
