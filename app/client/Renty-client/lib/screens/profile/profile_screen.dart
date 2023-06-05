import 'package:client/api/dto/response/user/user.dart';
import 'package:client/bloc/user/user_bloc.dart';
import 'package:client/bloc/user/user_event.dart';
import 'package:client/bloc/user/user_state.dart';
import 'package:client/common/routes/routes.dart';
import 'package:client/common/values/constant.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/global.dart';
import 'package:client/screens/profile/employee/employee_menu.dart';
import 'package:client/screens/profile/login/login_screen.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (Context, state) {
      if (state is UserLoadedState) {
        return _buildUserScaffold(_buildUserWidget(state.user));
      } else if (state is UserUnauthorizedState) {
        return buildUnauthenticatedWidget(context);
      } else {
        return buildLoadingWidget();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserLoadEvent());
  }

  Widget _buildUserScaffold(Widget body) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(title: "Личный кабинет "),
        body: body,
        bottomNavigationBar: MyBottomNavBar(
          selectedIndex: 3,
        ),
      ),
    );
  }

  Widget _buildUserWidget(UserResponse user) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50.h),
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextInfo("Имя", user.name),
            buildTextInfo("Электронная почта", user.email),
            SizedBox(
              height: 100.h,
            ),
            user.role == "EMPLOYEE"
                ? buildButton("Меню сотрудника", 'primary', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EmpoyeeMenu(),
                      ),
                    );
                  })
                : Container(),
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
                        content: const Text("Вы действительно хотите выйти?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Отмена"),
                          ),
                          TextButton(
                            onPressed: () {
                              Global.storageService.logout();
                              Navigator.pushNamed(context, AppRoutes.LOGIN)
                                  .then((_) => setState(() {}));
                            },
                            child: const Text("Выйти"),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
