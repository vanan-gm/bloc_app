import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/features/auth/data/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword(
      String name, String email, String password);

  Future<UserModel> loginWithEmailPassword(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> loginWithEmailPassword(String email, String password) async{
    try {
      final response = await supabaseClient.auth.signInWithPassword(password: password, email: email,);
      if(response.user == null){
        throw const ServerException(message: 'User is null !!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      String name, String email, String password) async {
    try {
      final response = await supabaseClient.auth.signUp(password: password, email: email, data: {
        'name': name,
      });
      if(response.user == null){
        throw const ServerException(message: 'User is null !!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
