abstract class LoginStates {}

class OnInitialLoginState extends LoginStates {}

class OnStartLoginState extends LoginStates {}

class OnLoadedLoginState extends LoginStates {
  final String token;
  OnLoadedLoginState(this.token);
}

class OnErrorLoginState extends LoginStates {
  final String errorMessage;
  OnErrorLoginState(this.errorMessage);
}
