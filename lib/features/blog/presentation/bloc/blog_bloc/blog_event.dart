part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUploadEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

final class BlogGetAllBlogsEvent extends BlogEvent{}

final class BlogGetBlogsByUserIdEvent extends BlogEvent{
  final String userId;
  BlogGetBlogsByUserIdEvent({required this.userId});
}

final class BlogGetBlogsByKeyWordEvent extends BlogEvent{
  final String key;
  BlogGetBlogsByKeyWordEvent({required this.key});
}
