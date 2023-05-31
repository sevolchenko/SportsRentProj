abstract class SizeState {}

class SizeInitState extends SizeState {}

class ProductSizeCreateState extends SizeState {
  ProductSizeCreateState();
}

class ProductSizeDeleteState extends SizeState {
  ProductSizeDeleteState();
}

class ProductSizeCountUpdatedState extends SizeState {
  ProductSizeCountUpdatedState();
}
