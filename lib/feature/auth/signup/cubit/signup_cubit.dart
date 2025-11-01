import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../core/const/api_const.dart';
import '../state/Signup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(OnInitialSignupState());

  static SignupCubit get(BuildContext context) => BlocProvider.of(context);

  void Signup(
    BuildContext context,
    String username,
    String email,
    String phone,
    String password,
  ) async {
    emit(OnStartSignupState());

    try {
      final response = await http.post(
        Uri.parse(ApiConst.Reg_URL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "phone": phone,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print(json);
        if (json["result"] == true) {
          emit(OnLoadedSignupState());
        } else {
          emit(OnErrorSignupState(json["message"] ?? "Invalid credentials"));
        }
      } else {
        emit(OnErrorSignupState("Server error: ${response.statusCode}"));
      }
    } catch (error) {
      emit(OnErrorSignupState("Error: $error"));
    }
  }
}
