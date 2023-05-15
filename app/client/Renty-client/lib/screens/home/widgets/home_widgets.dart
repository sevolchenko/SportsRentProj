import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSize buildAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      automaticallyImplyLeading: false,
      title: Container(
          margin: EdgeInsets.only(top: 30.h, left: 5.w, right: 5.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextField("Поиск", 'search', height: 45, (value) {}),
                ],
              ),
            ],
          )),
    ),
  );
}

Widget sortAndFilter() {
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 20.w,
            height: 20.h,
            child: const Icon(
              FontAwesomeIcons.sort,
              size: 35,
            )),
        SizedBox(
            width: 20.w,
            height: 20.h,
            child: const Icon(
              FontAwesomeIcons.filter,
              size: 35,
            )),
      ],
    ),
  );
}

Widget productsGrid() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      border: Border.all(color: kPrimaryColor, width: 4),
    ),
    child: Column(
      children: [
        // Container(
        //   margin: EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
        //   child: Image.asset("assets/images/image_2.png"),
        // ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: Image.asset(
            "assets/images/image_2.png",
            // width: 90.h,
            // height: 90.h,
          ),
        ),
        const Divider(
          height: 0,
          thickness: 3,
          color: kPrimaryColor,
        ),
        Container(
          padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
          child: Text(
            "Велосипед горный Stels Focus",
            maxLines: 2,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
            ),
          ),
        ),
        const Divider(
          height: 7,
          indent: 40,
          endIndent: 5,
          thickness: 1,
          color: Colors.black,
        ),
        Container(
          padding: EdgeInsets.only(top: 2.h, right: 10.w),
          alignment: Alignment.centerRight,
          child: Text(
            "1000 Р/час",
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
        ),
      ],
    ),
  );
}
