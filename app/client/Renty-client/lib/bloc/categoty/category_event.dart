import 'package:client/api/dto/request/category.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoriesLoadEvent extends CategoryEvent {}

// class CategoryAddEvent extends CategoryEvent {
//   final int categoryId;
//   final int sizeIndex;

//   CategoryAddEvent(this.categoryId, this.sizeIndex);
// }

class DeleteCategoryEvent extends CategoryEvent {
  final int categoryId;

  DeleteCategoryEvent(this.categoryId);
}

class CreateCategoryEvent extends CategoryEvent {
  final int parentCategotyId;
  final String name;

  CreateCategoryEvent(this.parentCategotyId, this.name);
}
