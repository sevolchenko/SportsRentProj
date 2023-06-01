import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalPaymentScreen extends StatefulWidget {
  const RentalPaymentScreen({super.key});

  @override
  State<RentalPaymentScreen> createState() => _RentalPaymentScreenState();
}

class _RentalPaymentScreenState extends State<RentalPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Оплата аренды',
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.w, right: 30.w),
                  width: 350.w,
                  height: 350.h,
                  child: Image.asset("assets/images/qr.png"),
                ),
                buildTextInfo("К оплате", "1000 рублей"),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
