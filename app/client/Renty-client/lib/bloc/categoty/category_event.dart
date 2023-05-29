abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoriesLoadEvent extends CategoryEvent {}

// class CategoryAddEvent extends CategoryEvent {
//   final int categoryId;
//   final int sizeIndex;

//   CategoryAddEvent(this.categoryId, this.sizeIndex);
// }


class CategoryDeleteEvent extends CategoryEvent {
  final int categoryId;
  final int sizeIndex;

  CategoryDeleteEvent(this.categoryId, this.sizeIndex);
}