import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/network/connection_checker.dart';
import 'package:bloc_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bloc_app/core/common/entities/user_entity.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl({required this.authRemoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword(
      String email, String password) async{
    return _getUser(() async => await authRemoteDataSource.loginWithEmailPassword(email, password));
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword(
      String name, String email, String password) async {
    return _getUser(() async => await authRemoteDataSource.signUpWithEmailPassword(
        name, email, password));
  }

  Future<Either<Failure, UserEntity>> _getUser(Future<UserEntity> Function() fn) async{
    try{
      if(!await connectionChecker.isInternetConnected){
        return left(Failure(message: AppConstants.noConnectionErrorMessage));
      }else{
        final user = await fn();
        return right(user);
      }
    } on sb.AuthException catch (e) {
      return left(Failure(message: e.toString()));
    }on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async{
    try{
      final user = await authRemoteDataSource.getCurrentUserData();
      if(user == null) return left(Failure(message: 'User not logged in'));
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
