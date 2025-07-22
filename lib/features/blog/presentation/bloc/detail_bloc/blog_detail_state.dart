part of 'blog_detail_bloc.dart';

@immutable
sealed class BlogDetailState {}

final class BlogDetailInitialSate extends BlogDetailState {}

final class BlogDetailLoadingState extends BlogDetailState {}

final class BlogDetailFailureState extends BlogDetailState {
  final String message;
  BlogDetailFailureState({required this.message});
}

final class BlogDetailFetchedLikeState extends BlogDetailState {
  final LikeState state;
  BlogDetailFetchedLikeState({required this.state});
}

final class BlogDetailUpdatedLikeState extends BlogDetailState {
  final LikeState state;
  BlogDetailUpdatedLikeState({required this.state});
}
