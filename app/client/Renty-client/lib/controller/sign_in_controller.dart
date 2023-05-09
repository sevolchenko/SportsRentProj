import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/widgets/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  void handleSignIn(String type) {
    try {
      if (type == "email") {
        //BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String email = state.email;
        String password = state.password;
        if (email.isEmpty) {
          toastInfo(msg: "Заполните поле ввода электронной почты");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "Заполните поле ввода пароля");
          return;
        }
        // if(user!=null){
        Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
        // }
        try {
          // TODO Работа с сервером
        } catch (e) {}
      }
    } catch (e) {}
  }
}
