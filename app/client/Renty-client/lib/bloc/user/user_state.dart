import 'package:client/api/dto/response/user/user.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserResponse user;

  UserLoadedState({required this.user});
}

class UserUnauthorizedState extends UserState {
  UserUnauthorizedState();
}
