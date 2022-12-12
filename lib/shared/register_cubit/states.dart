abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}

class RegisterShowPassword extends RegisterStates {}

class ChangeDropDownLocationState extends RegisterStates {}

class ChangeDropDownStatusState extends RegisterStates {}

class RegisterCreateUserErrorState extends RegisterStates {}

class RegisterCreateUserSuccessState extends RegisterStates {
  final String Uid;
  RegisterCreateUserSuccessState(this.Uid);

}

class RegisterImagePickedSuccessState extends RegisterStates {}

class RegisterImagePickedErrorState extends RegisterStates {}

class RegisterUploadImageSuccessState extends RegisterStates {}

class RegisterUploadImageErrorState extends RegisterStates {}