import 'package:client/api/dto/request/category.dart';
import 'package:client/api/dto/response/category.dart';
import 'package:client/api/repository/category_repository.dart';
import 'package:client/bloc/category/category_event.dart';
import 'package:client/bloc/category/category_state.dart';
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

    on<DeleteCategoryEvent>(
      (event, emit) async {
        await _categoryRepository.deleteCategory(event.categoryId);
        categories = await _categoryRepository.getCategories();
        emit(CategoriesLoadedState(categories: categories));
      },
    );

    on<CreateCategoryEvent>((event, emit) async {
      CategoryCreateRequest categoryCreateRequest = CategoryCreateRequest(
          parentCategoryId: event.parentCategoryId, name: event.name);
      await _categoryRepository.createCategory(categoryCreateRequest.toJson());
      categories = await _categoryRepository.getCategories();
      emit(CategoriesLoadedState(categories: categories));
    });
  }
}
