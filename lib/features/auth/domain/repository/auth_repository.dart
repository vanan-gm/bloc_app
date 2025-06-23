import 'dart:io';

import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  );

  Future<Either<Failure, User>> loginWithEmailPassword(
    String email,
    String password,
  );

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, String>> updateUserAvatar(File image, String userId);

  Future<Either<Failure, bool>> changePassword(
    String newPassword,
    String confirmPassword,
  );
}
