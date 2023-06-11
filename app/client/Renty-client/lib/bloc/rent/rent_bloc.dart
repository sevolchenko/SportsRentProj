import 'package:client/api/dto/request/rent/extend_rent_event.dart';
import 'package:client/api/dto/request/rent/finish_rent.dart';
import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/receipt.dart';
import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/api/dto/response/user/user.dart';
import 'package:client/repository/product_repository.dart';
import 'package:client/repository/rent_repository.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentBloc extends Bloc<RentEvent, RentState> {
  final RentRepository _rentRepository = RentRepository();
  final ProductRepository _productRepository = ProductRepository();
  late final List<RentResponse>? _finishRentResponse;
  late final ReceiptResponse? receipt;

  late List<RentResponse> myRents = [];

  RentBloc() : super(RentsLoadingState()) {
    on<MyRentsLoadEvent>(
      (event, emit) async {
        if (Global.storageService.isUserAuthenticated()) {
          myRents = await _rentRepository
              .getMyOngRents({"status_filter": "NOT_FINISHED"});
          emit(RentsLoadedState(rents: myRents));
        } else {
          emit(RentsUnAuthenticatedUserState());
        }
      },
    );

    on<FinishRentsEvent>(
      (event, emit) async {
        UserRentsFinishRequest finishRequest =
            UserRentsFinishRequest(rentsId: event.rentsIds);
        _finishRentResponse = await _rentRepository.finishUserRents(
            event.userId, finishRequest.toJson());
        final curReceipt = await _rentRepository
            .getMyReceipt(_finishRentResponse![0].receiptId!);
        receipt = ReceiptResponse(
            receiptId: curReceipt!.receiptId,
            user: curReceipt.user,
            employee: curReceipt.employee,
            payLink: curReceipt.payLink,
            createdAt: curReceipt.createdAt,
            sum: curReceipt.sum,
            status: curReceipt.status);
        // emit(UserRentsLoadedState(userId: event.userId, userRents: myRents));
        emit(PaymentRentsState(payLink: receipt!.payLink, sum: receipt!.sum));
      },
    );

    // on<PaymentRentsEvent>(
    //   (event, emit) async {

    //   },
    // );

    on<AddCartItemRentEvent>((event, emit) async {
      StartRentEventRequest startRentRequest = StartRentEventRequest(
        productId: event.productId,
        sizeName: event.sizeName,
        count: event.count,
        startTime: event.startTime,
        endTime: event.endTime,
      );
      final product =
          await _productRepository.getProductPreviewById(event.productId);
      Global.cart.addRentItem(startRentRequest, product);
      Global.storageService.saveCart(Global.cart);
      // emit(RentsLoadedState(rents: myRents));
    });

    on<ProlongRentEvent>(
      (event, emit) async {
        ExtendRentEventRequest eventRequest =
            ExtendRentEventRequest(newEndTime: event.newEndTime);
        await _rentRepository.prolongRent(event.rentId, eventRequest.toJson());
        myRents = await _rentRepository
            .getMyOngRents({"status_filter": "NOT_FINISHED"});
        emit(RentsLoadedState(rents: myRents));
      },
    );

    on<SearchUserRentsEvent>(
      (event, emit) async {
        emit(RentsLoadingState());
        try {
          UserResponse? user;
          user = await _rentRepository.getUserData({"email": event.userEmail});
          if (user != null) {
            myRents = await _rentRepository
                .getUserOngRents(user.userId, {"status_filter": "ONGOING"});
            emit(UserRentsLoadedState(userId: user.userId, userRents: myRents));
          } else {
            emit(UnsuccessfulUserSearchState());
          }
        } catch (e) {
          emit(RentsErrorState(errorMessage: e.toString()));
        }
      },
    );
  }
}
