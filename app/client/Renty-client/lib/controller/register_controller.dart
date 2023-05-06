import 'package:client/bloc/register/register_bloc.dart';
import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/widgets/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  void handleRegister(String type) {
    try {
      final state = context.read<RegisterBloc>().state;
      String userName = state.userName;
      String email = state.email;
      String password = state.password;
      String rePassword = state.rePassword;
      if (userName.isEmpty) {
        toastInfo(msg: "Поле с именем не может быть пустым");
        return;
      }
      if (email.isEmpty) {
        toastInfo(msg: "Поле с почтой не может быть пустым");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Поле с паролем не может быть пустым");
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: "Пароли не совпадают");
        return;
      }
      //TODO работа с сервером
    } catch (e) {}
  }
}
