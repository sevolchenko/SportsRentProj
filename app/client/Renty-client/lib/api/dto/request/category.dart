class CategoryCreateRequest {
  final int? parentCategoryId;
  final String name;

  CategoryCreateRequest({this.parentCategoryId, required this.name});

  Map<String, dynamic> toJson() => {
        'parent_category_id': parentCategoryId,
        'name': name,
      };
}

class CategoryDeleteRequest {
  final int categoryId;

  CategoryDeleteRequest({required this.categoryId});

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
      };
}
