import 'package:client/bloc/application/application_bloc.dart';
import 'package:client/bloc/application/application_state.dart';
import 'package:client/bloc/home/home_bloc.dart';
import 'package:client/bloc/home/home_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Container(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: sortAndFilter(),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 15.w,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: 4,
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: productsGrid(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
