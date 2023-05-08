import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/bloc/sign_in/sign_in_event.dart';
import 'package:client/bloc/sign_in/sign_in_state.dart';
import 'package:client/controller/sign_in_controller.dart';
import 'package:client/screens/sign_in/widgets/sign_in_widget.dart';
import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/bar/bottom_menu.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:client/widgets/text/text_field_widget.dart';
import 'package:client/widgets/text/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: const MyAppBar(
                title: 'Авторизация',
              ),
              body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // buildThirdPartyLogin(context),
                      Container(
                          margin: EdgeInsets.only(top: 80.h),
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableText("Почта", Colors.black),
                              SizedBox(
                                height: 5.h,
                              ),
                              buildTextField(
                                  "Введите электронную почту", 'email', 58,
                                  (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(EmailEvent(value));
                              }),
                              reusableText("Пароль", Colors.black),
                              SizedBox(
                                height: 5.h,
                              ),
                              buildTextField("Введите пароль", 'password', 58,
                                  (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(PasswordEvent(value));
                              }),
                              SizedBox(
                                height: 20.h,
                              ),
                              buildButton("Войти", "primary", () {
                                SignInController(context: context)
                                    .handleSignIn("email");
                                    Navigator.of(context).pushNamed("profile");
                              }),
                              SizedBox(
                                height: 20.h,
                              ),
                              buildButton("Регистрация", "secondary", () {
                                Navigator.of(context).pushNamed("register");
                              })
                            ],
                          ))
                    ]),
              ),
              bottomNavigationBar: BottomMenu(selectedIndex: 3),
            ),
          ),
        );
      },
    );
  }
}
