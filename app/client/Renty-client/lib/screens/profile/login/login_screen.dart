import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/auth/auth_state.dart';
import 'package:client/controller/auth_controller.dart';
import 'package:client/screens/profile/register/register_screen.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthController _authController;
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _authController = AuthController(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
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
                                  "Введите электронную почту", 'email', textInputType: TextInputType.emailAddress,
                                  (value) {
                                email = value;
                              }, height: 58),
                              reusableText("Пароль"),
                              SizedBox(
                                height: 5.h,
                              ),
                              buildTextField("Введите пароль", 'password',
                                  (value) {
                                password = value;
                              }, height: 58),
                              SizedBox(
                                height: 20.h,
                              ),
                              buildButton("Войти", "primary", () {
                                _authController.handleLogin(email, password);
                              }),
                              SizedBox(
                                height: 20.h,
                              ),
                              buildButton("Регистрация", "secondary", () {
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
