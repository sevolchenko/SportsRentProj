import 'dart:convert';

import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/home/product/product_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, this.index = 0});
  final int index;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductController _productController;
  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.init(widget.index);
    // build(context);
  }

  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Информация о товаре",
          autoLeading: true,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            List<String> sizeNames = state.productItem.sizes!
                .map((size) => size.sizeName)
                .toList();
            if (dropdownValue == "") {
              dropdownValue = sizeNames.first;
            }
            return SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor, width: 4),
                      ),
                      child: Image.memory(
                        base64Decode(state.productItem.images![0].image),
                        width: 130.h,
                        height: 130.h,
                      ),
                    ),
                    buildTextInfo("Название", state.productItem.name!),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        border: Border.all(color: kPrimaryColor, width: 2),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 20.h),
                      padding: EdgeInsets.all(10.w),
                      child: reusableText(
                          state.productItem.description ?? "", Colors.black,
                          textSize: 16),
                    ),
                    buildTextInfo("Цена", "${state.productItem.price} руб/час"),
                    SizedBox(height: 20.h),
                    DropdownButton(
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        value: dropdownValue,
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: sizeNames
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    SizedBox(height: 20.h),
                    reusableText('Время начала аренды', Colors.black,
                        textSize: 20),
                    buildTextField(
                        '24.04.2023, 16:00',
                        'time',
                        bottomMargin: 0,
                        (value) {}),
                    SizedBox(height: 20.h),
                    reusableText('Время окончания аренды', Colors.black,
                        textSize: 20),
                    buildTextField(
                        '24.04.2023, 17:00',
                        'time',
                        bottomMargin: 0,
                        (value) {}),
                    buildTextInfo("Длительность аренды", "01:00:00"),
                    SizedBox(
                      height: 10.h,
                    ),
                    buildButton(
                        "Уведомить по освобождении", "secondary", () {}),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildButton("Добавить в корзину", "primary", () {}),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 0),
      ),
    );
  }
}
