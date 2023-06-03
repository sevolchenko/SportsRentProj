import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/global.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:client/screens/rental/rental_actions/rental_info.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
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
      body: Global.storageService.isUserAuthenticated() ? Container(
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
                  childAspectRatio: 2.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 4,
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RentalInfoScreen(),
                          ),
                        );
                      },
                      child: rentGrid(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ) : buildUnauthenticatedWidget(context),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 1),
    );
  }
}
