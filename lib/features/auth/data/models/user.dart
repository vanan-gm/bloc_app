import 'package:bloc_app/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> map){
    var mapper = map['user_metadata'] ?? map;
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: mapper['name'] ?? '',
      imageUrl: mapper['image_url'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
  );
}
