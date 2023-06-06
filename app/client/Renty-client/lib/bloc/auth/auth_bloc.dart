import 'package:client/api/dto/response/user/login.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/bloc/auth/auth_event.dart';
import 'package:client/bloc/auth/auth_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  late LoginResponse? response;

  AuthBloc() : super(LoggedOutState()) {
    on<LoginEvent>(
      (event, emit) async {
        response = await _authRepository.login(event.loginRequest);
        if (response != null) {
          Global.storageService.setUser(response!);
          emit(LoggedInState(response: response!));
        } else {
          toastInfo(msg: "Ошибка.Проверьте введенные данные");
          emit(LoginUserFailedState());
        }
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
