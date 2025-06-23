part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class UploadBlogEvent extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> categoryIds;

  UploadBlogEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.categoryIds,
  });
}

final class GetAllBlogsEvent extends BlogEvent {}

final class GetBlogsByUserIdEvent extends BlogEvent {
  final String userId;
  GetBlogsByUserIdEvent({required this.userId});
}

final class GetBlogsByKeyWordEvent extends BlogEvent {
  final String key;
  GetBlogsByKeyWordEvent({required this.key});
}

final class GetBlogCategoriesEvent extends BlogEvent {}
