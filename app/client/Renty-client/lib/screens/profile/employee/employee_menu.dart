import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/screens/profile/employee/product_catalog/catalog_menu.dart';
import 'package:client/screens/profile/employee/rental_completion/search_by_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmpoyeeMenu extends StatefulWidget {
  const EmpoyeeMenu({super.key});

  @override
  State<EmpoyeeMenu> createState() => _EmpoyeeMenuState();
}

class _EmpoyeeMenuState extends State<EmpoyeeMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Меню сотрудника",
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              buildButton(
                "Завершение аренды",
                "primary",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RentalSearchScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              buildButton(
                "Управление каталогом",
                "primary",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CatalogMenu(),
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
