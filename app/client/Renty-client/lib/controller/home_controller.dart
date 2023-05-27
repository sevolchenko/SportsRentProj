import 'package:client/api/apis/product_preview_api.dart';
import 'package:client/api/repository/home_repository.dart';
import 'package:client/bloc/home/home_bloc.dart';
import 'package:client/bloc/home/home_event.dart';
import 'package:client/common/values/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeController {
  final BuildContext context;
  // ProductPreviewApi _productPreviewApi = ProductPreviewApi();
  // HomeRepository _homeRepository = HomeRepository();
  HomeController({required this.context});

  void init() async {
    // EasyLoading.show(
    //   indicator: CircularProgressIndicator(),
    //   maskType: EasyLoadingMaskType.clear,
    //   dismissOnTap: true,
    // );
    // var result = await _homeRepository.getProducts();
    context.read<HomeBloc>().add(HomeLoadEvent());
    // EasyLoading.dismiss();
  }
}
