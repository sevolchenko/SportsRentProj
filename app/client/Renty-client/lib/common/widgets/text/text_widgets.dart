import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/common/values/colors.dart';

Widget reusableText(String text, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      overflow: TextOverflow.fade,
      style: TextStyle(
          color: color, fontWeight: FontWeight.normal, fontSize: 14.sp),
    ),
  );
}

Widget buildTextField(String hintText, String textType, double height,
    void Function(String value)? func) {
  return Container(
      margin: EdgeInsets.only(bottom: 30.h),
      width: 313.w,
      height: height.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.w)),
          border: Border.all(color: kPrimaryColor, width: 4)),
      child: Row(
        children: [
          SizedBox(
            width: 300.w,
            height: 50.h,
            child: TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
              ),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp),
              autocorrect: false,
              obscureText: textType == "password" ? true : false,
            ),
          )
        ],
      ));
}

Widget buildTextInfo(String title, String content) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.h),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
          child: reusableText(title, Colors.black),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 5.h, left: 40.w, right: 20.w),
          child: Text(
            content,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: 22.sp),
          ),
        ),
        const Divider(
          height: 10,
          indent: 35,
          endIndent: 35,
          thickness: 1,
          color: Colors.black,
        ),
      ],
    ),
  );
}
