import 'package:client/api/dto/response/category.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildCategoryWidget(CategoryResponse category, BuildContext context) {
  return Row(
    children: [
      Container(
        width: 280.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(color: kPrimaryColor, width: 4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                category.name,
                style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    fontSize: 20.sp),
              ),
            ),
            Container(
              child: Text(
                category.parentCategoty.name ?? "",
                style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp),
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w),
        child: buildTrashIcon(context, () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }),
      )
    ],
  );
}
