import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled7/feature/auth/login/model/login_model.dart';
import '../../../../core/const/api_const.dart';
import '../../../../core/const/json_body_const.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;
  LoginModel? loginModel;


  login({required String phone, required String password}) async {
    isLoading = true;
    notifyListeners();
    final response = await http.post(
      Uri.parse(ApiConst.Login_URL),
      body: jsonEncode({
        JsonBodyConst.phone: phone,
        JsonBodyConst.password: password,
      }),
      headers: {"Content-Type": "application/json"},
    );
    isLoading = false;
    notifyListeners();
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      loginModel = LoginModel.fromJson(jsonBody);
      if (jsonBody["result"]) {
        String? accessToken = loginModel!.accessToken;
        // String accessToken = jsonBody["access_token"];
      }
    }
  }
}
