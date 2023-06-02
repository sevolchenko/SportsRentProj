import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/profile/employee/rental_completion/rental_comletion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalSearchScreen extends StatefulWidget {
  const RentalSearchScreen({super.key});

  @override
  State<RentalSearchScreen> createState() => _RentalSearchScreenState();
}

class _RentalSearchScreenState extends State<RentalSearchScreen> {
  late String _userEmail;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Поиск по email',
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.only(top: 80.h),
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText("Почта"),
                SizedBox(
                  height: 5.h,
                ),
                buildTextField("Введите электронную почту клиента", 'email',
                    textInputType: TextInputType.emailAddress,
                    height: 58, (value) {
                  _userEmail = value;
                }),
                SizedBox(
                  height: 20.h,
                ),
                buildButton("Поиск", "primary", () {
                  
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RentalCompletionScreen(),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
