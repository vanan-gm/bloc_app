part of 'blog_detail_bloc.dart';

@immutable
sealed class BlogDetailEvent {}

final class GetBlogLikeStateEvent extends BlogDetailEvent{
  final String blogId;
  final String userId;
  GetBlogLikeStateEvent({required this.blogId, required this.userId});
}

final class UpdateBlogLikeStateEvent extends BlogDetailEvent{
  final String blogId;
  final String userId;
  final UpdateStateType type;
  UpdateBlogLikeStateEvent({required this.blogId, required this.userId, required this.type});
}
