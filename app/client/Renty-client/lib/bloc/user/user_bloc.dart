import 'package:client/api/dto/response/user/user.dart';
import 'package:client/api/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = UserRepository();
  late UserResponse? user;

  UserBloc() : super(UserLoadingState()) {
    on<UserLoadEvent>((event, emit) async {
      user = await _userRepository.getMe();
      if (user != null) {
        emit(UserLoadedState(user: user!));
      } else {
        emit(UserUnauthorizedState());
      }
    });
  }
}
