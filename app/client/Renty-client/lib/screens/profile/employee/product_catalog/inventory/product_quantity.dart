import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/home/product/product_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductQuantityScreen extends StatefulWidget {
  const ProductQuantityScreen({super.key});

  @override
  State<ProductQuantityScreen> createState() => _ProductQuantityScreenState();
}

class _ProductQuantityScreenState extends State<ProductQuantityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Редактирование количества",
          autoLeading: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              buildButton(
                "Добавить размер",
                "secondary",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProductSizeScreen(),
                    ),
                  );
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
