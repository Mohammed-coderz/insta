import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/core/utils/io.dart';
import 'package:untitled7/feature/auth/domain/use_cases/signup_usecase.dart';
import '../state/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupUsecase signupUseCase;

  SignupCubit({required this.signupUseCase}) : super(OnInitialSignupState());

  void signup(BuildContext context, String email, String password, String phone, String username) async {
    emit(OnStartSignupState());

    try {
      Map<String, dynamic> body = {"phone": email, "password": password};
      signupUseCase
          .call(body: body)
          .then((response) {
        IO.printOk(response.data!.result.toString());
        emit(OnLoadedSignupState());
      })
          .onError((error, stackTrace) {
        emit(OnErrorSignupState("on Error: $error"));
      });
    } catch (error) {
      emit(OnErrorSignupState("Error: $error"));
    }
  }
}
