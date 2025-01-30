import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bloc_app/features/auth/domain/entities/user_entity.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

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
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(message: e.toString()));
    }on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
