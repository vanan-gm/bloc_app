import 'dart:io';

import 'package:bloc_app/core/common/entities/user_entity.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateUserAvatar implements UserCase<bool, UpdateAvatarParams>{
  final AuthRepository repository;
  UpdateUserAvatar({required this.repository});

  @override
  Future<Either<Failure, bool>> call(UpdateAvatarParams params) async{
    return await repository.updateUser(params.image, params.user);
  }

}

class UpdateAvatarParams{
  final UserEntity user;
  final File image;
  UpdateAvatarParams({required this.user, required this.image});
}