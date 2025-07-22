part of 'search_bloc.dart';

abstract class SearchEvent {}

final class FetchBlogsEvent extends SearchEvent{
  final int page;
  FetchBlogsEvent({required this.page});
}

final class SearchBlogsEvent extends SearchEvent {
  final String keyword;
  final int page;
  final bool isLoadingMore;
  SearchBlogsEvent({required this.keyword, required this.page, this.isLoadingMore = false});
}

final class ClearSearchBlogsEvent extends SearchEvent {}
