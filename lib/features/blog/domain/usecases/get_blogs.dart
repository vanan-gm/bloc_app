import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogs implements UserCase<List<Blog>, NormalParams>{
  final BlogRepository blogRepository;
  GetBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NormalParams params) async{
    return await blogRepository.getBlogs(page: params.page);
  }
}