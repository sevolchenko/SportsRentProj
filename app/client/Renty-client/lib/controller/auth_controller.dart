import 'package:client/api/dto/request/user/login.dart';
import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/auth/auth_event.dart';
import 'package:client/bloc/auth/auth_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/profile/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthController {
  final BuildContext context;
  AuthController({required this.context});

  void handleLogin(String email, String password) async {
    bool isValidEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (isValidEmail == false) {
      toastInfo(msg: "Неверный email формат!");
      return;
    } else {
      context
          .read<AuthBloc>()
          .add(LoginEvent(LoginRequest(email: email, password: password)));
      await Future.delayed(Duration(seconds: 2));
      final state = context.read<AuthBloc>().state;
      if (state is LoggedInState) {
        toastInfo(msg: "Успешный вход в систему");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } 
    }
  }
}
