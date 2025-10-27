import 'package:untitled7/feature/auth/login/model/user_model.dart';

class LoginModel {
  bool? result;
  String? accessToken;
  String? refreshToken;
  UserModel? user;

  LoginModel({this.result, this.accessToken, this.refreshToken, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}


