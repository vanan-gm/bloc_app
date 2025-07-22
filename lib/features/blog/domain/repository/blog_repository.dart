import 'dart:io';

import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/enums/update_state_type.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:fpdart/fpdart.dart';

abstract class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> categoryIds,
  });

  Future<Either<Failure, List<Blog>>> getBlogs({required int page});
  Future<Either<Failure, List<Blog>>> getBlogsByUserId(String userId);
  Future<Either<Failure, List<Blog>>> getBlogsByKeyWord({required String keyword, required int page});
  Future<Either<Failure, LikeState>> getBlogLikeState(
    String blogId,
    String userId,
  );
  Future<Either<Failure, LikeState>> updateBlogLikeState(
    String blogId,
    String userId,
    UpdateStateType type,
  );
  Future<Either<Failure, List<Blog>>> getFavoriteBlogs(String userId);
  Future<Either<Failure, List<BlogCategory>>> getBlogCategories();
}
