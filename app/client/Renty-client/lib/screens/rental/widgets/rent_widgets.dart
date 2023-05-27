import 'dart:convert';

import 'package:client/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildRentTime(String time) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      time,
      maxLines: 2,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.center,
      style: GoogleFonts.raleway(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.normal,
        fontSize: 17.sp,
      ),
    ),
  );
}

Widget buildSmallProductImage(String image) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
    child: Image.memory(
      base64Decode(image),
      width: 90.h,
      height: 90.h,
    ),
  );
}

Widget rentReusableText(String text, {double textSize = 13}) {
  return Container(
    child: Text(text,
        style: GoogleFonts.raleway(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
            fontSize: textSize.sp)),
  );
}

Widget rentColumnText(String topText, String bottomText) {
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

Widget rentGrid({Color borderColor = kPrimaryColor}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      border: Border.all(color: kPrimaryColor, width: 4),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  buildSmallProductImage("assets/images/image_2.png"),
                  const VerticalDivider(
                    thickness: 2,
                    color: kPrimaryColor,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Велосипед',
                            style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 18.sp),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.h, left: 20.w, right: 20.w),
                          padding: EdgeInsets.only(top: 5.h),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 2.0,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              rentColumnText('Размер', 'детский'),
                              rentColumnText('Количество', '1'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2.0, color: kPrimaryColor),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildRentTime("23.04.23 15:00"),
                    const VerticalDivider(
                      thickness: 2,
                      color: kPrimaryColor,
                    ),
                    buildRentTime("23.04.23 16:00"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
