import 'dart:async';

import 'package:bloc_app/core/common/utils/bloc_transformers.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_keyword.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_user_id.dart';

part 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Blog> _blogs = [];
  final GetBlogsByKeyWord _getBlogsByKeyWord;
  final GetBlogs _getBlogs;

  SearchBloc({
    required GetBlogsByKeyWord getBlogsByKeyWord,
    required GetBlogs getBlogs,
  }) : _getBlogsByKeyWord = getBlogsByKeyWord,
       _getBlogs = getBlogs,
       super(SearchBlogsInitialState()) {
    on<SearchBlogsEvent>(_onSearchBlogsEvent);
    on<FetchBlogsEvent>(_onFetchBlogsEvent, transformer: throttleDroppable());
    on<ClearSearchBlogsEvent>(_onClearSearchBlogsEvent);
  }

  FutureOr<void> _onSearchBlogsEvent(
    SearchBlogsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if(event.page == 1){
      emit(SearchBlogsLoadingState());
    }
    final res = await _getBlogsByKeyWord.call(SearchParams(keyword: event.keyword, page: event.page));
    res.fold(
      (failure) => emit(SearchBlogsFailureState(message: failure.message)),
      (blogs){
        if(!event.isLoadingMore) _blogs.clear();
        _blogs.addAll(blogs);
        emit(SearchBlogsFetchedState(blogs: List.from(_blogs), hasReachedEnd: false));
      },
    );
  }

  FutureOr<void> _onClearSearchBlogsEvent(
    ClearSearchBlogsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(ClearSearchBlogsSuccessState());
  }

  FutureOr<void> _onFetchBlogsEvent(
    FetchBlogsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if(event.page == 1){
      emit(SearchBlogsLoadingState());
    }
    final res = await _getBlogs.call(NormalParams(page: event.page));
    res.fold(
      (failure) => emit(SearchBlogsFailureState(message: failure.message)),
      (blogs){
        _blogs.addAll(blogs);
        emit(SearchBlogsFetchedState(blogs: List.from(_blogs), hasReachedEnd: false));
      },
    );
  }
}
