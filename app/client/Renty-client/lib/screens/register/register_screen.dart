import 'package:client/bloc/register/register_bloc.dart';
import 'package:client/bloc/register/register_event.dart';
import 'package:client/bloc/register/register_state.dart';
import 'package:client/controller/register_controller.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(
              title: 'Регистрация',
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // buildThirdPartyLogin(context),
                    Container(
                        margin: EdgeInsets.only(top: 40.h),
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText("Имя", Colors.black),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            buildTextField("Введите Ваше имя", 'name', 50,
                                (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(UserNameEvent(value));
                            }),
                            reusableText("Почта", Colors.black),

                            buildTextField(
                                "Введите электронную почту", 'email', 50,
                                (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(EmailEvent(value));
                            }),
                            reusableText("Пароль", Colors.black),

                            buildTextField("Введите пароль", 'password', 50,
                                (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(PasswordEvent(value));
                            }),
                            reusableText("Подтверждение пароля", Colors.black),

                            buildTextField(
                                "Введите пароль снова", 'password', 50,
                                (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(RePasswordEvent(value));
                            }),

                            buildButton("Зарегистрироваться", "primary", () {
                              // RegisterController(context: context)
                              //     .handleRegister();

                              // Navigator.of(context).pushNamed("/application");

                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInScreen(),
                                  ),
                                );
                            }),
                          ],
                        ))
                  ]),
            ),
            bottomNavigationBar: MyBottomNavBar(
              selectedIndex: 3,
            ),
          ),
        ),
      );
    });
  }
}
