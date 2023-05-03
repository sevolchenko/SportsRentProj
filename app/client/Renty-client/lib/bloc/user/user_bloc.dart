import 'package:client/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitState()) {
    final UserRepository _userRepository = UserRepository();

    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
    });
  }
}
