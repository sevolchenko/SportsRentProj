import 'package:client/api/dto/response/product.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/new_product.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_quantity.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/inventory_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late ProductController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = ProductController(context: context);
    _homeController.initProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoadedState) {
          return _buildProductsWidget(state.products);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductsWidget(List<ProductResponse> products) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Инвентарь",
          autoLeading: true,
        ),
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: buildTextField("Поиск", 'search', (value) {}),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 10.w,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: products.length,
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductQuantityScreen(
                                  productId: products[index].id),
                            ),
                          );
                        },
                        child: productsGrid(products[index], context),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
                  child: buildButton(
                    "Добавить товар",
                    "secondary",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NewProductScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
