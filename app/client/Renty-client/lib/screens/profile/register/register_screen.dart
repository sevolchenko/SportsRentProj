import 'package:client/bloc/register/register_bloc.dart';
import 'package:client/bloc/register/register_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/controller/register_controller.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterController _registerController;

  late String name;
  late String email;
  late String password;
  late String rePassword;

  @override
  void initState() {
    super.initState();
    _registerController = RegisterController(context: context);
  }

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
                    Container(
                        margin: EdgeInsets.only(top: 20.h),
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText("Имя"),
                            buildTextField("Введите Ваше имя", 'name', (value) {
                              name = value;
                            }),
                            reusableText("Почта"),
                            buildTextField("Введите электронную почту", 'email',
                                textInputType: TextInputType.emailAddress,
                                (value) {
                              email = value;
                            }),
                            reusableText("Пароль"),
                            buildTextField("Введите пароль", 'password',
                                (value) {
                              password = value;
                            }),
                            reusableText("Подтверждение пароля"),
                            buildTextField("Введите пароль снова", 'password',
                                (value) {
                              rePassword = value;
                            }),
                            buildButton(
                              "Зарегистрироваться",
                              "primary",
                              () {
                                if (password != rePassword) {
                                  toastInfo(msg: "Пароли не совпадают!");
                                  setState(() {});
                                } else {
                                  _registerController.handleRegister(
                                      name, email, password);
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            )
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
