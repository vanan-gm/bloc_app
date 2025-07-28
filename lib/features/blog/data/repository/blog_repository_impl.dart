import 'dart:io';

import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/enums/update_state_type.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/network/connection_checker.dart';
import 'package:bloc_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:bloc_app/features/blog/data/models/blog_model.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> categoryIds,
  }) async {
    try {
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        categoryIds: categoryIds,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.updateBlogImage(
        image: image,
        blogModel: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final blogData = await blogRemoteDataSource.updateBlog(blogModel);
      return right(blogData);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogs({required int page}) async {
    try {
      // If there's no internet, we will display error
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final blogs = await blogRemoteDataSource.getBlogs(page: page);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogsByUserId(String userId) async {
    try {
      // If there's no internet, we will display errors
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final blogs = await blogRemoteDataSource.getBlogsByUserId(userId);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogsByKeyWord({required String keyword, required int page, required List<String> filterCategories}) async {
    try {
      // If there's no internet, we will display errors
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final blogs = await blogRemoteDataSource.getBlogsByKeyWord(keyword: keyword, page: page, filterCategories: filterCategories);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, LikeState>> getBlogLikeState(
    String blogId,
    String userId,
  ) async {
    try {
      // If there's no internet, we will display errors
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final state = await blogRemoteDataSource.getBlogLikeState(blogId, userId);
      return right(state);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, LikeState>> updateBlogLikeState(
    String blogId,
    String userId,
    UpdateStateType type,
  ) async {
    try {
      // If there's no internet, we will display errors
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final state = await blogRemoteDataSource.updateBlogLikeState(
        blogId,
        userId,
        type,
      );
      return right(state);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getFavoriteBlogs(String userId) async {
    try {
      // If there's no internet, we will display errors
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final blogModels = await blogRemoteDataSource.getFavoriteBlogs(userId);
      final blogs = blogModels.map((blog) => blog.toEntity()).toList();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogCategory>>> getBlogCategories() async {
    try {
      // If there's no internet, we will display errors
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }
      final categoryModels = await blogRemoteDataSource.getBlogCategories();
      final categories =
          categoryModels.map((category) => category.toEntity()).toList();
      return right(categories);
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }
}
