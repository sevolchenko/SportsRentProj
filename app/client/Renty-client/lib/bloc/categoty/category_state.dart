import 'package:client/api/dto/response/category.dart';

abstract class CategoryState {}

class CategoriesLoadingState extends CategoryState {}

class CategoriesLoadedState extends CategoryState {
  final List<CategoryResponse> categories;

  CategoriesLoadedState({required this.categories});
}

class CategoryDeleteState extends CategoriesLoadedState {
  CategoryDeleteState({required super.categories});
}

class CategoriesErrorState extends CategoryState {
  CategoriesErrorState({required this.errorMessage});
  final String errorMessage;
}
