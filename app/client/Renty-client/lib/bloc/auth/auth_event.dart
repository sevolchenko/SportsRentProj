import 'package:client/api/dto/request/user/login.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;

  LoginEvent(this.loginRequest);
}

class LogoutEvent extends AuthEvent {}
