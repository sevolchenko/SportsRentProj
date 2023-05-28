import 'dart:convert';

import 'package:client/api/dto/response/product.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildProduct(ProductResponse product) {
  var image = product.images![0].image;
  List<String> size_names = [];
  product.sizes!.forEach((size) {
    size_names.add(size.sizeName);
  });
  return Column(
    children: [
      Container(
        width: 200.w,
        height: 200.h,
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 4),
        ),
        child: Image.memory(
          base64Decode(product.images![0].image),
          width: 130.h,
          height: 130.h,
        ),
      ),
      buildTextInfo("Название", product.name!),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          border: Border.all(color: kPrimaryColor, width: 2),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        padding: EdgeInsets.all(10.w),
        child: reusableText(product.description ?? "", textSize: 16),
      ),
      buildTextInfo("Цена", "${product.price} руб/час"),
      SizedBox(height: 20.h),
      reusableText("Размер"),
      DropdownButton(
        items: size_names.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {},
      ),
      SizedBox(height: 20.h),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 70.h,
              child: Column(
                children: [
                  reusableText("Всего доступно"),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    product.sizes![0].countAvailableNow.toString(),
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                        fontSize: 22.sp),
                  ),
                ],
              ),
            ),
            Container(
              height: 70.h,
              child: Column(
                children: [
                  reusableText("Количество"),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.minus,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          product.sizes![0].total.toString(),
                          style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              fontSize: 22.sp),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.plus,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20.h),
      reusableText('Время начала аренды', textSize: 20),
      SizedBox(
        height: 5.h,
      ),
      buildTextField(
          '24.04.2023, 16:00',
          'time',
          textInputType: TextInputType.datetime,
          (value) {}),
      Column(
        children: [
          reusableText("Часов аренды"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.minus,
                  size: 24,
                ),
                onPressed: () {},
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  product.sizes![0].total.toString(),
                  style: GoogleFonts.raleway(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                      fontSize: 22.sp),
                ),
              ),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
      SizedBox(height: 20.h),
      buildButton("Уведомить по освобождении", "secondary", () {}),
      SizedBox(
        height: 20.h,
      ),
      buildButton("Добавить в корзину", "primary", () {}),
      SizedBox(
        height: 20.h,
      ),
    ],
  );
}
