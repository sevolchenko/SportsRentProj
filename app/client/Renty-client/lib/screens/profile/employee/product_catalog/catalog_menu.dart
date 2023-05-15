import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogMenu extends StatefulWidget {
  const CatalogMenu({super.key});

  @override
  State<CatalogMenu> createState() => _CatalogMenuState();
}

class _CatalogMenuState extends State<CatalogMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Управление каталогом",
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
                "Управление инвентарем",
                "primary",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InventoryScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              buildButton(
                "Управление категориями",
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
