part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitialSate extends BlogState {}

final class BlogLoadingState extends BlogState{}

final class BlogFailureState extends BlogState{
  final String message;
  BlogFailureState({required this.message});
}

final class BlogSuccessState extends BlogState{}

final class BlogGetAllSuccessState extends BlogState{
  final List<Blog> blogs;
  BlogGetAllSuccessState({required this.blogs});
}
