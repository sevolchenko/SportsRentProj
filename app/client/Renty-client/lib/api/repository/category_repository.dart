import 'package:client/api/apis/category_api.dart';
import 'package:client/api/dto/response/category.dart';

class CategoryRepository {
  final CategoryApi _categorytApi = CategoryApi();

  Future<List<CategoryResponse>> getCategories() {
    return _categorytApi.getCategories();
  }

  Future<int?> deleteCategory(int id) {
    return _categorytApi.deleteCategoryById(id);
  }
}
