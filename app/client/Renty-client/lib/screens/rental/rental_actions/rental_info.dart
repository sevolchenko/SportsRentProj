import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/global.dart';
import 'package:client/screens/rental/rental_actions/rental_extension.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RentalInfoScreen extends StatefulWidget {
  final RentResponse rentItem;

  const RentalInfoScreen({super.key, required this.rentItem});

  @override
  State<RentalInfoScreen> createState() => _RentalInfoScreenState();
}

class _RentalInfoScreenState extends State<RentalInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentBloc, RentState>(
      builder: (context, state) {
        return _buildRentInfoWidget();
        // if (state is RentsLoadedState) {
        //   return _buildRentInfoWidget();
        // } else if (state is RentsLoadingState) {
        //   return buildLoadingWidget();
        // } else {
        //   return buildErrorWidget();
        // }
      },
    );
  }

  Widget _buildRentInfoWidget() {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Информация об аренде",
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Global.appColor, width: 4),
                  ),
                  child: buildSmallProductImage(
                      widget.rentItem.product.mainImage!.image),
                ),
                buildTextInfo("Название", widget.rentItem.product.name),
                buildTextInfo("Цена", widget.rentItem.product.price.toString()),
                buildTextInfo("Количество", widget.rentItem.count.toString()),
                buildTextInfo("Размер", widget.rentItem.size.sizeName),
                buildTextInfo(
                  "Время начала аренды",
                  DateFormat('dd.MM.yyyy HH:mm')
                      .format(DateTime.parse(widget.rentItem.startTime))
                      .toString(),
                ),
                buildTextInfo(
                  "Время окончания аренды",
                  DateFormat('dd.MM.yyyy HH:mm')
                      .format(DateTime.parse(widget.rentItem.endTime))
                      .toString(),
                ),
                buildTextInfo(
                    "Длительность аренды", widget.rentItem.prettyDuration),
                SizedBox(
                  height: 10.h,
                ),
                buildButton("Продлить аренду", "primary", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RentalExtensionScreen(
                        rentId: widget.rentItem.rentId,
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 1),
      ),
    );
  }
}
