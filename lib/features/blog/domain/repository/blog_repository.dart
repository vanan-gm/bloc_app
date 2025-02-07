import 'dart:io';

import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
