import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/common/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableText(String text,
    {Color color = Colors.black, double textSize = 16}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    child: Text(
      text,
      overflow: TextOverflow.fade,
      style: GoogleFonts.raleway(
          color: color, fontWeight: FontWeight.normal, fontSize: textSize.sp),
    ),
  );
}

Widget buildTextField(
    String hintText, String textType, void Function(String value)? func,
    {double width = 313,
    double height = 50,
    double bottomMargin = 30,
    TextInputType textInputType = TextInputType.multiline}) {
  return Container(
    margin: EdgeInsets.only(bottom: bottomMargin.h),
    width: width.w,
    height: height.h,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
        border: Border.all(color: kPrimaryColor, width: 4)),
    child: Row(
      children: [
        SizedBox(
          width: (width - 13).w,
          height: 50.h,
          child: TextField(
            onChanged: (value) => func!(value),
            textAlign: TextAlign.left,
            keyboardType: textInputType,
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
    ),
  );
}

Widget buildTextInfo(String title, String content, {double top = 30}) {
  return Container(
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: top.h, left: 20.w, right: 20.w),
          child: reusableText(title),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 5.h, left: 40.w, right: 20.w),
          child: Text(
            content,
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18.sp),
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

Widget buildTextInfoField(String content) {
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    width: 313.w,
    height: 50.h,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
        border: Border.all(color: kPrimaryColor, width: 4)),
    child: Row(
      children: [
        SizedBox(
          width: 300.w,
          height: 50.h,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              content,
              textAlign: TextAlign.left,
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20.sp),
            ),
          ),
        )
      ],
    ),
  );
}
