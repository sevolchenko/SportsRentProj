import 'dart:convert';

import 'package:client/api/apis/user_api.dart';
import 'package:client/api/dto/request/user/user_login.dart';
import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/common/values/constant.dart';
import 'package:client/global.dart';
import 'package:client/common/widgets/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
        // Global.storageService
        //     .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "key");
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil("/application", (route) => false);
        // }
        try {
          // TODO Работа с сервером
        } catch (e) {}
      }
    } catch (e) {}
  }

  Future<void> asyncPostAllData(UserLoginRequest userLoginRequest) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserApi.login(params: userLoginRequest);
    // if (result.code == 200) {
    //   try {
        // Global.storageService.setString(
        //     AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.user));
        // Global.storageService
        //     .setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.user.accessToken);
        // EasyLoading.dismiss();
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil("/home", (route) => false);
    //   } catch (e) {
    //     print("${e.toString()}");
    //   }
    // } else {
    //   EasyLoading.dismiss();
    //   toastInfo(msg: 'Error'); //TODO ошибка с сервера 
    // }
  }
}
