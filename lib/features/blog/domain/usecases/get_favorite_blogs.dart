import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetFavoriteBlogs implements UserCase<List<Blog>, String>{
  final BlogRepository repository;
  GetFavoriteBlogs({required this.repository});

  @override
  Future<Either<Failure, List<Blog>>> call(String params) async{
    return repository.getFavoriteBlogs(params);
  }

}