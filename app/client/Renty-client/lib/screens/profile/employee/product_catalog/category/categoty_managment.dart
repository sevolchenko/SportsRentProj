import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/category/new_category.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryManagmentScreen extends StatefulWidget {
  const CategoryManagmentScreen({super.key});

  @override
  State<CategoryManagmentScreen> createState() =>
      _CategoryManagmentScreenState();
}

class _CategoryManagmentScreenState extends State<CategoryManagmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Категории",
          autoLeading: true,
        ),
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 15.w,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: 4,
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              width: 270.w,
                              // color: Colors.black,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.w),
                                border:
                                    Border.all(color: kPrimaryColor, width: 4),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text(
                                      'Горные велосипеды',
                                      style: GoogleFonts.raleway(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20.sp),
                                    ),
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(right: 100.w),
                                    // color: Colors.green,
                                    child: Text(
                                      'Велосипеды',
                                      style: GoogleFonts.raleway(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20.w),
                              child: buildTrashIcon(context, () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              }),
                            )
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
                    "Добавить категорию",
                    "secondary",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NewCategoryScreen(),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
