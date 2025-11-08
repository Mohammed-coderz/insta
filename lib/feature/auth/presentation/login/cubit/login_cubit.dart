import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/core/const/app_constants.dart';
import 'package:untitled7/core/utils/io.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../../../domain/use_cases/login_usecase.dart';
import '../state/login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(OnInitialLoginState());

  void login(BuildContext context, String email, String password) async {
    emit(OnStartLoginState());

    try {
      Map<String, dynamic> body = {"phone": email, "password": password};
      loginUseCase
          .call(body: body)
          .then((response) {
            SharedPreferencesHelper.saveString(
              AppConstants.access_token,
              response.data!.accessToken ?? "",
            );
            IO.printOk(response.data!.accessToken ?? "");
            IO.printOk(response.data!.refreshToken ?? "");
            IO.printOk(response.data!.result.toString());
            emit(OnLoadedLoginState(response.data!.accessToken ?? ""));
          })
          .onError((error, stackTrace) {
            emit(OnErrorLoginState("on Error: $error"));
          });
    } catch (error) {
      emit(OnErrorLoginState("Error: $error"));
    }
  }
}
