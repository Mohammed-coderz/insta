import 'user_entity.dart';

class LoginEntity {
  bool? result;
  String? accessToken;
  String? refreshToken;
  UserEntity? user;

  LoginEntity({this.result, this.accessToken, this.refreshToken, this.user});


}