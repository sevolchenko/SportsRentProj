import 'package:client/api/apis/product_api.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductController {
  final BuildContext context;
  ProductController({required this.context});

  void initProduct(int productId) async {
    context.read<ProductBloc>().add(ProductLoadEvent(productId));
  }

  void initProducts() async {
    context.read<ProductBloc>().add(ProductsLoadEvent());
  }

  void productSizeUpdate(
      ProductResponse product, int sizeIndex, int newTotal) async {
    context
        .read<ProductBloc>()
        .add(ProductSizeUpdateEvent(product, sizeIndex, newTotal));
  }
}
