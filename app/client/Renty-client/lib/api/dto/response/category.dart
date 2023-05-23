class CategoryPreviewResponse {
  final int categoryId;
  final String name;

  CategoryPreviewResponse({required this.categoryId, required this.name});

  factory CategoryPreviewResponse.fromJson(Map<String, dynamic> json) {
    return CategoryPreviewResponse(
        categoryId: json['category_id'], name: json['name']);
  }
}

class CategoryResponse {
  final int categoryId;
  final CategoryPreviewResponse parentCategoty;
  final String name;

  CategoryResponse(
      {required this.categoryId,
      required this.parentCategoty,
      required this.name});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
        categoryId: json['category_id'],
        parentCategoty: json['parent_category'],
        name: json['name']);
  }
}

class CategoryListResponse {
  final List<CategoryResponse> categories;
  final int size;

  CategoryListResponse({required this.categories, required this.size});

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
        categories: json['categories'] = List<CategoryResponse>.from(
            json['categories'].map((x) => CategoryResponse.fromJson(x))),
        size: json['size']);
  }
}
