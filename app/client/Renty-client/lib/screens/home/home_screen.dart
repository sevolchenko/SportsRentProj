import 'dart:io';

import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/bloc/home/home_bloc.dart';
import 'package:client/bloc/home/home_state.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/controller/home_controller.dart';
import 'package:client/screens/home/product/product_screen.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _homeController = HomeController(context: context);
    _homeController.init();
    // bloc.getProductsPreview();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadedState) {
          return _buildProductPreviewWidget(state.productsPreview);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }
}

Widget _buildProductPreviewWidget(
    List<ProductPreviewResponse>? productsPreview) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Container(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: productsPreview?.length,
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ProductBloc>()
                            .add(ProductLoadEvent(productsPreview[index].productId));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                productId: productsPreview[index].productId),
                          ),
                        );
                      },
                      child: productsPreviewGrid(productsPreview![index]),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: 0,
      ),
    ),
  );
}
