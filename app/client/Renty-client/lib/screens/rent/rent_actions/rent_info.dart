import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentInfoScreen extends StatefulWidget {
  const RentInfoScreen({super.key});

  @override
  State<RentInfoScreen> createState() => _RentInfoScreenState();
}

class _RentInfoScreenState extends State<RentInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(title: "Информация об аренде"),
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
                buildTextInfo("Количество", "1 шт."),
                buildTextInfo("Размер", "взрослый"),
                buildTextInfo("Время начала аренды", "1000 руб/час"),
                buildTextInfo("Время окончания аренды", "1000 руб/час"),
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
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 1),
      ),
    );
  }
}