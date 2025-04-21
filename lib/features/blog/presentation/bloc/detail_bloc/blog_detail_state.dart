part of 'blog_detail_bloc.dart';

@immutable
sealed class BlogDetailState {}

final class BlogDetailInitialSate extends BlogDetailState {}

final class BlogDetailLoadingState extends BlogDetailState{}

final class BlogDetailFailureState extends BlogDetailState{
  final String message;
  BlogDetailFailureState({required this.message});
}

final class GetBlogDetailLikeStateSuccessState extends BlogDetailState{
  final LikeState state;
  GetBlogDetailLikeStateSuccessState({required this.state});
}

final class UpdateBlogDetailLikeStateSuccessState extends BlogDetailState{
  final LikeState state;
  UpdateBlogDetailLikeStateSuccessState({required this.state});
}
