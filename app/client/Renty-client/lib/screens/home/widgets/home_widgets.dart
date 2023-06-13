import 'dart:convert';

import 'package:client/api/dto/response/product/category.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

Widget sortAndFilter(
  BuildContext context,
  List<CategoryResponse> categories, {
  void Function(Map<String, String> value)? sortFunc,
  void Function(String value)? filterFunc,
}) {
  return Container(
    margin: EdgeInsets.only(top: 5.h, bottom: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PopupMenuButton<Map<String, String>>(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: {'NAME': "ASC"},
              child: Text('В алфавитном порядке'),
            ),
            const PopupMenuItem(
              value: {'PRICE': "ASC"},
              child: Text('По возрастанию цены'),
            ),
            const PopupMenuItem(
              value: {'PRICE': "DESC"},
              child: Text('По убыванию цены'),
            ),
          ],
          onSelected: (value) => sortFunc!(value),
          child: SizedBox(
            width: 20.w,
            height: 20.h,
            child: const Icon(
              FontAwesomeIcons.sort,
              size: 40,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            int selectedCategoryId = categories[0].categoryId;
            final minPriceController = TextEditingController();
            final maxPriceController = TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Фильтр'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Минимальная стоимость',
                      ),
                    ),
                    TextField(
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Максимальная стоимость',
                      ),
                    ),
                    DropdownButtonFormField(
                      value: selectedCategoryId,
                      hint: const Text('Выберите категорию'),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.categoryId,
                          child: Text(
                            category.name,
                            style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCategoryId = value ?? categories[0].categoryId;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Отмена'),
                  ),
                  TextButton(
                    onPressed: () {
                      int minPrice = minPriceController.text != ""
                          ? int.parse(
                              minPriceController.text,
                            )
                          : 0;
                      int maxPrice = maxPriceController.text != ""
                          ? int.parse(
                              maxPriceController.text,
                            )
                          : 2147483647;
                      if (minPrice < 0 || maxPrice < 0 || maxPrice < minPrice) {
                        toastInfo(msg: "Недопустимое значение!");
                        return;
                      }
                      context.read<ProductBloc>().add(
                            ProductsPreviewsFilterEvent(
                              categoryId: selectedCategoryId,
                              minPrice: minPrice,
                              maxPrice: maxPrice,
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Применить'),
                  ),
                ],
              ),
            );
          },
          child: SizedBox(
            width: 20.w,
            height: 20.h,
            child: const Icon(
              FontAwesomeIcons.filter,
              size: 40,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget productsPreviewGrid(ProductPreviewResponse item) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      border: Border.all(
          color: item.busyNow ? Colors.grey : Global.appColor, width: 4),
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: Image.memory(
            base64Decode(item.mainImage!.image),
            width: 130.h,
            height: 130.h,
          ),
        ),
        Divider(
            height: 0,
            thickness: 3,
            color: item.busyNow ? Colors.grey : Global.appColor),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
            child: Text(
              item.name,
              maxLines: 2,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
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
          padding: EdgeInsets.only(top: 2.h, right: 10.w, bottom: 3.h),
          alignment: Alignment.centerRight,
          child: Text(
            "${item.price.toString()} Р/час",
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
