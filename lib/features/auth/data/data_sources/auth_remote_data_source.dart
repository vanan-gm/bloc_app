import 'dart:io';

import 'package:bloc_app/core/common/paths/app_path.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/features/auth/data/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUseSession;
  Future<UserModel> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  );

  Future<UserModel> loginWithEmailPassword(String email, String password);
  Future<UserModel?> getCurrentUserData();
  Future<void> signOut();

  Future<bool> updateAvatar({required File image, required UserModel user});
  Future<bool> changePassword({
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException(message: 'User is null !!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name, 'image_url': AppPath.defaultUserImageUrl},
      );
      if (response.user == null) {
        throw const ServerException(message: 'User is null !!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Session? get currentUseSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUseSession == null) return null;
      final userData = await supabaseClient
          .from(AppConstants.tableProfiles)
          .select()
          .eq('id', currentUseSession!.user.id);
      // Here we add copyWith function bc data get from table profiles only contains id and name
      return UserModel.fromJson(
        userData.first,
      ).copyWith(email: currentUseSession!.user.email);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> updateAvatar({
    required File image,
    required UserModel user,
  }) async {
    final filePath =
        '${user.id}/avatar_${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      final storageRes = await supabaseClient.storage
          .from(AppConstants.bucketUserImages)
          .upload(
            filePath,
            image,
            fileOptions: const FileOptions(upsert: true),
          );

      if (storageRes.isEmpty) {
        throw ServerException(message: 'Fail to upload image');
      }

      final imageUrl = supabaseClient.storage
          .from(AppConstants.bucketUserImages)
          .getPublicUrl(filePath);

      final response = await supabaseClient
          .from(AppConstants.tableProfiles)
          .update({'image_url': imageUrl})
          .eq('id', user.id);

      return response != null ? true : false;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> changePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      return response.user != null ? true : false;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
