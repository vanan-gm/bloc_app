import 'dart:io';

import 'package:bloc_app/core/common/entities/user_entity.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateUserAvatar implements UserCase<String, UpdateAvatarParams> {
  final AuthRepository authRepository;
  UpdateUserAvatar({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UpdateAvatarParams params) async {
    return await authRepository.updateUserAvatar(params.image, params.userId);
  }
}

class UpdateAvatarParams {
  final String userId;
  final File image;
  UpdateAvatarParams({required this.userId, required this.image});
}
