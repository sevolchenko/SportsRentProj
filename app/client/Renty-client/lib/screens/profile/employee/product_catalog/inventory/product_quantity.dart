import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/home/product/product_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/inventory_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h),
                  child: buildInventoryItem(
                      imagePath: "assets/images/image_2.png",
                      mainText: 'Велосипед горный Stels Focus',
                      price: "1000 Р/час"),
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
                    childAspectRatio: 5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: 10,
                    (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          // color: Colors.red,
                          margin: EdgeInsets.symmetric(horizontal: 50.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20.w),
                                child: Text(
                                  'Взрослый',
                                  style: GoogleFonts.raleway(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.sp),
                                ),
                              ),
                              const Icon(
                                FontAwesomeIcons.minus,
                                size: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  '1',
                                  style: GoogleFonts.raleway(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.sp),
                                ),
                              ),
                              Container(
                                child: const Icon(
                                  FontAwesomeIcons.plus,
                                  size: 20,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: const Icon(
                                    FontAwesomeIcons.trash,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
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
