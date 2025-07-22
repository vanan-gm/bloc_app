import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/enums/update_state_type.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBlogLikeState implements UserCase<LikeState, UpdateBlogLikeParam>{
  final BlogRepository repository;
  UpdateBlogLikeState({required this.repository});

  @override
  Future<Either<Failure, LikeState>> call(UpdateBlogLikeParam params) async{
    return repository.updateBlogLikeState(params.blogId, params.userId, params.type);
  }

}

class UpdateBlogLikeParam{
  final String blogId;
  final String userId;
  final UpdateStateType type;
  const UpdateBlogLikeParam({required this.blogId, required this.userId, required this.type});
}