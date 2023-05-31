import 'dart:convert';
import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/api/repository/product_repository.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({super.key, this.productId = 0});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> strSizes = ["One", "Two"];
  // late ProductController _productController;

  late int _selectedSizeIndex;
  @override
  void initState() {
    super.initState();
    // _productController = ProductController(context: context);
    // _productController.initProduct(widget.productId);
    _selectedSizeIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadedState) {
          return _buildProductWidget(state.productItem, state.sizes);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductWidget(
      ProductResponse product, List<SizeResponse> sizes) {
    // var currentSize = product!.sizes[0].sizeName;
    // List<String> sizeNames =
    //     product.sizes.map((size) => size.sizeName).toList();
    // if (currentSize == "") {
    //   currentSize = sizeNames.first;
    // }
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Информация о товаре",
        ),
        body: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: buildProduct(product, sizes)),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 0),
      ),
    );
  }

  Widget buildProduct(ProductResponse product, List<SizeResponse> sizes) {
    // List<String> size_names = [];
    // product.sizes.forEach((size) {
    //   size_names.add(size.sizeName);
    // });
    return Column(
      children: [
        Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 4),
          ),
          child: Image.memory(
            base64Decode(product.images[0].image),
            width: 130.h,
            height: 130.h,
          ),
        ),
        buildTextInfo("Название", product.name),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            border: Border.all(color: kPrimaryColor, width: 2),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          padding: EdgeInsets.all(10.w),
          child: reusableText(product.description, textSize: 16),
        ),
        buildTextInfo("Цена", "${product.price} руб/час"),
        SizedBox(height: 20.h),
        reusableText("Размер"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: DropdownButtonFormField(
            value: _selectedSizeIndex,
            hint: Text('Выберите размер'),
            items: sizes.map((size) {
              return DropdownMenuItem(
                value: sizes.indexOf(size),
                child: Text(
                  size.sizeName,
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
              setState(() {
                _selectedSizeIndex = value ?? 0;
              });
            },
          ),
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
                      product.sizes[0].countAvailableNow.toString(),
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
                            product.sizes[0].total.toString(),
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
                    "",
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
}
