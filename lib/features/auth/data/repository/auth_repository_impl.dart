import 'dart:io';

import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/network/connection_checker.dart';
import 'package:bloc_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bloc_app/core/common/entities/user.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    return _getUser(
      () async =>
          await authRemoteDataSource.loginWithEmailPassword(email, password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name,
        email,
        password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      } else {
        final user = await fn();
        return right(user);
      }
    } on sb.AuthException catch (e) {
      return left(Failure(message: e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure(message: AppConstants.userNotLoggedIn));
      }
      return right(user);
    } on ServerException {
      return left(Failure(message: ''));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      authRemoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserAvatar(
    File image,
    String userId,
  ) async {
    try {
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      } else {
        final imageUrl = await authRemoteDataSource.updateAvatar(
          image: image,
          userId: userId,
        );
        return imageUrl.isNotEmpty
            ? right(imageUrl)
            : left(Failure(message: 'Unable to update user avatar'));
      }
    } on sb.AuthException catch (e) {
      return left(Failure(message: e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      if (!await connectionChecker.isInternetConnected) {
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      } else {
        final result = await authRemoteDataSource.changePassword(
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        );
        return result
            ? right(true)
            : left(Failure(message: 'Unable to change password'));
      }
    } on sb.AuthException catch (e) {
      return left(Failure(message: e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(message: e.message.toString()));
    }
  }
}
