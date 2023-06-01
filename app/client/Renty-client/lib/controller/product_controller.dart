import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/size/size_bloc.dart';
import 'package:client/bloc/size/size_event.dart';
import 'package:flutter/material.dart';
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

  void initProductsPreviews() async {
    context.read<ProductBloc>().add(ProductsPreviewsLoadEvent());
  }

  void initProductSizes(int productId) async {
    context.read<SizeBloc>().add(SizesLoadEvent(productId));
  }

  void initNewProduct() {
    context.read<ProductBloc>().add(PreCreateProductEvent());
  }
}
