import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSizeScreen extends StatefulWidget {
  const ProductSizeScreen({super.key});

  @override
  State<ProductSizeScreen> createState() => _ProductSizeScreenState();
}

class _ProductSizeScreenState extends State<ProductSizeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Новый размер",
          autoLeading: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              buildTextField('Введите размер', '', (value) {}), //TODO тип ввода
              SizedBox(
                height: 30.h,
              ),
              buildTextField('Введите количество', 'size', (value) {}),
              SizedBox(
                height: 50.h,
              ),
              buildButton(
                "Добавить",
                "primary",
                () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const RentScreen(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
