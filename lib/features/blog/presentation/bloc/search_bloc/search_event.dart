part of 'search_bloc.dart';

abstract class SearchEvent {}

final class SearchBlogsEvent extends SearchEvent {
  final String keyword;
  final int page;
  final bool isLoadingMore;
  final List<String> filterCategories;
  SearchBlogsEvent({this.keyword = "", required this.page, this.isLoadingMore = false, this.filterCategories = const []});
}

final class ClearSearchBlogsEvent extends SearchEvent {}
