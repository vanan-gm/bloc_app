import 'dart:io';

import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> loginWithEmailPassword(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, bool>> updateUser(File image, UserEntity user);
}
