abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoriesLoadEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {
  final int categoryId;

  DeleteCategoryEvent(this.categoryId);
}

class CreateCategoryEvent extends CategoryEvent {
  final int parentCategotyId;
  final String name;

  CreateCategoryEvent(this.parentCategotyId, this.name);
}
