import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/bloc/sign_in/sign_in_event.dart';
import 'package:client/bloc/sign_in/sign_in_state.dart';
import 'package:client/controller/sign_in_controller.dart';
import 'package:client/screens/application/application.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/profile/register/register_screen.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
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
                autoLeading: false,
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
                              reusableText("Почта"),
                              SizedBox(
                                height: 5.h,
                              ),
                              buildTextField(
                                  "Введите электронную почту", 'email',
                                  (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(EmailEvent(value));
                              }, height: 58),
                              reusableText("Пароль"),
                              SizedBox(
                                height: 5.h,
                              ),
                              buildTextField("Введите пароль", 'password',
                                  (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(PasswordEvent(value));
                              }, height: 58),
                              SizedBox(
                                height: 20.h,
                              ),
                              buildButton("Войти", "primary", () {
                                // SignInController(context: context)
                                //     .handleSignIn("email");

                                // Navigator.of(context).pushNamed("/profile");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 20.h,
                              ),
                              buildButton("Регистрация", "secondary", () {
                                // Navigator.of(context).pop(RegisterScreen());
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              })
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
      },
    );
  }
}
