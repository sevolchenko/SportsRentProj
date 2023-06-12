import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/category_controller.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/home/product/product_screen.dart';
import 'package:client/screens/home/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductController _productController;
  late CategoryController _categoryController;

  String search = "";
  Map<String, String> sortValue = {};

  Map<String, dynamic> _filterParams = {};

  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initProductsPreviews();

    _categoryController = CategoryController(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsPreviewsLoadedState) {
          return _buildProductPreviewWidget(state.productsPreviews);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductPreviewWidget(
      List<ProductPreviewResponse> productsPreviews) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
                margin: EdgeInsets.only(top: 30.h, left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    buildTextField(
                      "Поиск",
                      'search',
                      height: 45,
                      (value) {
                        search = value;
                        context
                            .read<ProductBloc>()
                            .add(ProductsPreviewsSearchEvent(search: search));
                      },
                    ),
                  ],
                )),
          ),
        ),
        body: productsPreviews.length == 0
            ? Container(
                alignment: Alignment.center,
                child: Text("Список товаров пуст",
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
                    SliverToBoxAdapter(
                      child: sortAndFilter(
                        context,
                        _categoryController,
                        sortFunc: (value) {
                          sortValue = value;
                          context.read<ProductBloc>().add(
                              ProductsPreviewsSortEvent(sortValue: sortValue));
                        },
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 15.w,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          childCount: productsPreviews.length,
                          (BuildContext context, int index) {
                            ProductPreviewResponse productPreview =
                                productsPreviews[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                        productId: productPreview.productId),
                                  ),
                                );
                              },
                              child: productsPreviewGrid(productPreview),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar: MyBottomNavBar(
          selectedIndex: 0,
        ),
      ),
    );
  }
}
