import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangePassword implements UserCase<bool, ChangePasswordParams> {
  final AuthRepository authRepository;
  ChangePassword({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(ChangePasswordParams params) async {
    return authRepository.changePassword(
      params.newPassword,
      params.confirmPassword,
    );
  }
}

class ChangePasswordParams {
  final String newPassword;
  final String confirmPassword;
  ChangePasswordParams({
    required this.newPassword,
    required this.confirmPassword,
  });
}
