import 'package:client/bloc/application/application_bloc.dart';
import 'package:client/bloc/application/application_event.dart';
import 'package:client/bloc/profile/profile_bloc.dart';
import 'package:client/bloc/profile/profile_state.dart';
import 'package:client/common/routes/routes.dart';
import 'package:client/common/values/constant.dart';
import 'package:client/global.dart';
import 'package:client/screens/profile/sign_in/sign_in_screen.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/values/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void removeUserData() {
    context.read<ApplicationBloc>().add(const TriggerAppEvent(0));
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (Context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Подтверждение выхода"),
                                content: const Text(
                                    "Вы действительно хотите выйти?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("Отмена"),
                                  ),
                                  TextButton(
                                    // onPressed: () => removeUserData(),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text("Выйти"),
                                  ),
                                ],
                              );
                            });
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
            bottomNavigationBar: MyBottomNavBar(
              selectedIndex: 3,
            ),
          ),
        ),
      );
    });
  }
}
