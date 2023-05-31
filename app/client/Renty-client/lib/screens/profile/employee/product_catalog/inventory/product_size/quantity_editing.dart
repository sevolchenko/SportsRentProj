import 'package:client/api/dto/response/product.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/bloc/size/size_bloc.dart';
import 'package:client/bloc/size/size_state.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/quantity_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductQuantityScreen extends StatefulWidget {
  final ProductResponse? product;

  const ProductQuantityScreen({super.key, this.product});

  @override
  State<ProductQuantityScreen> createState() => _ProductQuantityScreenState();
}

class _ProductQuantityScreenState extends State<ProductQuantityScreen> {
  late ProductController _productController;
  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initProduct(widget.product!.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SizeBloc, SizeState>(
      builder: (context, state) {
        return _buildProductQuantity(context, widget.product!);
      },
    );  
  }

  Widget _buildProductQuantity(BuildContext context, ProductResponse product) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Редактирование количества",
          backFun: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InventoryScreen(),
              ),
            );
          },
        ),
        body: buildProductQuantityWidget(context, product),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
