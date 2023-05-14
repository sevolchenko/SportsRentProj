import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(title: "Информация о товаре"),
        body: SingleChildScrollView(
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
                  child: Image.asset("assets/images/image_2.png"),
                ),
                buildTextInfo("Название", "Велосипед Горный Stels Focus"),
                buildTextInfo("Цена", "1000 руб/час"),
                SizedBox(height: 20.h),
                reusableText('Время начала аренды', Colors.black, textSize: 20),
                buildTextField(
                    '24.04.2023, 16:00', 'time', bottomMargin: 0, (value) {}),
                SizedBox(height: 20.h),
                reusableText('Время окончания аренды', Colors.black,
                    textSize: 20),
                buildTextField(
                    '24.04.2023, 17:00', 'time', bottomMargin: 0, (value) {}),
                buildTextInfo("Длительность аренды", "01:00:00"),
                SizedBox(
                  height: 10.h,
                ),
                buildButton("Уведомить по освобождении", "secondary", () {}),
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
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 0),
      ),
    );
  }
}
