import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/controller/product_controller.dart';
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
  late ProductController _productController;

  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initProductsPreviews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsPreviewsLoadedState) {
          return _buildProductPreviewWidget(state.productsPreviews);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }
}

Widget _buildProductPreviewWidget(
    List<ProductPreviewResponse>? productsPreviews) {
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
                  childCount: productsPreviews?.length,
                  (BuildContext context, int index) {
                    ProductPreviewResponse productPreview =
                        productsPreviews![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                productId: productPreview.productId),
                          ),
                        );
                      },
                      child: productsPreviewGrid(productPreview),
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
