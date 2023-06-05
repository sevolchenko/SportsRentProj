import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScrenn extends StatefulWidget {
  const WelcomeScrenn({super.key});

  @override
  State<WelcomeScrenn> createState() => _WelcomeScrennState();
}

class _WelcomeScrennState extends State<WelcomeScrenn> {
  @override
  void initState() {
    super.initState();
  }

  Widget mainTextWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.raleway(
          color: Global.appColor, fontWeight: FontWeight.w800, fontSize: 28.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Global.appColor,
          body: Container(
            margin: EdgeInsets.only(top: 80.h),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  "RENTY",
                  style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 50.sp),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 80.h),
                  padding: EdgeInsets.only(
                      top: 20.h, left: 10.w, right: 10.w, bottom: 20.h),
                  child: Column(
                    children: [
                      mainTextWidget(
                        "ВЫБИРАЙ ИНВЕНТАРЬ",
                      ),
                      SizedBox(height: 20.h),
                      mainTextWidget("БРОНИРУЙ НА УДОБНОЕ ВРЕМЯ"),
                      SizedBox(height: 20.h),
                      mainTextWidget("ЗАНИМАЙСЯ СПОРТОМ"),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                // SizedBox(height: 100.h),
                buildButton("Начать", "secondary", () {})
              ],
            ),
          )),
    );
  }
}
