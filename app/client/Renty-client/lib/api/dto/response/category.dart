class CategoryResponse {
  final int id;
  final String name;

  CategoryResponse({required this.id, required this.name});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(id: json['category_id'], name: json['name']);
  }
}

class CategoryFullResponse {
  final int id;
  final int parentCategotyId;
  final String name;

  CategoryFullResponse({required this.id, required this.parentCategotyId, required this.name});

  factory CategoryFullResponse.fromJson(Map<String, dynamic> json) {
    return CategoryFullResponse(id: json['category_id'], parentCategotyId: json['parent_category_id'], name: json['name']);
  }
}


class ListCategoriesFullResponse {
  final List<CategoryFullResponse> categories;
  final int size;

  ListCategoriesFullResponse({required this.categories, required this.size});

  factory ListCategoriesFullResponse.fromJson(Map<String, dynamic> json) {
    return ListCategoriesFullResponse(categories: json['categories'], size: json['size']);
  }
}