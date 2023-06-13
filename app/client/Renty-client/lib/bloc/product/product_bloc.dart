import 'package:client/api/dto/request/product/product.dart';
import 'package:client/api/dto/response/product/category.dart';
import 'package:client/api/dto/response/product/product.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/repository/category_repository.dart';
import 'package:client/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  late ProductResponse product;
  late List<ProductResponse> products;
  late List<ProductPreviewResponse> productsPreviews;
  List<CategoryResponse> categories = [];

  ProductBloc() : super(ProductLoadingState()) {
    on<ProductsPreviewsLoadEvent>(
      (event, emit) async {
        productsPreviews = await _productRepository.getProductsPreviews();
        categories = await _categoryRepository.getCategories();
        emit(ProductsPreviewsLoadedState(
            productsPreviews: productsPreviews, categories: categories));
      },
    );

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

    on<ProductUnAuthenticatedUserEvent>(
      (event, emit) async {
        // product = await _productRepository.getProductById(event.productId);
        emit(ProductUnAuthenticatedUserState());
      },
    );

    on<ProductsPreviewsSearchEvent>(
      (event, emit) async {
        productsPreviews = await _productRepository
            .getProductsPreviews(queryParameters: {"search": event.search});
        emit(ProductsPreviewsLoadedState(
            productsPreviews: productsPreviews, categories: categories));
      },
    );

    on<ProductsPreviewsSortEvent>((event, emit) async {
      emit(ProductLoadingState());
      productsPreviews =
          await _productRepository.getProductsPreviews(queryParameters: {
        "sort_by": event.sortValue.keys.first,
        "sort_direction": event.sortValue.values.first
      });
      emit(ProductsPreviewsLoadedState(
          productsPreviews: productsPreviews, categories: categories));
    });

    on<ProductsPreviewsFilterEvent>((event, emit) async {
      emit(ProductLoadingState());
      productsPreviews =
          await _productRepository.getProductsPreviews(queryParameters: {
        "category_filter": event.categoryId,
        "price_min_filter": event.minPrice,
        "price_max_filter": event.maxPrice,
      });
      emit(ProductsPreviewsLoadedState(
          productsPreviews: productsPreviews, categories: categories));
    });

    on<PreCreateProductEvent>(
      (event, emit) async {
        categories = await _categoryRepository.getCategories();
        emit(ProductInCreateState(categories: categories));
      },
    );

    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      ProductCreateRequest productCreateRequest = ProductCreateRequest(
          name: event.name,
          description: event.description,
          price: event.price,
          categoryId: event.categoryId,
          images: event.images);
      await _productRepository.productCreate(productCreateRequest.toJson());
      productsPreviews = await _productRepository.getProductsPreviews();
      var categories = await _categoryRepository.getCategories();
      emit(ProductsPreviewsLoadedState(
          productsPreviews: productsPreviews, categories: categories));
    });

    on<DeleteProductEvent>((event, emit) async {
      await _productRepository.productDelete(event.productId);
      productsPreviews = await _productRepository.getProductsPreviews();
      emit(ProductsPreviewsLoadedState(
          productsPreviews: productsPreviews, categories: categories));
    });

    // on<HomeProductItem>(_homeProductProjectionUtem);
  }

  // void _homeProductProjectionUtem(
  //     HomeProductItem event, Emitter<ProductLoadedState> emit) {
  //   emit(state.copyWith(productItem: event.productItem));
  // }
}
