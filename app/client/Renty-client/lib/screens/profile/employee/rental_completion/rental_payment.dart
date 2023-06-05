import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/common/values/constant.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RentalPaymentScreen extends StatefulWidget {
  const RentalPaymentScreen({super.key});

  @override
  State<RentalPaymentScreen> createState() => _RentalPaymentScreenState();
}

class _RentalPaymentScreenState extends State<RentalPaymentScreen> {
  @override
  void initState() {
    // context.read<RentBloc>().add(PaymentRentsEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentBloc, RentState>(
      builder: (context, state) {
        if (state is PaymentRentsState) {
          return _buildRentsPaymentWidget(state.payLink, state.sum);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildRentsPaymentWidget(String paylink, int sum) {
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
                  child: QrImageView(data: "${AppConstants.SERVER_API_URL}${paylink}")
                ),
                buildTextInfo("К оплате", "${sum} рублей"),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
