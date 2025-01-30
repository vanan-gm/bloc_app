import 'package:bloc_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
    id: map['id'] ?? '',
    email: map['email'] ?? '',
    name: map['name'] ?? '',
  );
}