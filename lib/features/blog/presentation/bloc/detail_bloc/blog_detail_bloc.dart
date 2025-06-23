import 'dart:async';
import 'dart:io';

import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/enums/update_state_type.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blog_like_state.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_keyword.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_user_id.dart';
import 'package:bloc_app/features/blog/domain/usecases/update_blog_like_state.dart';
import 'package:bloc_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_detail_event.dart';

part 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  final GetBlogLikeState _getBlogLikeState;
  final UpdateBlogLikeState _updateBlogLikeState;

  BlogDetailBloc({
    required GetBlogLikeState getBlogLikeState,
    required UpdateBlogLikeState updateBlogLikeState,
  }) : _getBlogLikeState = getBlogLikeState,
       _updateBlogLikeState = updateBlogLikeState,
       super(BlogDetailInitialSate()) {
    on<BlogDetailEvent>((_, emit) => emit(BlogDetailLoadingState()));
    on<GetBlogLikeStateEvent>(_onGetBlogLikeStateEvent);
    on<UpdateBlogLikeStateEvent>(_onUpdateBlogLikeStateEvent);
  }

  FutureOr<void> _onGetBlogLikeStateEvent(
    GetBlogLikeStateEvent event,
    Emitter<BlogDetailState> emit,
  ) async {
    final res = await _getBlogLikeState.call(
      GetBlogLikeParam(blogId: event.blogId, userId: event.userId),
    );
    res.fold(
      (failure) => emit(BlogDetailFailureState(message: failure.message)),
      (state) => emit(BlogDetailFetchedLikeState(state: state)),
    );
  }

  FutureOr<void> _onUpdateBlogLikeStateEvent(
    UpdateBlogLikeStateEvent event,
    Emitter<BlogDetailState> emit,
  ) async {
    final res = await _updateBlogLikeState.call(
      UpdateBlogLikeParam(
        blogId: event.blogId,
        userId: event.userId,
        type: event.type,
      ),
    );
    res.fold(
      (failure) => emit(BlogDetailFailureState(message: failure.message)),
      (state) => emit(BlogDetailUpdatedLikeState(state: state)),
    );
  }
}
