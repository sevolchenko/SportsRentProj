import 'package:client/api/dto/response/product/product.dart';
import 'package:client/bloc/size/size_bloc.dart';
import 'package:client/bloc/size/size_event.dart';
import 'package:client/bloc/size/size_state.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSizeScreen extends StatefulWidget {
  final ProductResponse? product;

  const ProductSizeScreen({super.key, this.product});

  @override
  State<ProductSizeScreen> createState() => _ProductSizeScreenState();
}

class _ProductSizeScreenState extends State<ProductSizeScreen> {
  late String _sizeName = "";
  late int _sizeCount = 0;

  @override
  void initState() {
    super.initState();
    // context.read<SizeBloc>().add(());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SizeBloc, SizeState>(
      builder: (context, state) {
        return _buildNewSizeWidget();
      },
    );
  }

  Widget _buildNewSizeWidget() {
    return SafeArea(
      child: Scaffold(
        appBar:  MyAppBar(
          title: "Новый размер",
          backFun:  () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InventoryScreen(),
              ),
            );
          },
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              buildTextField('Введите размер', 'size', (value) {
                _sizeName = value;
              }),
              SizedBox(
                height: 30.h,
              ),
              buildTextField('Введите количество', 'quantity',
                  textInputType: TextInputType.number, (value) {
                _sizeCount = int.parse(value);
              }),
              SizedBox(
                height: 20.h,
              ),
              buildButton(
                "Добавить",
                "primary",
                () {
                  context.read<SizeBloc>().add(ProductSizeCreateEvent(
                      widget.product!.id, _sizeName, _sizeCount));
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
