import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/core/common/entities/user_entity.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UserCase<UserEntity, NoParams>{
  final AuthRepository authRepository;
  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async{
    return await authRepository.getCurrentUser();
  }
}

