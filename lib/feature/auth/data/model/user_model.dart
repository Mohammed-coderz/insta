
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.phone,
    required super.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = id;
    json['username'] = username;
    json['email'] = email;
    json['phone'] = phone;
    json['role'] = role;
    return json;
  }
}
