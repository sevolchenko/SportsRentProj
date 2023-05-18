import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/new_product.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_quantity.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/inventory_widgets.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Инвентарь",
          autoLeading: true,
        ),
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: buildTextField("Поиск", 'search', (value) {}),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 10.w,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: 10,
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProductQuantityScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            buildInventoryItem(
                                imagePath: "assets/images/image_2.png", mainText: 'Велосипед горный Stels Focus', price: "1000 Р/час"),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: buildTrashIcon(() {}),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
                  child: buildButton(
                    "Добавить товар",
                    "secondary",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NewProductScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
