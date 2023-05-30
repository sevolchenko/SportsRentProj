import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/screens/cart/widgets/cart_widgets.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/new_product.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size/quantity_editing.dart';
import 'package:client/screens/rental/rental_actions/rental_info.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Корзина'),
      body: Container(
        child: CustomScrollView(
          slivers: [
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
                  childAspectRatio: 1.95,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 10,
                  (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            border: Border.all(color: kPrimaryColor, width: 4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        buildSmallProductImage(
                                            "assets/images/image_2.png"),
                                        const VerticalDivider(
                                          thickness: 2,
                                          color: kPrimaryColor,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Велосипед, ',
                                                      style:
                                                          GoogleFonts.raleway(
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 18.sp),
                                                    ),
                                                  ),
                                                  Text(
                                                    '1000 Р/час',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                    style: GoogleFonts.raleway(
                                                        color: Colors.black,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18.sp),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 5.h,
                                                    left: 10.w,
                                                    right: 20.w),
                                                padding:
                                                    EdgeInsets.only(top: 5.h),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 2.0,
                                                        color: Colors.black
                                                            .withOpacity(0.6)),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    rentColumnText(
                                                        'Размер', 'детский'),
                                                    Container(
                                                      child: cartColumnQuantity(
                                                          'Количество', '1'),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 2.0, color: kPrimaryColor),
                                      ),
                                    ),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        children: [
                                          IntrinsicHeight(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  buildRentTime(
                                                      "23.04.23 15:00"),
                                                  const VerticalDivider(
                                                    thickness: 2,
                                                    color: kPrimaryColor,
                                                  ),
                                                  buildRentTime(
                                                      "23.04.23 16:00"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5.h),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RentalInfoScreen(),
                                                  ),
                                                );
                                              },
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: const Icon(
                                                  FontAwesomeIcons.trash,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
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
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 2),
    );
  }
}
