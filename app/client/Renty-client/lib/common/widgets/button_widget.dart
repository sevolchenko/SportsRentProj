import 'package:client/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildButton(
    String buttonName, String buttonType, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 280.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 25.w, right: 25.w),
      decoration: BoxDecoration(
        color: buttonType == "primary" ? kPrimaryColor : kSecondaryColor,
        borderRadius: BorderRadius.circular(20.w),
        border: buttonType == "primary"
            ? null
            : Border.all(color: kPrimaryColor, width: 2),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              color: buttonType == 'primary' ? Colors.white : Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal),
        ),
      ),
    ),
  );
}
