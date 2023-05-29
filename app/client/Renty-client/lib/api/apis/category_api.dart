import 'package:client/api/dto/response/category.dart';
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
    var statusCode = await HttpUtil().delete(path, null);
    try {
      if (statusCode == 200) {
        return statusCode;
      } 
    } on DioError catch (e) {
      toastInfo(msg: e.toString());
    }
    return null;
  }
}
