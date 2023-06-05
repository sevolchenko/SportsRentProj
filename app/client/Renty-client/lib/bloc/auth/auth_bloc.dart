import 'package:client/api/dto/response/user/login.dart';
import 'package:client/api/repository/auth_repository.dart';
import 'package:client/bloc/auth/auth_event.dart';
import 'package:client/bloc/auth/auth_state.dart';
import 'package:client/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  late LoginResponse response;

  AuthBloc() : super(LoggedOutState()) {
    on<LoginEvent>(
      (event, emit) async {
        var loginResponse = await _authRepository.login(event.loginRequest);
        Global.storageService.setUser(loginResponse);
        emit(LoggedInState(response: response));
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        _authRepository.logout();
        Global.storageService.saveCart(Global.cart);
        Global.storageService.logout();
        emit(LoggedOutState());
      },
    );
  }
}
