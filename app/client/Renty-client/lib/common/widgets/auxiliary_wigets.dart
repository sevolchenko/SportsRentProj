import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/screens/profile/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

toastInfo(
    {required String msg,
    Color backgroundColor = kPrimaryColor,
    Color textColor = Colors.white}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.sp,
  );
}

Widget buildLoadingWidget() {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text("Loading data ..."), CircularProgressIndicator()],
      ));
}

Widget buildErrorWidget({String error = ""}) {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Произошла ошибка: $error"),
        ],
      ));
}

Widget buildUnauthenticatedWidget(BuildContext context) {
  return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Войдите, чтобы продолжить",
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18.sp)),
        SizedBox(height: 50.h,),
        buildButton("Войти", 'primary', () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        })
      ]));
}
