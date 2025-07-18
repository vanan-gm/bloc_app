part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitialSate extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogSearchLoadingState extends BlogState {}

final class BlogFailureState extends BlogState {
  final String message;
  BlogFailureState({required this.message});
}

final class BlogSuccessState extends BlogState {}

final class BlogFetchedDataState extends BlogState {
  final List<Blog> blogs;
  final bool hasReachedEnd;
  BlogFetchedDataState({required this.blogs, required this.hasReachedEnd});
}

final class BlogsFetchedByUserIdState extends BlogState {
  final List<Blog> blogs;
  BlogsFetchedByUserIdState({required this.blogs});
}

final class BlogsFetchedByKeywordState extends BlogState {
  final List<Blog> blogs;
  BlogsFetchedByKeywordState({required this.blogs});
}

final class BlogCategoriesFetchedState extends BlogState {
  final List<BlogCategory> categories;
  BlogCategoriesFetchedState({required this.categories});
}
