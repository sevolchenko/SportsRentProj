import 'package:client/api/dto/request/user/register.dart';
import 'package:client/repository/register_repository.dart';
import 'package:client/bloc/register/register_event.dart';
import 'package:client/bloc/register/register_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository = RegisterRepository();

  RegisterBloc() : super(RegisteringUserState()) {
    on<RegisterUserEvent>(
      (event, emit) async {
        RegisterRequest registerRequest = RegisterRequest(
            name: event.name, email: event.email, password: event.password);
        int? code =
            await _registerRepository.registerUser(registerRequest.toJson());
        if (code == 200) {
          toastInfo(msg: "Регистрация успешна");
          emit(RegisterUserState());
        } else {
          toastInfo(msg: "Ошибка");
          emit(RegisterUserFailedState());
        }
      },
    );
  }
}
