import 'package:client/api/dto/response/product/category.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class CategoryApi {
  Future<List<CategoryResponse>> getCategories() async {
    var path = 'catalog/categories';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res = List<CategoryResponse>.from(
        jsonData.map((x) => CategoryResponse.fromJson(x)));
    return res;
  }

  Future<int?> deleteCategoryById(int categoryId) async {
    var path = 'catalog/categories/${categoryId}';
    try {
      var statusCode = await HttpUtil().delete(path, null);
      if (statusCode == 200) {
        toastInfo(msg: "Категория успешно удалена");
        return statusCode;
      }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при удалении категории");
    }
    return null;
  }

  Future<int?> createCategory(Map<String, dynamic> body) async {
    var path = 'catalog/categories';
    try {
      var code = await HttpUtil().post(path, data: body);
      if (code == 200) {
        toastInfo(msg: "Новая категория успешно добавлена");
        return code;
      }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при создании категории");
    }
    return null;
  }
}
