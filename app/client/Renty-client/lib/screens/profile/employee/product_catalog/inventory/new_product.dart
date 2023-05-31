import 'package:client/api/dto/response/category.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late final ProductController _productController;
  // List<CategoryResponse> categories = [];
  late int _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initNewProduct();
    _selectedCategoryId = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        // TODO не заходит в нужное состояние
        if (state is ProductInCreateState) {
          return _buildProductCreateWidget(state.categories);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductCreateWidget(List<CategoryResponse> categories) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Новый товар",
          backFun: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InventoryScreen(),
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                buildTextField(
                    'Введите название', 'name', (value) {}), //TODO тип ввода
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: DropdownButtonFormField(
                    value: _selectedCategoryId,
                    hint: Text('Выберите категорию'),
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: categories.indexOf(category),
                        child: Text(
                          category.name,
                          style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategoryId = value ?? 0;
                      });
                    },
                  ),
                ),
                Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 4),
                  ),
                  child: Image.asset("assets/images/image_2.png"),
                ),
                SizedBox(
                  height: 30.h,
                ),
                buildButton(
                  "Добавить фото",
                  "secondary",
                  () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const RentScreen(),
                    //   ),
                    // );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                buildTextField('Введите цену за один час', 'price', (value) {}),
                buildButton(
                  "Добавить",
                  "primary",
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InventoryScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
