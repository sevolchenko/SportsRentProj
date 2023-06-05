import 'dart:convert';
import 'package:client/api/dto/response/product/product.dart';
import 'package:client/api/dto/response/product/size.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/global.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/home/product/datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({super.key, this.productId = 0});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductController _productController;
  late int _selectedSizeIndex;

  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();

  String startTime = "";
  String endTime = "";
  int count = 0;

  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initProduct(widget.productId);

    _selectedSizeIndex = 0;
  }

  void _handleStartDateTime(DateTime dateTime) {
    setState(() {
      _startDateTime = dateTime;
      startTime = dateTime.toUtc().toIso8601String();
    });
  }

  void _handleEndDateTime(DateTime dateTime) {
    setState(() {
      _endDateTime = dateTime;
      endTime = dateTime.toUtc().toIso8601String();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadedState) {
          return _buildProductWidget(state, state.productItem, state.sizes);
        } else if (state is ProductUnAuthenticatedUserState) {
          return buildUnauthenticatedWidget(context);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductWidget(
      ProductState state, ProductResponse product, List<SizeResponse> sizes) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Информация о товаре",
          backFun: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: buildProduct(state, product, sizes)),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 0),
      ),
    );
  }

  Widget buildProduct(
      ProductState state, ProductResponse product, List<SizeResponse> sizes) {
    return Column(
      children: [
        Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            border: Border.all(color: Global.appColor, width: 4),
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
            border: Border.all(color: Global.appColor, width: 2),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          padding: EdgeInsets.all(10.w),
          child: reusableText(product.description, textSize: 16),
        ),
        buildTextInfo("Цена", "${product.price} руб/час"),
        SizedBox(height: 50.h),
        reusableText("Размер"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: sizes.length == 0
              ? const Text("Размеры отсутсвуют")
              : DropdownButtonFormField(
                  value: _selectedSizeIndex,
                  hint: const Text('Выберите размер'),
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
        SizedBox(height: 50.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 110.h,
                child: Column(
                  children: [
                    reusableText("Всего доступно"),
                    SizedBox(
                      height: 5.h,
                    ),
                    sizes.length == 0
                        ? Text(0.toString())
                        : Text(
                            product.sizes[_selectedSizeIndex].countAvailableNow
                                .toString(),
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
                height: 110.h,
                child: Column(
                  children: [
                    reusableText("Количество"),
                    buildTextField("", "count",
                        width: 70,
                        textInputType: TextInputType.number, (value) {
                      count = int.parse(value);
                      setState(() {
                        if (count >
                            product
                                .sizes[_selectedSizeIndex].countAvailableNow) {
                          toastInfo(msg: "Недопустимое количество!");
                          count = product
                              .sizes[_selectedSizeIndex].countAvailableNow;
                        }
                      });
                    })
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
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          alignment: Alignment.center,
          child: MyDateTimePicker(onSaved: _handleStartDateTime),
        ),
        SizedBox(height: 20.h),
        reusableText('Время окончания аренды', textSize: 20),
        SizedBox(
          height: 5.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          alignment: Alignment.center,
          child: MyDateTimePicker(
            onSaved: _handleEndDateTime,
            startDateTime: _startDateTime,
          ),
        ),
        // SizedBox(height: 20.h),
        // buildButton("Уведомить по освобождении", "secondary", () {}),
        SizedBox(
          height: 20.h,
        ),
        buildButton("Добавить в корзину", "primary", () {
          if (Global.storageService.isUserAuthenticated()) {
            if (startTime == "" || endTime == "" || count == 0) {
              toastInfo(msg: "Заполните все необходимые поля!");
              setState(() {});
              return;
            }
            if (DateTime.now().isAfter(_startDateTime)) {
              toastInfo(msg: "Неверное время начала");
              setState(() {});
              return;
            }
            if (_startDateTime.isAfter(_endDateTime)) {
              toastInfo(msg: "Неверное время окончания");
              setState(() {});
              return;
            } else {
              context.read<RentBloc>().add(
                    AddCartItemRentEvent(
                      productId: product.id,
                      count: count,
                      sizeName: sizes[_selectedSizeIndex].sizeName,
                      startTime: startTime,
                      endTime: endTime,
                    ),
                  );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          } else {
            context.read<ProductBloc>().add(ProductUnAuthenticatedUserEvent());
          }
        }),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
