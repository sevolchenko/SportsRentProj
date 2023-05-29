import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/rental/rent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalExtensionScreen extends StatefulWidget {
  const RentalExtensionScreen({super.key});

  @override
  State<RentalExtensionScreen> createState() => _RentalExtensionScreenState();
}

class _RentalExtensionScreenState extends State<RentalExtensionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const MyAppBar(
        title: 'Продление срока аренды',
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 70.h),
            reusableText('Новое время окончания аренды', textSize: 20),
            SizedBox(height: 10.h),
            buildTextField(
                '24.04.2023, 19:00', 'time', bottomMargin: 0, (value) {}),
            SizedBox(height: 30.h),
            buildButton("Продлить", "primary", () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RentScreen(),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 1),
    ));
  }
}
