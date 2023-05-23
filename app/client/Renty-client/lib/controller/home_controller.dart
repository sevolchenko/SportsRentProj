import 'package:client/api/apis/product_projection_api.dart';
import 'package:client/bloc/home/home_bloc.dart';
import 'package:client/bloc/home/home_event.dart';
import 'package:client/common/values/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeController {
  final BuildContext context;
  HomeController({required this.context});

  void init() async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await ProductProjectionApi.productProjList();
    context.read<HomeBloc>().add(HomeProductProjectionItem(result.projections));
    EasyLoading.dismiss();
  }
}
