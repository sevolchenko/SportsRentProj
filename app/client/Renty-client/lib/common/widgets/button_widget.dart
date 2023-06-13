import 'package:client/common/values/colors.dart';
import 'package:client/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildButton(
  String buttonName,
  String buttonType,
  void Function()? func,
  {double width=280, double height=50}
) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: width.w,
      height: height.h,
      margin: EdgeInsets.only(left: 25.w, right: 25.w),
      decoration: BoxDecoration(
        color: buttonType == "primary" ? Global.appColor : Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        border: buttonType == "primary"
            ? null
            : Border.all(color: Global.appColor, width: 2),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              color: buttonType == 'primary' ? Colors.white : Global.appColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.normal),
        ),
      ),
    ),
  );
}
