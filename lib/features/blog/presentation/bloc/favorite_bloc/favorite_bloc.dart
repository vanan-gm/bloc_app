import 'dart:async';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_favorite_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBlogBloc extends Bloc<FavoriteBlogEvent, FavoriteBlogState> {
  final GetFavoriteBlogs _favoriteBlogs;

  FavoriteBlogBloc({required GetFavoriteBlogs favoriteBlogs})
    : _favoriteBlogs = favoriteBlogs,
      super(FavoriteBlogInitialSate()) {
    on<FavoriteBlogEvent>((_, emit) => emit(FavoriteBlogLoadingState()));
    on<GetAllFavoriteBlogsEvent>(_onFavoriteBlogGetAllEvent);
  }

  FutureOr<void> _onFavoriteBlogGetAllEvent(
    GetAllFavoriteBlogsEvent event,
    Emitter<FavoriteBlogState> emit,
  ) async {
    final res = await _favoriteBlogs.call(event.userId);
    res.fold(
      (failure) => emit(FavoriteBlogFailureState(message: failure.toString())),
      (blogs) => emit(FavoriteBlogsFetchedState(blogs: blogs)),
    );
  }
}
