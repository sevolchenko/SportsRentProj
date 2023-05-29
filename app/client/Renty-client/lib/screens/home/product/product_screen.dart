import 'dart:convert';

import 'package:client/api/dto/response/product.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/home/product/product_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({super.key, this.productId = 0});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductController _productController;
  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initProduct(widget.productId);

    // bloc.getProductById(widget.productId);
  }

  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadedState) {
          return _buildProductWidget(state.productItem);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductWidget(ProductResponse? product) {
    var currentSize = product!.sizes[0].sizeName;
    List<String> sizeNames =
        product.sizes.map((size) => size.sizeName).toList();
    if (currentSize == "") {
      currentSize = sizeNames.first;
    }
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Информация о товаре",
        ),
        body: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: buildProduct(product)),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 0),
      ),
    );
  }
}
