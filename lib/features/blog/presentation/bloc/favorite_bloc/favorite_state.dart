part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteBlogState {}

final class FavoriteBlogInitialSate extends FavoriteBlogState {}

final class FavoriteBlogLoadingState extends FavoriteBlogState {}

final class FavoriteBlogFailureState extends FavoriteBlogState {
  final String message;
  FavoriteBlogFailureState({required this.message});
}

final class FavoriteBlogsFetchedState extends FavoriteBlogState {
  final List<Blog> blogs;
  FavoriteBlogsFetchedState({required this.blogs});
}
