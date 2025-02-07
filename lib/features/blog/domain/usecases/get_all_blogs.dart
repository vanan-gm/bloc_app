import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UserCase<List<Blog>, NoParams>{
  final BlogRepository blogRepository;
  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{
    return await blogRepository.getAllBlogs();
  }

}