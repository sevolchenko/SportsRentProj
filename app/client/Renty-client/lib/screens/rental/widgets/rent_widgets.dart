import 'dart:convert';

import 'package:client/api/dto/response/rent.dart';
import 'package:client/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Widget buildRentTime(String time, String status) {
  return Container(
    margin: EdgeInsets.all(1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
    ),
    alignment: Alignment.center,
    child: Text(
      DateFormat('dd.MM.yyyy HH:mm')
          .format(DateTime.parse(time).toLocal())
          .toString(),
      maxLines: 2,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.center,
      style: status == "EXPIRED"
          ? GoogleFonts.raleway(
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            )
          : GoogleFonts.raleway(
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
  return Column(
    children: [
      rentReusableText(topText),
      Container(
        child: rentReusableText(bottomText, textSize: 15),
      ),
    ],
  );
}

Widget rentGrid(RentResponse rent, {Color borderColor = kPrimaryColor}) {
  print("getted start time: ${rent.startTime}");
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
                  buildSmallProductImage(rent.product.mainImage!.image),
                  const VerticalDivider(
                    thickness: 2,
                    color: kPrimaryColor,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(2.h),
                          alignment: Alignment.center,
                          child: Text(
                            rent.product.name,
                            style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.sp),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.h, left: 10.w, right: 10.w),
                          padding: EdgeInsets.only(top: 2.h),
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
                              rentColumnText('Размер', rent.size.sizeName),
                              rentColumnText(
                                  'Количество', rent.count.toString()),
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
                    buildRentTime(rent.startTime, rent.status),
                    const VerticalDivider(
                      thickness: 2,
                      color: kPrimaryColor,
                    ),
                    buildRentTime(rent.endTime, rent.status),
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
