import 'package:client/api/dto/response/product.dart';
import 'package:client/bloc/size/size_bloc.dart';
import 'package:client/bloc/size/size_event.dart';
import 'package:client/bloc/size/size_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/quantity_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductQuantityScreen extends StatefulWidget {
  final int productId;

  const ProductQuantityScreen({super.key, this.productId=0});

  @override
  State<ProductQuantityScreen> createState() => _ProductQuantityScreenState();
}

class _ProductQuantityScreenState extends State<ProductQuantityScreen> {
  late ProductController _productController;


  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initProductSizes(widget.productId);
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SizeBloc, SizeState>(
      builder: (context, state) {
        if (state is SizesLoadedState) {
          return _buildProductQuantity(context, state.product);
        } else {
          return buildLoadingWidget();
        }
        
      },
    );
  }

  Widget _buildProductQuantity(BuildContext context, ProductResponse product) {
    context.read<SizeBloc>().add(SizesLoadEvent(product.id));
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
