import 'package:client/api/apis/category_api.dart';
import 'package:client/api/dto/response/category.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';

class CategoryRepository {
  final CategoryApi _categorytApi = CategoryApi();

  Future<List<CategoryResponse>> getCategories() {
    return _categorytApi.getCategories();
  }

  Future<void> deleteCategory(int id) async {
    await _categorytApi.deleteCategoryById(id);
  }

  Future<void> createCategory(Map<String, dynamic> body) async {
    await _categorytApi.createCategory(body);
  }
}
