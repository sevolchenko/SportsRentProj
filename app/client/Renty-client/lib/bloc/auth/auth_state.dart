import 'package:client/api/dto/response/user/login.dart';

abstract class AuthState {}

class LoggedInState extends AuthState {
  final LoginResponse response;

  LoggedInState({required this.response});
}

class LoggingOutState extends AuthState {}

class LoggedOutState extends AuthState {}