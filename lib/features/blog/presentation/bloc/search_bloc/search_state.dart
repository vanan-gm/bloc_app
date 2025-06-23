part of 'search_bloc.dart';

abstract class SearchState {}

final class SearchBlogsInitialState extends SearchState {}

final class SearchBlogsLoadingState extends SearchState {}

final class SearchBlogsFetchedState extends SearchState {
  final List<Blog> blogs;
  SearchBlogsFetchedState({required this.blogs});
}

final class SearchBlogsFailureState extends SearchState {
  final String message;
  SearchBlogsFailureState({required this.message});
}

final class ClearSearchBlogsSuccessState extends SearchState {}
