class CategoryCreateRequest {
  final int parentCategoryId;
  final String name;

  CategoryCreateRequest({required this.parentCategoryId, required this.name});

  Map<String, dynamic> toJson() => {
        'parent_category_id': parentCategoryId,
        'name': name,
      };
}