import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:client/bloc/cart/cart_bloc.dart';
import 'package:client/bloc/cart/cart_event.dart';
import 'package:client/bloc/cart/cart_state.dart';
import 'package:client/common/service/cart.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/icons.dart';
import 'package:client/global.dart';
import 'package:client/screens/rental/widgets/rent_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          return _buildCartWidget(Global.cart);
        } else if (state is CartUnAuthenticatedUserState) {
          return buildUnauthenticatedWidget(context);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildCartWidget(Cart cart) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Корзина'),
      body: cart.setRents.length == 0
          ? Container(
              alignment: Alignment.center,
              child: Text("Корзина пуста",
                  style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    fontSize: 20.sp,
                  )),
            )
          : Container(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 10.w,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.7,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: cart.setRents.length,
                        (BuildContext context, int index) {
                          final cartItem = cart.setRents[index];
                          final productItem = cart.setProducts[index];
                          return GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.w),
                                  border: Border.all(
                                      color: Global.appColor, width: 4),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  buildSmallProductImage(
                                                      productItem
                                                          .mainImage!.image),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        left: 7.w),
                                                    child: Text(
                                                      "${productItem.price} Р/час"
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style:
                                                          GoogleFonts.raleway(
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                thickness: 2,
                                                color: Global.appColor,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5.w),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              productItem.name,
                                                              style: GoogleFonts.raleway(
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      18.sp),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.h,
                                                          left: 10.w,
                                                          right: 20.w),
                                                      padding: EdgeInsets.only(
                                                          top: 5.h),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 2.0,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          rentColumnText(
                                                              'Размер',
                                                              cartItem
                                                                  .sizeName),
                                                          rentColumnText(
                                                              'Количество',
                                                              cartItem.count
                                                                  .toString()),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: Global.appColor),
                                            ),
                                          ),
                                          child: IntrinsicHeight(
                                            child: Column(
                                              children: [
                                                IntrinsicHeight(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        buildRentTime(
                                                            cartItem.startTime,
                                                            ""),
                                                         VerticalDivider(
                                                          thickness: 2,
                                                          color: Global.appColor,
                                                        ),
                                                        buildRentTime(
                                                            cartItem.endTime,
                                                            ""),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                buildTrashIcon(context, () {
                                                  context.read<CartBloc>().add(
                                                      RemoveCartItemEvent(
                                                          startRentEventRequest:
                                                              cartItem,
                                                          product:
                                                              productItem));
                                                  Navigator.of(context).pop();
                                                }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
                      child: buildButton(
                        "Забронировать",
                        "secondary",
                        () {
                          AppMetrica.reportEvent('Product rented');
                          context.read<CartBloc>().add(RentCartItemsEvent(
                              startRentRequest: cart.setRents));
                          toastInfo(msg: "Успешно забронировано");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 2),
    );
  }
}
