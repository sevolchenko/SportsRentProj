import 'dart:convert';
import 'dart:io';

import 'package:client/api/dto/request/product/image_create.dart';
import 'package:client/api/dto/response/product/category.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/global.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late final ProductController _productController;

  late String _enteredName;
  List<ImageCreateRequest> _images = [];
  ImageCreateRequest _image = ImageCreateRequest(position: 1, image: "");
  String _loadedPhoto = "";
  late int _price;
  String _description = "";

  late int _selectedCategoryId;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _productController = ProductController(context: context);
    _productController.initNewProduct();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInCreateState) {
          _selectedCategoryId = state.categories[0].categoryId;
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
          leading: false,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                buildTextField('Введите название', 'name', (value) {
                  _enteredName = value;
                }),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: DropdownButtonFormField(
                    value: _selectedCategoryId,
                    hint: const Text('Выберите категорию'),
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category.categoryId,
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
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Global.appColor, width: 4),
                  ),
                  child: _loadedPhoto == ""
                      ? Image.asset("assets/images/no_picture.jpg")
                      : Image.memory(
                          base64Decode(_loadedPhoto),
                          width: 130.h,
                          height: 130.h,
                        ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                buildButton(
                  "Добавить фото",
                  "secondary",
                  () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      final image = File(pickedFile.path);
                      List<int> imageBytes = image.readAsBytesSync();
                      _loadedPhoto = base64Encode(imageBytes);
                      _image.image = _loadedPhoto;
                      _image.position = 1;
                      _images.add(_image);
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                buildTextField('Введите цену за один час', 'price',
                    textInputType: TextInputType.number, (value) {
                  _price = int.parse(value);
                }),
                buildTextField('Введите описание', 'text', (value) {
                  _description = value;
                  // setState(() {});
                }),
                _description == ""
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.w)),
                          border: Border.all(color: Global.appColor, width: 2),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        padding: EdgeInsets.all(10.w),
                        child: reusableText(_description, textSize: 16),
                      ),
                buildButton(
                  "Добавить",
                  "primary",
                  () {
                    context.read<ProductBloc>().add(
                          CreateProductEvent(_selectedCategoryId, _enteredName,
                              _description, _price, _images),
                        );
                    toastInfo(msg: "Новый товар успешно добавлен");
                    setState(
                      () {
                        _selectedCategoryId = categories[0].categoryId;
                      },
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
