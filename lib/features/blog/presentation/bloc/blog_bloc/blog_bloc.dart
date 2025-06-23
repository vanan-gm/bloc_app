import 'dart:async';
import 'dart:io';

import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_all_blogs.dart';
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
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  final GetBlogCategories _getBlogCategories;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
    required GetBlogLikeState getBlogLikeState,
    required GetBlogCategories getBlogCategories,
  }) : _uploadBlog = uploadBlog,
       _getAllBlogs = getAllBlogs,
       _getBlogCategories = getBlogCategories,
       super(BlogInitialSate()) {
    on<BlogEvent>((_, emit) => emit(BlogLoadingState()));
    on<UploadBlogEvent>(_onBlogUploadEvent);
    on<GetAllBlogsEvent>(_onBlogGetAllBlogsEvent);
    on<GetBlogCategoriesEvent>(_onGetBlogCategoriesEvent);
  }

  FutureOr<void> _onBlogUploadEvent(
    UploadBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
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

  FutureOr<void> _onBlogGetAllBlogsEvent(
    GetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs.call(NoParams());
    res.fold(
      (failure) => emit(BlogFailureState(message: failure.message)),
      (blogs) => emit(BlogFetchedDataState(blogs: blogs)),
    );
  }

  FutureOr<void> _onGetBlogCategoriesEvent(
    GetBlogCategoriesEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getBlogCategories.call(NoParams());
    res.fold(
      (failure) => emit(BlogFailureState(message: failure.message)),
      (categories) => emit(BlogCategoriesFetchedState(categories: categories)),
    );
  }
}
