abstract class RegisterState {}


class RegisteringUserState extends RegisterState {
  RegisteringUserState();
}

class RegisterUserState extends RegisterState {
  RegisterUserState();
}

class RegisterUserFailedState extends RegisterState {
  RegisterUserFailedState();
}
