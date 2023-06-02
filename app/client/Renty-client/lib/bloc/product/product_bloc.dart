import 'package:client/api/dto/request/product.dart';
import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/product_preview.dart';
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
  late List<ProductPreviewResponse> productsPreviews;
  late List<CategoryResponse> categories;

  ProductBloc() : super(ProductLoadingState()) {
    on<ProductsPreviewsLoadEvent>(
      (event, emit) async {
        productsPreviews = await _productRepository.getProductsPreviews();
        emit(ProductsPreviewsLoadedState(productsPreviews: productsPreviews));
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

    on<ProductRentEvent>((event, emit) async {
      StartRentEventRequest rentEventCreateRequest = StartRentEventRequest(
          productId: event.productId,
          sizeName: event.sizeName,
          count: event.count,
          startTime: event.startTime,
          endTime: event.endTime);
      // await _productRepository.productRent(rentEventCreateRequest.toJson());
      emit(ProductLoadedState(productItem: product, sizes: product.sizes));
    });

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
      await _productRepository.productCreate(productCreateRequest.toJson());
      productsPreviews = await _productRepository.getProductsPreviews();
      emit(ProductsPreviewsLoadedState(productsPreviews: productsPreviews));
    });

    on<DeleteProductEvent>((event, emit) async {
      await _productRepository.productDelete(event.productId);
      productsPreviews = await _productRepository.getProductsPreviews();
      emit(ProductsPreviewsLoadedState(productsPreviews: productsPreviews));
    });

    // on<HomeProductItem>(_homeProductProjectionUtem);
  }

  // void _homeProductProjectionUtem(
  //     HomeProductItem event, Emitter<ProductLoadedState> emit) {
  //   emit(state.copyWith(productItem: event.productItem));
  // }
}
