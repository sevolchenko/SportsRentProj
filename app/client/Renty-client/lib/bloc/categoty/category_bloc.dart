import 'package:client/api/dto/request/category.dart';
import 'package:client/api/dto/response/category.dart';
import 'package:client/api/repository/category_repository.dart';
import 'package:client/bloc/categoty/category_event.dart';
import 'package:client/bloc/categoty/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository = CategoryRepository();
  late List<CategoryResponse> categories;

  CategoryBloc() : super(CategoriesLoadingState()) {
    on<CategoriesLoadEvent>(
      (event, emit) async {
        categories = await _categoryRepository.getCategories();
        emit(CategoriesLoadedState(categories: categories));
      },
    );

    on<CategoryDeleteEvent>(
      (event, emit) async {
        CategoryDeleteRequest categoryDeleteRequest =
            CategoryDeleteRequest(categoryId: event.categoryId);
        var jsonData = categoryDeleteRequest.toJson();
        _categoryRepository.deleteCategory(event.categoryId);
        emit(CategoryDeleteState(categories: categories));
      },
    );
  }
}
