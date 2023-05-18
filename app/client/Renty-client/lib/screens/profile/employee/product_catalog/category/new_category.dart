import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/profile/employee/product_catalog/category/categoty_managment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Новая категория",
          autoLeading: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              buildTextField(
                  'Введите название', '', (value) {}), //TODO тип ввода
              SizedBox(
                height: 30.h,
              ),
              buildTextField('Родительская категория', 'category', (value) {}),
              SizedBox(
                height: 50.h,
              ),
              buildButton(
                "Добавить",
                "primary",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CategoryManagmentScreen(),
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
