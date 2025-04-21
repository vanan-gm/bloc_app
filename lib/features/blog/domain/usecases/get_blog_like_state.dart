import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogLikeState implements UserCase<LikeState, GetBlogLikeParam>{
  final BlogRepository repository;
  GetBlogLikeState({required this.repository});

  @override
  Future<Either<Failure, LikeState>> call(GetBlogLikeParam params) async{
    return repository.getBlogLikeState(params.blogId, params.userId);
  }

}

class GetBlogLikeParam{
  final String blogId;
  final String userId;
  const GetBlogLikeParam({required this.blogId, required this.userId});
}