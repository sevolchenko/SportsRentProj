import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:client/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/widgets/components/primary_button.dart';
import 'package:client/widgets/components/secondary_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: "Личный кабинет "),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50.h),
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextInfo("Имя", "Вадим"),
              buildTextInfo("Электронная почта", "examleemail@gmail.com"),
              SizedBox(
                height: 100.h,
              ),
              buildButton("Меню сотрудника", 'primary', () {}),
              SizedBox(
                height: 20.h,
              ),
              buildButton(
                "Выйти",
                "secondary",
                () {
                  // Navigator.of(context).pop(const SignInScreen());
                  //
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const SignInScreen(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: MyBottomNavBar(
      //   selectedIndex: 3,
      // ),
    );
  }
}
