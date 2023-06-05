import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/global.dart';
import 'package:client/screens/profile/employee/rental_completion/rental_payment.dart';
import 'package:client/screens/profile/employee/rental_completion/search_by_email.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalCompletionScreen extends StatefulWidget {
  final String userEmail;
  const RentalCompletionScreen({super.key, required this.userEmail});

  @override
  State<RentalCompletionScreen> createState() => _RentalCompletionScreenState();
}

class _RentalCompletionScreenState extends State<RentalCompletionScreen> {
  @override
  void initState() {
    // context.read<RentBloc>().add(SearchUserRentsEvent(widget.userEmail));
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
        if (state is UserRentsLoadedState) {
          return _buildUserRentsWidget(state.userId, state.userRents);
        }
        // else if (state is UnsuccessfulUserSearchState) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => const RentalSearchScreen(),
        //     ),
        //   );
        //   return buildLoadingWidget();
        // }
        else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildUserRentsWidget(int userId, List<RentResponse> rents) {
    return SafeArea(
        child: Scaffold(
      appBar: const MyAppBar(
        title: 'Завершение аренды',
        leading: false,
      ),
      body: rents.length == 0
          ? Container(
              alignment: Alignment.center,
              child: Text("Список аренд пуст",
                  style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    fontSize: 20.sp,
                  )),
            )
          : Container(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        child: buildTextInfo(
                            "Электронная почта клиента", widget.userEmail,
                            top: 10)),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 15.w,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.5,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: rents.length,
                        (BuildContext context, int index) {
                          RentResponse rentItem = rents[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.w),
                                border: Border.all(
                                    color: Global.appColor, width: 4),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            buildSmallProductImage(rentItem
                                                .product.mainImage!.image),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: Global.appColor,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      rentItem.product.name,
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
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.h,
                                                        left: 20.w,
                                                        right: 20.w),
                                                    padding: EdgeInsets.only(
                                                        top: 5.h),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 2.0,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        rentColumnText(
                                                            'Размер',
                                                            rentItem
                                                                .size.sizeName),
                                                        rentColumnText(
                                                            'Количество',
                                                            rentItem.count
                                                                .toString()),
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
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 2.0,
                                                color: Global.appColor),
                                          ),
                                        ),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              buildRentTime(rentItem.startTime,
                                                  rentItem.status),
                                              VerticalDivider(
                                                thickness: 2,
                                                color: Global.appColor,
                                              ),
                                              buildRentTime(rentItem.endTime,
                                                  rentItem.status),
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
                        padding: EdgeInsets.only(
                            left: 25.w, right: 25.w, bottom: 20.h),
                        child: buildButton(
                          "Сформировать счет",
                          "primary",
                          () {
                            context.read<RentBloc>().add(FinishRentsEvent(
                                userId,
                                rents.map((rent) => rent.rentId).toList()));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RentalPaymentScreen(),
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
