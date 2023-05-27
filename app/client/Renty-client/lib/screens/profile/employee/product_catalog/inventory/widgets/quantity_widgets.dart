import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/inventory_widgets.dart';
import 'package:flutter/material.dart';
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
                image: product.images?[0].image,
                mainText: product.name ?? "",
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
              childCount: product.sizes?.length,
              (BuildContext context, int index) {
                return GestureDetector(
                    child: buildSizesChangeWidget(product.sizes![index]));
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
                    builder: (context) => const ProductSizeScreen(),
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

Widget buildSizesChangeWidget(SizeResponse productSize) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
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
        const Icon(
          FontAwesomeIcons.minus,
          size: 25,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            productSize.total.toString(),
            style: GoogleFonts.raleway(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                fontSize: 22.sp),
          ),
        ),
        Container(
          child: const Icon(
            FontAwesomeIcons.plus,
            size: 25,
          ),
        ),
        GestureDetector(
          onTap: () {},
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
  );
}
