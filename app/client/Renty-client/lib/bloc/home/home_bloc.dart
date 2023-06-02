import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/api/repository/home_repository.dart';
import 'package:client/bloc/home/home_event.dart';
import 'package:client/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   late List<ProductPreviewResponse> productPreviews;
//   final HomeRepository _homeRepository = HomeRepository();
//   HomeBloc() : super(HomeLoadingState()) {
//     on<HomeLoadEvent>(
//       (event, emit) async {
//         productPreviews = await _homeRepository.getProducts();
//         emit(HomeLoadedState(productsPreview: productPreviews));
//       },
//     );
//   }
// }

// RXDART:
// class HomeBloc {
//   final HomeRepository _repository = HomeRepository();
//   final BehaviorSubject<List<ProductPreviewResponse>> _subject =
//       BehaviorSubject<List<ProductPreviewResponse>>();

//   getProductsPreview() async {
//     List<ProductPreviewResponse> response = await _repository.getProducts();
//     _subject.sink.add(response);
//     return response;
//   }

//   dispose() {
//     _subject.close();
//   }

//   BehaviorSubject<List<ProductPreviewResponse>> get subject => _subject;
// }

// final bloc = HomeBloc();
