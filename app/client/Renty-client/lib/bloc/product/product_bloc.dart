import 'package:client/api/dto/request/product_create.dart';
import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/api/repository/category_repository.dart';
import 'package:client/api/repository/product_repository.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  late ProductResponse product;
  late List<ProductResponse> products;
  late List<CategoryResponse> categories;

  ProductBloc() : super(ProductLoadingState()) {
    on<ProductsLoadEvent>(
      (event, emit) async {
        products = await _productRepository.getProducts();
        emit(ProductsLoadedState(products: products));
      },
    );
    on<ProductLoadEvent>(
      (event, emit) async {
        product = await _productRepository.getProductById(event.productId);
        emit(ProductLoadedState(productItem: product, sizes: product.sizes));
      },
    );

    on<PreCreateProductEvent>(
      (event, emit) async {
        categories = await _categoryRepository.getCategories();
        emit(ProductInCreateState(categories: categories));
      },
    );

    on<CreateProductEvent>((event, emit) async {
      ProductCreateRequest productCreateRequest = ProductCreateRequest(
          name: event.name,
          description: event.description,
          price: event.price,
          categoryId: event.categoryId,
          images: event.images);
      _productRepository.productCreate(productCreateRequest.toJson());
      emit(CreateProductState());
      // products = await _productRepository.getProducts();
    });

    // on<HomeProductItem>(_homeProductProjectionUtem);
  }

  // void _homeProductProjectionUtem(
  //     HomeProductItem event, Emitter<ProductLoadedState> emit) {
  //   emit(state.copyWith(productItem: event.productItem));
  // }
}
