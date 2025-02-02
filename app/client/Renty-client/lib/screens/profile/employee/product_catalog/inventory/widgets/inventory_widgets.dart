import 'package:client/api/dto/response/product/product.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/global.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildInventoryItem(
    {String? image, String mainText = '', String price = ''}) {
  return Container(
    width: 290.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      border: Border.all(color: Global.appColor, width: 4),
    ),
    child: Row(
      children: [
        image != null
            ? buildSmallProductImage(image)
            : Image.asset("assets/images/no_picture.jpg"),
        VerticalDivider(
          thickness: 2,
          color: Global.appColor,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10.h),
                margin: EdgeInsets.only(left: 10.h, right: 10.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 2.0, color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                child: Text(
                  mainText,
                  style: GoogleFonts.raleway(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 2.h, right: 10.w),
                child: Text(
                  price,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.raleway(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget inventoryItemGrid(ProductPreviewResponse product, BuildContext context) {
  return Row(
    children: [
      buildInventoryItem(
          image: product.mainImage!.image,
          mainText: product.name,
          price: "${product.price} Р/час"),
      Container(
        margin: EdgeInsets.only(left: 10.w),
        child: buildTrashIcon(context, () {
          context
              .read<ProductBloc>()
              .add(DeleteProductEvent(product.productId));
          Navigator.of(context).pop();
        }),
      ),
    ],
  );
}
