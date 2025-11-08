
import 'package:untitled7/feature/auth/data/model/user_model.dart';

import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {

  LoginModel({
    required super.result,
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];

    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];

    user = json['user'] != null
        ? UserModel.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['result'] = result;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (user != null) {
      data['user'] = (user as UserModel).toJson();
    }

    return data;
  }
}