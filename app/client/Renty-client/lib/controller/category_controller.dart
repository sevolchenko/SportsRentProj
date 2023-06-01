import 'package:client/api/dto/response/category.dart';
import 'package:client/bloc/category/category_bloc.dart';
import 'package:client/bloc/category/category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryController {
  final BuildContext context;
  CategoryController({required this.context});

  void initCategories() async {
    context.read<CategoryBloc>().add(CategoriesLoadEvent());
  }

}
