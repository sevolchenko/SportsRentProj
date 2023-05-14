import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:client/screens/rent/rent_actions/rent_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({super.key});

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Ваши аренды'),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 40.h,
                horizontal: 15.w,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 4,
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          border: Border.all(color: kPrimaryColor, width: 4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                    left: 5.w,
                                  ),
                                  child: Image.asset(
                                    "assets/images/image_2.png",
                                    width: 90.w,
                                    height: 90.w,
                                  ),
                                ),
                                Container(
                                  // padding: EdgeInsets.only(
                                  //     top: 3.h, left: 3.w, right: 3.w),
                                  child: Text(
                                    "23.04.23 15:00",
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RentInfoScreen(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: const Icon(
                                      FontAwesomeIcons.circleInfo,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 3.h,
                                    left: 5.w,
                                    bottom: 3.h,
                                  ),
                                  child: Image.asset(
                                    "assets/images/image_2.png",
                                    width: 80.w,
                                    height: 80.w,
                                  ),
                                ),
                              ],
                            ),
                            // const VerticalDivider(
                            //   endIndent: 70,
                            //   thickness: 2,
                            //   color: kPrimaryColor,
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 1),
    );
  }
}
