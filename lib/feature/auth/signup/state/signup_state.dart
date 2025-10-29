abstract class SignupStates {}

class OnInitialSignupState extends SignupStates {}

class OnStartSignupState extends SignupStates {}

class OnLoadedSignupState extends SignupStates {
  OnLoadedSignupState();
}

class OnErrorSignupState extends SignupStates {
  final String errorMessage;

  OnErrorSignupState(this.errorMessage);
}
