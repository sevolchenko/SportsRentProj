import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/home/product/product_widgets/datetime_picker.dart';
import 'package:client/screens/rental/rent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentalExtensionScreen extends StatefulWidget {
  final RentResponse rent;
  const RentalExtensionScreen({super.key, required this.rent});

  @override
  State<RentalExtensionScreen> createState() => _RentalExtensionScreenState();
}

class _RentalExtensionScreenState extends State<RentalExtensionScreen> {
  String _newEndDateTime = "";

  @override
  void initState() {
    // context.read<RentBloc>().add();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentBloc, RentState>(
      builder: (context, state) {
        // return _buildRentExtensionWidget();
        if (state is RentsLoadedState) {
          return _buildRentExtensionWidget();
        } else if (state is RentsLoadingState) {
          return buildLoadingWidget();
        } else {
          return buildErrorWidget();
        }
      },
    );
  }

  void _handleDateTime(DateTime dateTime) {
    setState(() {
      _newEndDateTime = dateTime.toUtc().toIso8601String();
    });
  }

  Widget _buildRentExtensionWidget() {
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
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: MyDateTimePicker(onSaved: _handleDateTime),
            ),
            SizedBox(height: 30.h),
            buildButton("Продлить", "primary", () {
              if (_newEndDateTime == "") {
                toastInfo(msg: "Выберите новое время аренды!");
                setState(() {});
                return;
              }
              if (widget.rent.status == "EXPIRED") {
                toastInfo(msg: "Нельзя продлить просроченную аренду!");
                return;
              }
              if (widget.rent.status == "CREATED") {
                toastInfo(msg: "Нельзя продлить еще не начатую аренду!");
                return;
              }
              AppMetrica.reportEvent('Product rental extended');
              context
                  .read<RentBloc>()
                  .add(ProlongRentEvent(widget.rent.rentId, _newEndDateTime));

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
