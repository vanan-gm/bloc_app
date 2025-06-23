import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_keyword.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_user_id.dart';

part 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetBlogsByKeyWord _getBlogsByKeyWord;

  SearchBloc({required GetBlogsByKeyWord getBlogsByKeyWord})
    : _getBlogsByKeyWord = getBlogsByKeyWord,
      super(SearchBlogsInitialState()) {
    on<SearchEvent>((_, emit) => emit(SearchBlogsLoadingState()));
    on<SearchBlogsEvent>(_onSearchBlogsEvent);
    on<ClearSearchBlogsEvent>(_onClearSearchBlogsEvent);
  }

  FutureOr<void> _onSearchBlogsEvent(
    SearchBlogsEvent event,
    Emitter<SearchState> emit,
  ) async {
    final res = await _getBlogsByKeyWord.call(event.keyword);
    res.fold(
      (failure) => emit(SearchBlogsFailureState(message: failure.message)),
      (blogs) => emit(SearchBlogsFetchedState(blogs: blogs)),
    );
  }

  FutureOr<void> _onClearSearchBlogsEvent(
    ClearSearchBlogsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(ClearSearchBlogsSuccessState());
  }
}
