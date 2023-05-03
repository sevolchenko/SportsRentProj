import 'package:client/screens/sign_in/widgets/sign_in_widget.dart';
import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/bar/bottom_menu.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:client/widgets/text/text_field_widget.dart';
import 'package:client/widgets/text/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SIgnInScreen extends StatefulWidget {
  const SIgnInScreen({Key? key}) : super(key: key);

  @override
  State<SIgnInScreen> createState() => _SIgnInScreenState();
}

class _SIgnInScreenState extends State<SIgnInScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const MyAppBar(
            title: 'Авторизация',
          ),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // buildThirdPartyLogin(context),
              Container(
                  margin: EdgeInsets.only(top: 80.h),
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("Email", Colors.black),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("Введите электронную почту", 'email'),
                      reusableText("Password", Colors.black),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("Введите пароль", 'password'),
                      buildButton("Войти", "primary"),
                      SizedBox(height: 20.h,),
                      buildButton("Регистрация", "secondary")
                    ],
                  ))
            ]),
          ),
          bottomNavigationBar: BottomMenu(selectedIndex: 3),
        ),
      ),
    );
  }
}
