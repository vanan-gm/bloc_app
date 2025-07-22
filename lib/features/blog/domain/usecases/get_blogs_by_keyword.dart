import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogsByKeyWord implements UserCase<List<Blog>, SearchParams>{
  final BlogRepository blogRepository;
  GetBlogsByKeyWord({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(SearchParams params) async{
    return await blogRepository.getBlogsByKeyWord(page: params.page, keyword: params.keyword);
  }

}