part of 'search_bloc.dart';

abstract class SearchEvent {}

final class SearchBlogsEvent extends SearchEvent {
  final String keyword;
  SearchBlogsEvent({required this.keyword});
}

final class ClearSearchBlogsEvent extends SearchEvent {}
