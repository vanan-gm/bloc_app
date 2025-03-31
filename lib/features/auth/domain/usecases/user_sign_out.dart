import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UserCase<void, NoParams>{
  final AuthRepository authRepository;
  const UserSignOut({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async{
    return await authRepository.signOut();
  }
}