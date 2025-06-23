import 'package:bloc_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.categoryIds,
    required super.updatedAt,
    super.posterName,
    super.posterImage,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json["id"] ?? 0,
      posterId: json["poster_id"] ?? 0,
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      imageUrl: json["image_url"] ?? "",
      categoryIds: List<String>.from(json["category_ids"] ?? []),
      updatedAt:
          json["updated_at"] == null
              ? DateTime.now()
              : DateTime.parse(json["updated_at"]),
    );
  }

  factory BlogModel.fromEntity(Blog blog) {
    return BlogModel(
      id: blog.id,
      posterId: blog.posterId,
      title: blog.title,
      content: blog.content,
      imageUrl: blog.imageUrl,
      categoryIds: blog.categoryIds,
      updatedAt: blog.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "poster_id": posterId,
      "title": title,
      "content": content,
      "image_url": imageUrl,
      "category_ids": categoryIds,
      "updated_at": updatedAt.toIso8601String(),
    };
  }

  Blog toEntity() => Blog(
    id: id,
    posterId: posterId,
    title: title,
    content: content,
    imageUrl: imageUrl,
    categoryIds: categoryIds,
    updatedAt: updatedAt,
  );

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? categoryIds,
    DateTime? updatedAt,
    String? posterName,
    String? posterImage,
  }) => BlogModel(
    id: id ?? this.id,
    posterId: posterId ?? this.posterId,
    title: title ?? this.title,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    categoryIds: categoryIds ?? this.categoryIds,
    updatedAt: updatedAt ?? this.updatedAt,
    posterName: posterName ?? this.posterName,
    posterImage: posterImage ?? this.posterImage,
  );
}
