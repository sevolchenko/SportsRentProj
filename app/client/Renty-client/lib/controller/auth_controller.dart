import 'package:client/api/dto/request/user/login.dart';
import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/auth/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthController {
  final BuildContext context;
  AuthController({required this.context});

  void initLogin(LoginRequest loginRequest) async {
    context.read<AuthBloc>().add(LoginEvent(loginRequest));
  }

}
