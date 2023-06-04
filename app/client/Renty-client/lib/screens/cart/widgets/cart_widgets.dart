import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cartColumnText(String topText, String bottomText) {
  return Expanded(
    child: Column(
      children: [
        rentReusableText(topText),
        Container(
          padding: EdgeInsets.only(top: 5.h),
          child: rentReusableText(bottomText, textSize: 15),
        ),
      ],
    ),
  );
}

Widget cartColumnQuantity(String topText, String quantity) {
  return Expanded(
    child: Column(
      children: [
        rentReusableText(topText),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 15.w),
          child: Row(
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  quantity,
                  style: GoogleFonts.raleway(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
