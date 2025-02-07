import 'dart:async';
import 'dart:io';

import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloc_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitialSate()) {
    on<BlogEvent>((_, emit) => emit(BlogLoadingState()));
    on<BlogUploadEvent>(_onBlogUploadEvent);
    on<BlogGetAllBlogsEvent>(_onBlogGetAllBlogsEvent);
  }

  FutureOr<void> _onBlogUploadEvent(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog.call(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    res.fold((failure) => emit(BlogFailureState(message: failure.message)),
        (blog) => emit(BlogSuccessState()));
  }

  FutureOr<void> _onBlogGetAllBlogsEvent(
      BlogGetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs.call(NoParams());
    res.fold((failure) => emit(BlogFailureState(message: failure.toString())),
        (blogs) => emit(BlogGetAllSuccessState(blogs: blogs)));
  }
}
