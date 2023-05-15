import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/profile/employee/rental_completion/rental_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalCompletionScreen extends StatefulWidget {
  const RentalCompletionScreen({super.key});

  @override
  State<RentalCompletionScreen> createState() => _RentalCompletionScreenState();
}

class _RentalCompletionScreenState extends State<RentalCompletionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const MyAppBar(
        title: 'Завершение аренды',
        autoLeading: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextInfo("Электронная почта клиента", "example@gmail.com"),
              SizedBox(
                height: 20.h,
              ),
              buildButton("Сформировать счет", "primary", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RentalPaymentScreen(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
    ));
  }
}
