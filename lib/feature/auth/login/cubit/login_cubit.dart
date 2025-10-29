import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../core/const/api_const.dart';
import '../state/login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(OnInitialLoginState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void login(BuildContext context, String email, String password) async {
    emit(OnStartLoginState());

    try {
      final response = await http.post(
        Uri.parse(ApiConst.Login_URL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        if (json["result"] == true) {
          emit(OnLoadedLoginState(json["access_token"]));
        } else {
          emit(OnErrorLoginState(json["message"] ?? "Invalid credentials"));
        }
      } else {
        emit(OnErrorLoginState("Server error: ${response.statusCode}"));
      }
    } catch (error) {
      emit(OnErrorLoginState("Error: $error"));
    }
  }
}
