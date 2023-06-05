import 'package:client/bloc/register/register_bloc.dart';
import 'package:client/bloc/register/register_event.dart';
import 'package:client/bloc/register/register_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/screens/profile/login/login_screen.dart';
import 'package:client/screens/profile/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  void handleRegister(String name, String email, String password) {
    context
        .read<RegisterBloc>()
        .add(RegisterUserEvent(name: name, email: email, password: password));
    final state = context.read<RegisterBloc>().state;

    if (state is RegisterUserFailedState) {
      toastInfo(msg: "Ошибка, попробуйте снова");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    } else {
      toastInfo(msg: "Регистрация успешна");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }
}
