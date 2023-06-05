import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/global.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:client/screens/rental/rental_actions/rental_info.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({super.key});

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  @override
  void initState() {
    context.read<RentBloc>().add(MyRentsLoadEvent());
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
        if (state is RentsLoadedState) {
          return _buildRentsWidget(state.rents);
        } else if (state is RentsUnAuthenticatedUserState) {
          return buildUnauthenticatedWidget(context);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildRentsWidget(List<RentResponse> rents) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Ваши аренды', leading: false),
      body: rents.length == 0
          ? Container(
              alignment: Alignment.center,
              child: Text("Список ваших аренд пуст",
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
                          RentResponse rent = rents[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RentalInfoScreen(
                                    rentItem: rent,
                                  ),
                                ),
                              );
                            },
                            child: rentGrid(rent),
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
