import 'dart:async';
import 'dart:io';

import 'package:bloc_app/core/common/utils/bloc_transformers.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blog_categories.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blog_like_state.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_keyword.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_user_id.dart';
import 'package:bloc_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  List<Blog> _blogs = [];
  final UploadBlog _uploadBlog;
  final GetBlogs _getBlogs;
  final GetBlogCategories _getBlogCategories;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetBlogs getBlogs,
    required GetBlogLikeState getBlogLikeState,
    required GetBlogCategories getBlogCategories,
  }) : _uploadBlog = uploadBlog,
       _getBlogs = getBlogs,
       _getBlogCategories = getBlogCategories,
       super(BlogInitialSate()) {
    on<UploadBlogEvent>(_onBlogUploadEvent);
    on<GetBlogsEvent>(_onBlogGetBlogsEvent, transformer: throttleDroppable());
    on<GetBlogCategoriesEvent>(_onGetBlogCategoriesEvent);
  }

  FutureOr<void> _onBlogUploadEvent(
    UploadBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoadingState());
    final res = await _uploadBlog.call(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        categoryIds: event.categoryIds,
      ),
    );
    res.fold(
      (failure) => emit(BlogFailureState(message: failure.message)),
      (blog) => emit(BlogSuccessState()),
    );
  }

  FutureOr<void> _onBlogGetBlogsEvent(
    GetBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    if (event.page == 1) {
      emit(BlogLoadingState());
    }
    final res = await _getBlogs.call(NormalParams(page: event.page));
    res.fold(
      (failure) => emit(BlogFailureState(message: failure.message)),
      (blogs){
        if(event.isRefresh){
          _blogs = blogs;
        }else{
          _blogs.addAll(blogs);
        }
        emit(BlogFetchedDataState(blogs: List.from(_blogs), hasReachedEnd: false));
      },
    );
  }

  FutureOr<void> _onGetBlogCategoriesEvent(
    GetBlogCategoriesEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoadingState());
    final res = await _getBlogCategories.call(NoParams());
    res.fold(
      (failure) => emit(BlogFailureState(message: failure.message)),
      (categories) => emit(BlogCategoriesFetchedState(categories: categories)),
    );
  }
}
