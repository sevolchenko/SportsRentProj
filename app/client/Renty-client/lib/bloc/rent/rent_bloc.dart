import 'package:client/api/dto/request/rent/extend_rent_event.dart';
import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/rent.dart';
import 'package:client/api/repository/rent_repository.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentBloc extends Bloc<RentEvent, RentState> {
  final RentRepository _rentRepository = RentRepository();
  late List<RentResponse> myRents = [];

  RentBloc() : super(RentsLoadingState()) {
    on<MyRentsLoadEvent>(
      (event, emit) async {
        myRents = await _rentRepository.getMyOngRents();
        emit(RentsLoadedState(rents: myRents));
      },
    );

    on<UserRentsLoadEvent>(
      (event, emit) async {
        myRents = await _rentRepository.getUserOngRents(event.userId);
        emit(RentsLoadedState(rents: myRents));
      },
    );

    // TODO body
    // on<FinishRentEvent>(
    //   (event, emit) async {
    //     await _rentRepository.finishUserRents(event.userId);
    //     myRents = await _rentRepository.getMyOngRents();
    //     emit(RentsLoadedState(rents: myRents));
    //   },
    // );

    on<StartRentEvent>((event, emit) async {
      StartRentEventRequest startRentRequest = StartRentEventRequest(
        productId: event.productId,
        sizeName: event.sizeName,
        count: event.count,
        startTime: event.startTime,
        endTime: event.endTime,
      );
      await _rentRepository.startRent(startRentRequest.toJson());
      myRents = await _rentRepository.getMyOngRents();
      emit(RentsLoadedState(rents: myRents));
    });

    on<ProlongRentEvent>(
      (event, emit) async {
        ExtendRentEventRequest eventRequest =
            ExtendRentEventRequest(newEndTime: event.newEndTime);
        await _rentRepository.prolongRent(event.rentId, eventRequest.toJson());
        myRents = await _rentRepository.getMyOngRents();
        emit(RentsLoadedState(rents: myRents));
      },
    );

    on<SearchUserRentsEvent>(
      (event, emit) async {
        var user = await _rentRepository.getUserData({"email": event.userEmail});
        var userRents = await _rentRepository.getUserOngRents(user!.userId);
        // myRents = await _rentRepository.getMyOngRents();
        emit(UserRentsLoadedState(userRents: userRents));
      },
    );
  }
}
