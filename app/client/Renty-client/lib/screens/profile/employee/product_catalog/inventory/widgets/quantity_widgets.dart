import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/size/size_bloc.dart';
import 'package:client/bloc/size/size_event.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size/new_size.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/inventory_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildProductQuantityWidget(
    BuildContext context, ProductResponse product) {
  return Container(
    child: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h),
            child: buildInventoryItem(
                image: product.images[0].image,
                mainText: product.name,
                price: "${product.price} Р/час"),
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
              childAspectRatio: 5,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: product.sizes.length,
              (BuildContext context, int index) {
                return GestureDetector(
                    child: buildSizesChangeWidget(product, index,
                        product.sizes[index], context));
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
            child: buildButton(
              "Добавить размер",
              "secondary",
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductSizeScreen(
                      product: product,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSizesChangeWidget(ProductResponse product, 
    int sizeIndex, SizeResponse productSize, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30.w),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 120.w,
            // color: Colors.red,
            // margin: EdgeInsets.only(right: 20.w),
            child: Text(
              productSize.sizeName,
              maxLines: 1,
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp),
            ),
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.minus,
              size: 25,
            ),
            onPressed: () {
              if (productSize.total <= 1) {
                toastInfo(msg: "Минимальное значение: 1");
              }
              context.read<SizeBloc>().add(
                    ProductSizeUpdateEvent(product, sizeIndex,
                        productSize.total > 1 ? productSize.total - 1 : 1),
                  );
            },
          ),
          Container(
            child: Text(
              productSize.total.toString(),
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  fontSize: 22.sp),
            ),
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 25,
            ),
            onPressed: () {
              context.read<SizeBloc>().add(
                    ProductSizeUpdateEvent(
                        product, sizeIndex, productSize.total + 1),
                  );
            },
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Подтверждение удаления"),
                      content: const Text("Вы действительно хотите удалить?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Отмена"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<SizeBloc>().add(
                                  ProductSizeDeleteEvent(
                                      product.id, product.sizes[sizeIndex].sizeName),
                                );
                            Navigator.of(context).pop();
                            // context
                            //     .read<ProductBloc>()
                            //     .add(ProductLoadEvent(product.id));
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const InventoryScreen(),
                            //   ),
                            // );
                          },
                          child: const Text("Удалить"),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.only(left: 15.w),
              child: const Icon(
                FontAwesomeIcons.trash,
                size: 30,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
