import 'package:client/api/dto/response/category.dart';
import 'package:client/api/repository/category_repository.dart';
import 'package:client/bloc/category/category_bloc.dart';
import 'package:client/bloc/category/category_event.dart';
import 'package:client/bloc/category/category_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/controller/category_controller.dart';
import 'package:client/screens/profile/employee/product_catalog/catalog_menu.dart';
import 'package:client/screens/profile/employee/product_catalog/category/new_category.dart';
import 'package:client/screens/profile/employee/product_catalog/category/widgets/category_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = CategoryController(context: context);
    _categoryController.initCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoriesLoadedState) {
          return _buildCategoriesWidget(state.categories);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildCategoriesWidget(List<CategoryResponse> categories) {
    // context.read<CategoryBloc>().add(CategoriesLoadEvent());
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Категории",
          backFun: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CatalogMenu(),
              ),
            );
          },
        ),
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 15.w,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: categories.length,
                    (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {},
                          child:
                              buildCategoryWidget(categories[index], context));
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
                  child: buildButton(
                    "Добавить категорию",
                    "secondary",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              NewCategoryScreen(categories: categories),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
