abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
 final  dynamic ? Uid;
  LoginSuccessState({this.Uid});

}

class LoginErrorState extends LoginStates {}

class ShowPassword extends LoginStates {}

