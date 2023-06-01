import 'package:client/api/dto/response/category.dart';
import 'package:client/bloc/category/category_bloc.dart';
import 'package:client/bloc/category/category_event.dart';
import 'package:client/bloc/category/category_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewCategoryScreen extends StatefulWidget {
  final List<CategoryResponse> categories;
  const NewCategoryScreen({super.key, required this.categories});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  late int _selectedCategoryId = widget.categories[0].categoryId;
  late String _categoryname = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoriesLoadedState) {
          return _buildNewCategoryWidget();
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildNewCategoryWidget() {
    List<CategoryResponse> categories = widget.categories;
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Новая категория",
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              buildTextField('Введите название', 'category', (value) {
                _categoryname = value;
              }),
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: DropdownButtonFormField(
                  value: _selectedCategoryId,
                  hint: Text('Выберите категорию'),
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
                      _selectedCategoryId = value ?? categories[0].categoryId;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              buildButton(
                "Добавить",
                "primary",
                () {
                  context.read<CategoryBloc>().add(
                      CreateCategoryEvent(_selectedCategoryId, _categoryname));
                  toastInfo(msg: "Новая категория успешно добавлена");
                  setState(
                    () {
                      _selectedCategoryId = categories[0].categoryId;
                    },
                  );
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
