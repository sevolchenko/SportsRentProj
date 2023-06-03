import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/profile/employee/rental_completion/rental_payment.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalCompletionScreen extends StatefulWidget {
  const RentalCompletionScreen({super.key});

  @override
  State<RentalCompletionScreen> createState() => _RentalCompletionScreenState();
}

class _RentalCompletionScreenState extends State<RentalCompletionScreen> {
  int selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const MyAppBar(
        title: 'Завершение аренды',
      ),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: buildTextInfo(
                      "Электронная почта клиента", "example@gmail.com")),
            ),
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
                  childAspectRatio: 2.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 4,
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedItem = index;
                          // isSelected = !isSelected;
                        });
                        //TODO delete ot item tap
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          border: Border.all(
                              color: selectedItem == index
                                  ? Colors.grey
                                  : kPrimaryColor,
                              width: 4),
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
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Велосипед',
                                                style: GoogleFonts.raleway(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18.sp),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5.h,
                                                  left: 20.w,
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
                                                  rentColumnText(
                                                      'Количество', '1'),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildRentTime("23.04.23 15:00", ""),
                                        const VerticalDivider(
                                          thickness: 2,
                                          color: kPrimaryColor,
                                        ),
                                        buildRentTime("23.04.23 16:00", ""),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                  padding:
                      EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
                  child: buildButton(
                    "Сформировать счет",
                    "primary",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RentalPaymentScreen(),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
    ));
  }
}
