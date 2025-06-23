import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogCategories implements UserCase<List<BlogCategory>, NoParams> {
  final BlogRepository repository;
  GetBlogCategories({required this.repository});

  @override
  Future<Either<Failure, List<BlogCategory>>> call(NoParams params) async {
    return await repository.getBlogCategories();
  }
}
